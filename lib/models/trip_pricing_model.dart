/// نموذج تحديد سعر الرحلة من الإدارة
class TripPricingModel {
  final String tripId;
  final String userId;
  final String? selectedDriverId;
  final double pickupLat;
  final double pickupLng;
  final double dropoffLat;
  final double dropoffLng;
  final String pickupAddress;
  final String dropoffAddress;
  final double calculatedDistance; // المسافة المحسوبة
  final double suggestedPrice; // السعر المقترح من النظام
  final double? adminApprovedPrice; // السعر المعتمد من الإدارة
  final String tripStatus; // pending, approved, rejected, completed
  final DateTime createdAt;
  final DateTime? approvedAt;
  final String? approvedByAdmin;
  final String? priceAdjustmentReason; // سبب تعديل السعر
  final bool requiresAdminApproval; // هل تحتاج موافقة إدارة؟
  final String? notes; // ملاحظات الإدارة

  TripPricingModel({
    required this.tripId,
    required this.userId,
    this.selectedDriverId,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropoffLat,
    required this.dropoffLng,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.calculatedDistance,
    required this.suggestedPrice,
    this.adminApprovedPrice,
    this.tripStatus = 'pending',
    required this.createdAt,
    this.approvedAt,
    this.approvedByAdmin,
    this.priceAdjustmentReason,
    this.requiresAdminApproval = false,
    this.notes,
  });

  /// الحصول على السعر النهائي (المعتمد أو المقترح)
  double get finalPrice => adminApprovedPrice ?? suggestedPrice;

  /// حساب نسبة التعديل
  double get priceAdjustmentPercentage {
    if (adminApprovedPrice == null) return 0;
    return ((adminApprovedPrice! - suggestedPrice) / suggestedPrice * 100);
  }

  /// هل تم تعديل السعر؟
  bool get isPriceAdjusted => adminApprovedPrice != null && adminApprovedPrice != suggestedPrice;

  /// تحويل إلى JSON
  Map<String, dynamic> toJson() => {
    'trip_id': tripId,
    'user_id': userId,
    'selected_driver_id': selectedDriverId,
    'pickup_lat': pickupLat,
    'pickup_lng': pickupLng,
    'dropoff_lat': dropoffLat,
    'dropoff_lng': dropoffLng,
    'pickup_address': pickupAddress,
    'dropoff_address': dropoffAddress,
    'calculated_distance': calculatedDistance,
    'suggested_price': suggestedPrice,
    'admin_approved_price': adminApprovedPrice,
    'trip_status': tripStatus,
    'created_at': createdAt.toIso8601String(),
    'approved_at': approvedAt?.toIso8601String(),
    'approved_by_admin': approvedByAdmin,
    'price_adjustment_reason': priceAdjustmentReason,
    'requires_admin_approval': requiresAdminApproval,
    'notes': notes,
  };

  /// إنشاء من JSON
  factory TripPricingModel.fromJson(Map<String, dynamic> json) => TripPricingModel(
    tripId: json['trip_id'] ?? '',
    userId: json['user_id'] ?? '',
    selectedDriverId: json['selected_driver_id'],
    pickupLat: (json['pickup_lat'] ?? 0).toDouble(),
    pickupLng: (json['pickup_lng'] ?? 0).toDouble(),
    dropoffLat: (json['dropoff_lat'] ?? 0).toDouble(),
    dropoffLng: (json['dropoff_lng'] ?? 0).toDouble(),
    pickupAddress: json['pickup_address'] ?? '',
    dropoffAddress: json['dropoff_address'] ?? '',
    calculatedDistance: (json['calculated_distance'] ?? 0).toDouble(),
    suggestedPrice: (json['suggested_price'] ?? 0).toDouble(),
    adminApprovedPrice: json['admin_approved_price'] != null 
        ? (json['admin_approved_price']).toDouble() 
        : null,
    tripStatus: json['trip_status'] ?? 'pending',
    createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    approvedAt: json['approved_at'] != null ? DateTime.parse(json['approved_at']) : null,
    approvedByAdmin: json['approved_by_admin'],
    priceAdjustmentReason: json['price_adjustment_reason'],
    requiresAdminApproval: json['requires_admin_approval'] ?? false,
    notes: json['notes'],
  );

  /// نسخ مع تعديلات
  TripPricingModel copyWith({
    String? tripId,
    String? userId,
    String? selectedDriverId,
    double? pickupLat,
    double? pickupLng,
    double? dropoffLat,
    double? dropoffLng,
    String? pickupAddress,
    String? dropoffAddress,
    double? calculatedDistance,
    double? suggestedPrice,
    double? adminApprovedPrice,
    String? tripStatus,
    DateTime? createdAt,
    DateTime? approvedAt,
    String? approvedByAdmin,
    String? priceAdjustmentReason,
    bool? requiresAdminApproval,
    String? notes,
  }) => TripPricingModel(
    tripId: tripId ?? this.tripId,
    userId: userId ?? this.userId,
    selectedDriverId: selectedDriverId ?? this.selectedDriverId,
    pickupLat: pickupLat ?? this.pickupLat,
    pickupLng: pickupLng ?? this.pickupLng,
    dropoffLat: dropoffLat ?? this.dropoffLat,
    dropoffLng: dropoffLng ?? this.dropoffLng,
    pickupAddress: pickupAddress ?? this.pickupAddress,
    dropoffAddress: dropoffAddress ?? this.dropoffAddress,
    calculatedDistance: calculatedDistance ?? this.calculatedDistance,
    suggestedPrice: suggestedPrice ?? this.suggestedPrice,
    adminApprovedPrice: adminApprovedPrice ?? this.adminApprovedPrice,
    tripStatus: tripStatus ?? this.tripStatus,
    createdAt: createdAt ?? this.createdAt,
    approvedAt: approvedAt ?? this.approvedAt,
    approvedByAdmin: approvedByAdmin ?? this.approvedByAdmin,
    priceAdjustmentReason: priceAdjustmentReason ?? this.priceAdjustmentReason,
    requiresAdminApproval: requiresAdminApproval ?? this.requiresAdminApproval,
    notes: notes ?? this.notes,
  );
}
