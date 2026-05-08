/// نموذج الحجز المسبق (Advanced Booking)
class AdvancedBooking {
  final String id;
  final String userId;
  final String? driverId;
  final String pickupAddress;
  final double pickupLatitude;
  final double pickupLongitude;
  final String dropoffAddress;
  final double dropoffLatitude;
  final double dropoffLongitude;
  final String packageType;
  final String packageDescription;
  final double? packageWeight;
  final String packageDimensions;
  final DateTime scheduledDateTime;
  final double estimatedFare;
  final String paymentMethod;
  final String notes;
  final String status; // pending, confirmed, in_progress, completed, cancelled
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isRecurring;
  final String? recurringPattern; // daily, weekly, monthly
  final int? recurringCount;
  final List<String>? recurringDates;

  AdvancedBooking({
    required this.id,
    required this.userId,
    this.driverId,
    required this.pickupAddress,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.dropoffAddress,
    required this.dropoffLatitude,
    required this.dropoffLongitude,
    required this.packageType,
    required this.packageDescription,
    this.packageWeight,
    required this.packageDimensions,
    required this.scheduledDateTime,
    required this.estimatedFare,
    required this.paymentMethod,
    required this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.isRecurring = false,
    this.recurringPattern,
    this.recurringCount,
    this.recurringDates,
  });

  /// تحويل من JSON
  factory AdvancedBooking.fromJson(Map<String, dynamic> json) {
    return AdvancedBooking(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      driverId: json['driver_id'],
      pickupAddress: json['pickup_address'] ?? '',
      pickupLatitude: (json['pickup_latitude'] ?? 0.0).toDouble(),
      pickupLongitude: (json['pickup_longitude'] ?? 0.0).toDouble(),
      dropoffAddress: json['dropoff_address'] ?? '',
      dropoffLatitude: (json['dropoff_latitude'] ?? 0.0).toDouble(),
      dropoffLongitude: (json['dropoff_longitude'] ?? 0.0).toDouble(),
      packageType: json['package_type'] ?? '',
      packageDescription: json['package_description'] ?? '',
      packageWeight: json['package_weight']?.toDouble(),
      packageDimensions: json['package_dimensions'] ?? '',
      scheduledDateTime: DateTime.parse(json['scheduled_date_time'] ?? DateTime.now().toIso8601String()),
      estimatedFare: (json['estimated_fare'] ?? 0.0).toDouble(),
      paymentMethod: json['payment_method'] ?? 'wallet',
      notes: json['notes'] ?? '',
      status: json['status'] ?? 'pending',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      isRecurring: json['is_recurring'] ?? false,
      recurringPattern: json['recurring_pattern'],
      recurringCount: json['recurring_count'],
      recurringDates: List<String>.from(json['recurring_dates'] ?? []),
    );
  }

  /// تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'driver_id': driverId,
      'pickup_address': pickupAddress,
      'pickup_latitude': pickupLatitude,
      'pickup_longitude': pickupLongitude,
      'dropoff_address': dropoffAddress,
      'dropoff_latitude': dropoffLatitude,
      'dropoff_longitude': dropoffLongitude,
      'package_type': packageType,
      'package_description': packageDescription,
      'package_weight': packageWeight,
      'package_dimensions': packageDimensions,
      'scheduled_date_time': scheduledDateTime.toIso8601String(),
      'estimated_fare': estimatedFare,
      'payment_method': paymentMethod,
      'notes': notes,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_recurring': isRecurring,
      'recurring_pattern': recurringPattern,
      'recurring_count': recurringCount,
      'recurring_dates': recurringDates,
    };
  }

  /// نسخ مع تعديلات
  AdvancedBooking copyWith({
    String? id,
    String? userId,
    String? driverId,
    String? pickupAddress,
    double? pickupLatitude,
    double? pickupLongitude,
    String? dropoffAddress,
    double? dropoffLatitude,
    double? dropoffLongitude,
    String? packageType,
    String? packageDescription,
    double? packageWeight,
    String? packageDimensions,
    DateTime? scheduledDateTime,
    double? estimatedFare,
    String? paymentMethod,
    String? notes,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isRecurring,
    String? recurringPattern,
    int? recurringCount,
    List<String>? recurringDates,
  }) {
    return AdvancedBooking(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      driverId: driverId ?? this.driverId,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      pickupLatitude: pickupLatitude ?? this.pickupLatitude,
      pickupLongitude: pickupLongitude ?? this.pickupLongitude,
      dropoffAddress: dropoffAddress ?? this.dropoffAddress,
      dropoffLatitude: dropoffLatitude ?? this.dropoffLatitude,
      dropoffLongitude: dropoffLongitude ?? this.dropoffLongitude,
      packageType: packageType ?? this.packageType,
      packageDescription: packageDescription ?? this.packageDescription,
      packageWeight: packageWeight ?? this.packageWeight,
      packageDimensions: packageDimensions ?? this.packageDimensions,
      scheduledDateTime: scheduledDateTime ?? this.scheduledDateTime,
      estimatedFare: estimatedFare ?? this.estimatedFare,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isRecurring: isRecurring ?? this.isRecurring,
      recurringPattern: recurringPattern ?? this.recurringPattern,
      recurringCount: recurringCount ?? this.recurringCount,
      recurringDates: recurringDates ?? this.recurringDates,
    );
  }
}

/// نموذج البحث عن السائق
class DriverSearchFilter {
  final String? name;
  final double? minRating;
  final double? maxDistance;
  final String? vehicleType;
  final bool? isAvailable;
  final String? area;

  DriverSearchFilter({
    this.name,
    this.minRating,
    this.maxDistance,
    this.vehicleType,
    this.isAvailable,
    this.area,
  });

  /// تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'min_rating': minRating,
      'max_distance': maxDistance,
      'vehicle_type': vehicleType,
      'is_available': isAvailable,
      'area': area,
    };
  }
}
