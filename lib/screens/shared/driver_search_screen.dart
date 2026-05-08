import 'package:flutter/material.dart';
import '../../models/advanced_booking_model.dart';
import '../../config/theme.dart';

class DriverSearchScreen extends StatefulWidget {
  const DriverSearchScreen({Key? key}) : super(key: key);

  @override
  State<DriverSearchScreen> createState() => _DriverSearchScreenState();
}

class _DriverSearchScreenState extends State<DriverSearchScreen> {
  final _searchController = TextEditingController();
  String _selectedVehicleType = 'الكل';
  double _minRating = 0;
  bool _onlyAvailable = false;

  // بيانات تجريبية للسائقين
  final List<Map<String, dynamic>> _allDrivers = [
    {
      'id': '1',
      'name': 'أحمد محمد',
      'rating': 4.8,
      'reviews': 245,
      'vehicle': 'توكتوك',
      'plate': 'ق ا 123456',
      'isAvailable': true,
      'distance': 2.5,
      'image': '👨‍💼',
    },
    {
      'id': '2',
      'name': 'محمود علي',
      'rating': 4.5,
      'reviews': 189,
      'vehicle': 'توكتوك',
      'plate': 'ق ب 789012',
      'isAvailable': true,
      'distance': 3.2,
      'image': '👨‍💼',
    },
    {
      'id': '3',
      'name': 'علي حسن',
      'rating': 4.9,
      'reviews': 312,
      'vehicle': 'سيارة',
      'plate': 'ق ج 345678',
      'isAvailable': false,
      'distance': 1.8,
      'image': '👨‍💼',
    },
    {
      'id': '4',
      'name': 'خالد إبراهيم',
      'rating': 4.6,
      'reviews': 156,
      'vehicle': 'توكتوك',
      'plate': 'ق د 901234',
      'isAvailable': true,
      'distance': 4.1,
      'image': '👨‍💼',
    },
    {
      'id': '5',
      'name': 'سامي محمود',
      'rating': 4.7,
      'reviews': 267,
      'vehicle': 'سيارة',
      'plate': 'ق هـ 567890',
      'isAvailable': true,
      'distance': 2.9,
      'image': '👨‍💼',
    },
  ];

  List<Map<String, dynamic>> get _filteredDrivers {
    return _allDrivers.where((driver) {
      final matchesSearch = _searchController.text.isEmpty ||
          driver['name'].toLowerCase().contains(_searchController.text.toLowerCase());
      
      final matchesVehicle = _selectedVehicleType == 'الكل' ||
          driver['vehicle'] == _selectedVehicleType;
      
      final matchesRating = driver['rating'] >= _minRating;
      
      final matchesAvailability = !_onlyAvailable || driver['isAvailable'];

      return matchesSearch && matchesVehicle && matchesRating && matchesAvailability;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _selectDriver(Map<String, dynamic> driver) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم اختيار السائق: ${driver['name']}')),
    );
    Navigator.pop(context, driver);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('البحث عن سائق', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryGradient.colors.first,
        elevation: 0,
      ),
      body: Column(
        children: [
          // شريط البحث
          Container(
            padding: const EdgeInsets.all(16),
            color: AppTheme.primaryGradient.colors.first.withOpacity(0.1),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'ابحث عن السائق باسمه...',
                prefixIcon: const Icon(Icons.search, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // الفلاتر
          Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // نوع المركبة
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: DropdownButton<String>(
                      value: _selectedVehicleType,
                      items: ['الكل', 'توكتوك', 'سيارة'].map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedVehicleType = value!),
                    ),
                  ),

                  // التقييم الأدنى
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Chip(
                      label: Text('⭐ ${_minRating.toStringAsFixed(1)}+'),
                      onDeleted: () => setState(() => _minRating = 0),
                    ),
                  ),

                  // المتاح فقط
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: FilterChip(
                      label: const Text('متاح فقط'),
                      selected: _onlyAvailable,
                      onSelected: (value) => setState(() => _onlyAvailable = value),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // قائمة السائقين
          Expanded(
            child: _filteredDrivers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Text(
                          'لم يتم العثور على سائقين',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredDrivers.length,
                    itemBuilder: (context, index) {
                      final driver = _filteredDrivers[index];
                      return _buildDriverCard(driver);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard(Map<String, dynamic> driver) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _selectDriver(driver),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // رأس البطاقة
              Row(
                children: [
                  // صورة السائق
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(driver['image'], style: const TextStyle(fontSize: 32)),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // معلومات السائق
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          driver['name'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${driver['rating']} (${driver['reviews']} تقييم)',
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // حالة التوفر
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: driver['isAvailable'] ? Colors.green.shade100 : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      driver['isAvailable'] ? 'متاح' : 'مشغول',
                      style: TextStyle(
                        fontSize: 12,
                        color: driver['isAvailable'] ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),

              // معلومات المركبة والمسافة
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'المركبة',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${driver['vehicle']} - ${driver['plate']}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'المسافة',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${driver['distance']} كم',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // زر الاختيار
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _selectDriver(driver),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'اختيار هذا السائق',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
