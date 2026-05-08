import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/trip_pricing_model.dart';

class SupabasePricingService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// حفظ طلب تحديد السعر
  Future<TripPricingModel?> saveTripPricingRequest(
    TripPricingModel tripPricing,
  ) async {
    try {
      final response = await _supabase
          .from('trip_pricing_requests')
          .insert(tripPricing.toJson())
          .select()
          .single();

      return TripPricingModel.fromJson(response);
    } catch (e) {
      print('Error saving trip pricing request: $e');
      return null;
    }
  }

  /// الحصول على طلبات تحديد السعر المعلقة
  Future<List<TripPricingModel>> getPendingPricingRequests() async {
    try {
      final response = await _supabase
          .from('trip_pricing_requests')
          .select()
          .eq('trip_status', 'pending');

      return (response as List)
          .map((item) => TripPricingModel.fromJson(item))
          .toList();
    } catch (e) {
      print('Error fetching pending pricing requests: $e');
      return [];
    }
  }

  /// الموافقة على السعر من الإدارة
  Future<bool> approveTripPrice(
    String tripId,
    double approvedPrice,
    String adminId,
    String? reason,
    String? notes,
  ) async {
    try {
      await _supabase
          .from('trip_pricing_requests')
          .update({
            'admin_approved_price': approvedPrice,
            'trip_status': 'approved',
            'approved_by_admin': adminId,
            'approved_at': DateTime.now().toIso8601String(),
            'price_adjustment_reason': reason,
            'notes': notes,
          })
          .eq('trip_id', tripId);

      // إرسال الرحلة للسائق المختار
      await _sendTripToDriver(tripId, approvedPrice);

      return true;
    } catch (e) {
      print('Error approving trip price: $e');
      return false;
    }
  }

  /// رفض الرحلة من الإدارة
  Future<bool> rejectTripPrice(
    String tripId,
    String adminId,
    String? reason,
  ) async {
    try {
      await _supabase
          .from('trip_pricing_requests')
          .update({
            'trip_status': 'rejected',
            'approved_by_admin': adminId,
            'approved_at': DateTime.now().toIso8601String(),
            'price_adjustment_reason': reason,
          })
          .eq('trip_id', tripId);

      return true;
    } catch (e) {
      print('Error rejecting trip price: $e');
      return false;
    }
  }

  /// إرسال الرحلة للسائق المختار
  Future<bool> _sendTripToDriver(String tripId, double approvedPrice) async {
    try {
      // الحصول على معلومات الرحلة
      final tripData = await _supabase
          .from('trip_pricing_requests')
          .select()
          .eq('trip_id', tripId)
          .single();

      final selectedDriverId = tripData['selected_driver_id'];

      if (selectedDriverId == null) {
        print('No driver selected for this trip');
        return false;
      }

      // إنشاء إشعار للسائق
      await _supabase
          .from('driver_notifications')
          .insert({
            'driver_id': selectedDriverId,
            'trip_id': tripId,
            'type': 'trip_offer',
            'title': 'عرض رحلة جديدة',
            'message': 'لديك عرض رحلة جديدة بسعر ${approvedPrice.toStringAsFixed(2)} ريال',
            'price': approvedPrice,
            'created_at': DateTime.now().toIso8601String(),
            'is_read': false,
          });

      // تحديث حالة الرحلة
      await _supabase
          .from('trips')
          .update({
            'status': 'waiting_driver_response',
            'final_price': approvedPrice,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', tripId);

      return true;
    } catch (e) {
      print('Error sending trip to driver: $e');
      return false;
    }
  }

  /// الحصول على سعر الرحلة المعتمد
  Future<double?> getApprovedTripPrice(String tripId) async {
    try {
      final response = await _supabase
          .from('trip_pricing_requests')
          .select('admin_approved_price')
          .eq('trip_id', tripId)
          .single();

      return (response['admin_approved_price'] as num?)?.toDouble();
    } catch (e) {
      print('Error fetching approved trip price: $e');
      return null;
    }
  }

  /// الحصول على سجل تعديلات الأسعار
  Future<List<Map<String, dynamic>>> getPriceAdjustmentHistory(String tripId) async {
    try {
      final response = await _supabase
          .from('trip_pricing_requests')
          .select()
          .eq('trip_id', tripId);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching price adjustment history: $e');
      return [];
    }
  }

  /// إحصائيات تعديلات الأسعار
  Future<Map<String, dynamic>> getPriceAdjustmentStats() async {
    try {
      final response = await _supabase
          .from('trip_pricing_requests')
          .select('admin_approved_price, suggested_price');

      int totalAdjustments = 0;
      double totalIncreases = 0;
      double totalDecreases = 0;

      for (var item in response) {
        final approved = (item['admin_approved_price'] as num?)?.toDouble() ?? 0;
        final suggested = (item['suggested_price'] as num?)?.toDouble() ?? 0;

        if (approved != suggested) {
          totalAdjustments++;
          if (approved > suggested) {
            totalIncreases += (approved - suggested);
          } else {
            totalDecreases += (suggested - approved);
          }
        }
      }

      return {
        'total_adjustments': totalAdjustments,
        'total_increases': totalIncreases,
        'total_decreases': totalDecreases,
        'average_adjustment': totalAdjustments > 0
            ? (totalIncreases - totalDecreases) / totalAdjustments
            : 0,
      };
    } catch (e) {
      print('Error fetching price adjustment stats: $e');
      return {
        'total_adjustments': 0,
        'total_increases': 0,
        'total_decreases': 0,
        'average_adjustment': 0,
      };
    }
  }
}
