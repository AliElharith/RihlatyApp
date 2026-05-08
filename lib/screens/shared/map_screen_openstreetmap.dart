import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../config/theme.dart';

class MapScreenOpenStreetMap extends StatefulWidget {
  final LatLng? initialPickup;
  final LatLng? initialDropoff;
  final Function(LatLng)? onPickupSelected;
  final Function(LatLng)? onDropoffSelected;
  final bool selectPickup;
  final bool selectDropoff;

  const MapScreenOpenStreetMap({
    Key? key,
    this.initialPickup,
    this.initialDropoff,
    this.onPickupSelected,
    this.onDropoffSelected,
    this.selectPickup = true,
    this.selectDropoff = false,
  }) : super(key: key);

  @override
  State<MapScreenOpenStreetMap> createState() => _MapScreenOpenStreetMapState();
}

class _MapScreenOpenStreetMapState extends State<MapScreenOpenStreetMap> {
  late MapController _mapController;
  LatLng? _pickupLocation;
  LatLng? _dropoffLocation;
  LatLng? _currentLocation;
  bool _isLoading = true;
  String _selectedMode = 'pickup'; // pickup or dropoff

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _pickupLocation = widget.initialPickup;
    _dropoffLocation = widget.initialDropoff;
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        if (_pickupLocation == null) {
          _pickupLocation = _currentLocation;
        }
        _isLoading = false;
      });
      _mapController.move(_currentLocation!, 15);
    } catch (e) {
      print('Error getting current location: $e');
      setState(() {
        _currentLocation = const LatLng(30.0444, 31.2357); // Cairo default
        _isLoading = false;
      });
    }
  }

  void _onMapTap(LatLng position) {
    if (widget.selectPickup && _selectedMode == 'pickup') {
      setState(() {
        _pickupLocation = position;
      });
      widget.onPickupSelected?.call(position);
    } else if (widget.selectDropoff && _selectedMode == 'dropoff') {
      setState(() {
        _dropoffLocation = position;
      });
      widget.onDropoffSelected?.call(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختر الموقع على الخريطة', style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryGradient.colors.first,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // الخريطة
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.primaryGradient.colors.first,
                ),
              ),
            )
          else
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _currentLocation ?? const LatLng(30.0444, 31.2357),
                zoom: 15,
                onTap: (tapPosition, latLng) => _onMapTap(latLng),
              ),
              children: [
                // طبقة الخريطة من OpenStreetMap
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.rihlaty.rihlaty_app',
                  attributionBuilder: (_) {
                    return Text(
                      '© OpenStreetMap contributors',
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  },
                ),

                // طبقة العلامات
                MarkerLayer(
                  markers: [
                    // الموقع الحالي
                    if (_currentLocation != null)
                      Marker(
                        point: _currentLocation!,
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.my_location,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),

                    // نقطة الاستلام
                    if (_pickupLocation != null)
                      Marker(
                        point: _pickupLocation!,
                        builder: (context) => GestureDetector(
                          onTap: () {
                            setState(() => _selectedMode = 'pickup');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                              border: Border.all(
                                color: _selectedMode == 'pickup'
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),

                    // نقطة التسليم
                    if (_dropoffLocation != null)
                      Marker(
                        point: _dropoffLocation!,
                        builder: (context) => GestureDetector(
                          onTap: () {
                            setState(() => _selectedMode = 'dropoff');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                              border: Border.all(
                                color: _selectedMode == 'dropoff'
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                // خط الطريق بين النقطتين
                if (_pickupLocation != null && _dropoffLocation != null)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [_pickupLocation!, _dropoffLocation!],
                        color: Colors.blue,
                        strokeWidth: 3,
                      ),
                    ],
                  ),
              ],
            ),

          // لوحة المعلومات السفلية
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // مؤشر الموضع
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // معلومات الاستلام
                    if (widget.selectPickup)
                      _buildLocationInfo(
                        'نقطة الاستلام',
                        _pickupLocation,
                        Colors.green,
                        _selectedMode == 'pickup',
                        () => setState(() => _selectedMode = 'pickup'),
                      ),

                    if (widget.selectPickup && widget.selectDropoff)
                      const SizedBox(height: 12),

                    // معلومات التسليم
                    if (widget.selectDropoff)
                      _buildLocationInfo(
                        'نقطة التسليم',
                        _dropoffLocation,
                        Colors.red,
                        _selectedMode == 'dropoff',
                        () => setState(() => _selectedMode = 'dropoff'),
                      ),

                    const SizedBox(height: 16),

                    // زر التأكيد
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (_pickupLocation != null &&
                                (!widget.selectDropoff || _dropoffLocation != null))
                            ? () {
                                Navigator.pop(context, {
                                  'pickup': _pickupLocation,
                                  'dropoff': _dropoffLocation,
                                });
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGradient.colors.first,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'تأكيد الموقع',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // زر الموقع الحالي
          Positioned(
            bottom: 200,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: AppTheme.primaryGradient.colors.first,
              onPressed: () {
                if (_currentLocation != null) {
                  _mapController.move(_currentLocation!, 15);
                }
              },
              child: const Icon(Icons.my_location, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfo(
    String label,
    LatLng? location,
    Color color,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade50,
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.location_on, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location != null
                        ? '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}'
                        : 'اضغط على الخريطة لاختيار الموقع',
                    style: TextStyle(
                      fontSize: 12,
                      color: location != null ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: color),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
