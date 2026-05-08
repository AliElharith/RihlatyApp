import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../models/advanced_booking_model.dart';
import '../../config/theme.dart';

class AdvancedBookingScreen extends StatefulWidget {
  const AdvancedBookingScreen({Key? key}) : super(key: key);

  @override
  State<AdvancedBookingScreen> createState() => _AdvancedBookingScreenState();
}

class _AdvancedBookingScreenState extends State<AdvancedBookingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late GoogleMapController _mapController;
  
  final _pickupController = TextEditingController();
  final _dropoffController = TextEditingController();
  final _notesController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedPackageType = 'صناديق';
  String _selectedPaymentMethod = 'محفظة';
  bool _isRecurring = false;
  String _recurringPattern = 'يومي';
  int _recurringCount = 1;

  final Set<Marker> _markers = {};
  LatLng? _pickupLocation;
  LatLng? _dropoffLocation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pickupController.dispose();
    _dropoffController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _addPickupMarker(LatLng position) {
    setState(() {
      _pickupLocation = position;
      _markers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: position,
          infoWindow: const InfoWindow(title: 'نقطة الاستلام'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    });
  }

  void _addDropoffMarker(LatLng position) {
    setState(() {
      _dropoffLocation = position;
      _markers.add(
        Marker(
          markerId: const MarkerId('dropoff'),
          position: position,
          infoWindow: const InfoWindow(title: 'نقطة التسليم'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  void _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _selectTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _submitBooking() {
    if (_pickupLocation == null || _dropoffLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تحديد نقاط الاستلام والتسليم')),
      );
      return;
    }

    final booking = AdvancedBooking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'user_id',
      pickupAddress: _pickupController.text,
      pickupLatitude: _pickupLocation!.latitude,
      pickupLongitude: _pickupLocation!.longitude,
      dropoffAddress: _dropoffController.text,
      dropoffLatitude: _dropoffLocation!.latitude,
      dropoffLongitude: _dropoffLocation!.longitude,
      packageType: _selectedPackageType,
      packageDescription: '',
      packageDimensions: '',
      scheduledDateTime: DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      ),
      estimatedFare: 50.0,
      paymentMethod: _selectedPaymentMethod,
      notes: _notesController.text,
      status: 'pending',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isRecurring: _isRecurring,
      recurringPattern: _isRecurring ? _recurringPattern : null,
      recurringCount: _isRecurring ? _recurringCount : null,
    );

    print('✅ تم إنشاء حجز مسبق: ${booking.id}');
    Navigator.pop(context, booking);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حجز مسبق', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryGradient.colors.first,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'الخريطة'),
            Tab(text: 'التفاصيل'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // تبويب الخريطة
          _buildMapTab(),
          // تبويب التفاصيل
          _buildDetailsTab(),
        ],
      ),
    );
  }

  Widget _buildMapTab() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(30.0444, 31.2357), // القاهرة
        zoom: 12,
      ),
      markers: _markers,
      onTap: (LatLng position) {
        if (_pickupLocation == null) {
          _addPickupMarker(position);
          _pickupController.text = 'نقطة الاستلام: ${position.latitude}, ${position.longitude}';
        } else if (_dropoffLocation == null) {
          _addDropoffMarker(position);
          _dropoffController.text = 'نقطة التسليم: ${position.latitude}, ${position.longitude}';
        }
      },
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // نقطة الاستلام
          _buildLocationField(
            label: 'نقطة الاستلام',
            controller: _pickupController,
            icon: Icons.location_on,
          ),
          const SizedBox(height: 16),

          // نقطة التسليم
          _buildLocationField(
            label: 'نقطة التسليم',
            controller: _dropoffController,
            icon: Icons.location_on,
          ),
          const SizedBox(height: 24),

          // التاريخ والوقت
          const Text('التاريخ والوقت', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text('${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: _selectTime,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text('${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // نوع الحزمة
          const Text('نوع الحزمة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          DropdownButton<String>(
            value: _selectedPackageType,
            isExpanded: true,
            items: ['صناديق', 'أكياس', 'أثاث', 'إلكترونيات', 'أخرى'].map((type) {
              return DropdownMenuItem(value: type, child: Text(type));
            }).toList(),
            onChanged: (value) => setState(() => _selectedPackageType = value!),
          ),
          const SizedBox(height: 24),

          // طريقة الدفع
          const Text('طريقة الدفع', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          DropdownButton<String>(
            value: _selectedPaymentMethod,
            isExpanded: true,
            items: ['محفظة', 'بطاقة ائتمان', 'دفع عند الاستلام'].map((method) {
              return DropdownMenuItem(value: method, child: Text(method));
            }).toList(),
            onChanged: (value) => setState(() => _selectedPaymentMethod = value!),
          ),
          const SizedBox(height: 24),

          // الحجز المتكرر
          CheckboxListTile(
            title: const Text('حجز متكرر'),
            value: _isRecurring,
            onChanged: (value) => setState(() => _isRecurring = value!),
          ),
          if (_isRecurring) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: _recurringPattern,
                    isExpanded: true,
                    items: ['يومي', 'أسبوعي', 'شهري'].map((pattern) {
                      return DropdownMenuItem(value: pattern, child: Text(pattern));
                    }).toList(),
                    onChanged: (value) => setState(() => _recurringPattern = value!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'عدد المرات',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onChanged: (value) => setState(() => _recurringCount = int.tryParse(value) ?? 1),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 24),

          // ملاحظات
          TextField(
            controller: _notesController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'ملاحظات إضافية',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 24),

          // زر الحجز
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'تأكيد الحجز',
                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.blue),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            hintText: 'انقر على الخريطة لتحديد الموقع',
          ),
        ),
      ],
    );
  }
}
