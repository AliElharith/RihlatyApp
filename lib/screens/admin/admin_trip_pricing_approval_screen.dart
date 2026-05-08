import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/trip_pricing_model.dart';

class AdminTripPricingApprovalScreen extends StatefulWidget {
  final TripPricingModel trip;

  const AdminTripPricingApprovalScreen({
    Key? key,
    required this.trip,
  }) : super(key: key);

  @override
  State<AdminTripPricingApprovalScreen> createState() =>
      _AdminTripPricingApprovalScreenState();
}

class _AdminTripPricingApprovalScreenState
    extends State<AdminTripPricingApprovalScreen> {
  late TextEditingController _priceController;
  late TextEditingController _reasonController;
  late TextEditingController _notesController;
  bool _isPriceModified = false;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(
      text: widget.trip.suggestedPrice.toStringAsFixed(2),
    );
    _reasonController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _reasonController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onPriceChanged(String value) {
    final newPrice = double.tryParse(value) ?? widget.trip.suggestedPrice;
    setState(() {
      _isPriceModified = newPrice != widget.trip.suggestedPrice;
    });
  }

  void _approveTrip() {
    final approvedPrice = double.tryParse(_priceController.text) ?? widget.trip.suggestedPrice;
    
    // هنا يتم إرسال البيانات إلى السائق
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم الموافقة على السعر: ${approvedPrice.toStringAsFixed(2)} ريال'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context, {
      'approved': true,
      'price': approvedPrice,
      'reason': _reasonController.text,
      'notes': _notesController.text,
    });
  }

  void _rejectTrip() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم رفض الرحلة'),
        backgroundColor: Colors.red,
      ),
    );

    Navigator.pop(context, {
      'approved': false,
      'reason': _reasonController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('موافقة الإدارة على السعر', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryGradient.colors.first,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // بطاقة معلومات الرحلة
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'معلومات الرحلة',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow('رقم الرحلة:', widget.trip.tripId),
                  _buildInfoRow('المسافة:', '${widget.trip.calculatedDistance.toStringAsFixed(2)} كم'),
                  _buildInfoRow('من:', widget.trip.pickupAddress),
                  _buildInfoRow('إلى:', widget.trip.dropoffAddress),
                ],
              ),
            ),

            // بطاقة السعر المقترح
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'السعر المقترح من النظام',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.trip.suggestedPrice.toStringAsFixed(2)} ريال',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // حقل تعديل السعر
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تعديل السعر (اختياري)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _priceController,
                    onChanged: _onPriceChanged,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: 'أدخل السعر الجديد',
                      prefixIcon: const Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      suffixText: 'ريال',
                    ),
                  ),
                  if (_isPriceModified) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: Colors.orange.shade700),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'تم تعديل السعر بنسبة ${((double.tryParse(_priceController.text) ?? widget.trip.suggestedPrice) - widget.trip.suggestedPrice).toStringAsFixed(2)} ريال',
                              style: TextStyle(color: Colors.orange.shade700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 16),

            // سبب التعديل
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'سبب التعديل (إذا تم التعديل)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _reasonController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'مثال: ازدحام المرور، مسافة إضافية، إلخ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ملاحظات إضافية
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ملاحظات إضافية',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'أضف أي ملاحظات للسائق أو المستخدم',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // الأزرار
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // زر الموافقة
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _approveTrip,
                      icon: const Icon(Icons.check_circle),
                      label: const Text('موافقة'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // زر الرفض
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _rejectTrip,
                      icon: const Icon(Icons.cancel),
                      label: const Text('رفض'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
