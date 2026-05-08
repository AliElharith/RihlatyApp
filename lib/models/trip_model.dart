enum TripStatus { pending, accepted, inProgress, completed, cancelled }

enum CargoType { food, clothes, electronics, furniture, documents, other }

class Trip {
  final String id;
  final String merchantId;
  final String? driverId;
  final double pickupLatitude;
  final double pickupLongitude;
  final String pickupAddress;
  final double dropoffLatitude;
  final double dropoffLongitude;
  final String dropoffAddress;
  final CargoType cargoType;
  final String? cargoDescription;
  final double cargoWeight;
  final String? notes;
  final double estimatedFare;
  final double? actualFare;
  final TripStatus status;
  final DateTime createdAt;
  final DateTime? acceptedAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final String? otpCode;
  final bool isOtpVerified;
  final String? paymentMethod;
  final String? transactionId;
  final String? paymentProofImageUrl;
  final double distance;
  final int estimatedDurationMinutes;
  final int? actualDurationMinutes;
  final double? merchantRating;
  final double? driverRating;
  final String? merchantReview;
  final String? driverReview;

  Trip({
    required this.id,
    required this.merchantId,
    this.driverId,
    required this.pickupLatitude,
    required this.pickupLongitude,
    required this.pickupAddress,
    required this.dropoffLatitude,
    required this.dropoffLongitude,
    required this.dropoffAddress,
    required this.cargoType,
    this.cargoDescription,
    required this.cargoWeight,
    this.notes,
    required this.estimatedFare,
    this.actualFare,
    required this.status,
    required this.createdAt,
    this.acceptedAt,
    this.startedAt,
    this.completedAt,
    this.otpCode,
    this.isOtpVerified = false,
    this.paymentMethod,
    this.transactionId,
    this.paymentProofImageUrl,
    required this.distance,
    required this.estimatedDurationMinutes,
    this.actualDurationMinutes,
    this.merchantRating,
    this.driverRating,
    this.merchantReview,
    this.driverReview,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] as String,
      merchantId: json['merchant_id'] as String,
      driverId: json['driver_id'] as String?,
      pickupLatitude: (json['pickup_latitude'] as num).toDouble(),
      pickupLongitude: (json['pickup_longitude'] as num).toDouble(),
      pickupAddress: json['pickup_address'] as String,
      dropoffLatitude: (json['dropoff_latitude'] as num).toDouble(),
      dropoffLongitude: (json['dropoff_longitude'] as num).toDouble(),
      dropoffAddress: json['dropoff_address'] as String,
      cargoType: CargoType.values.firstWhere(
        (e) => e.toString().split('.').last == (json['cargo_type'] as String),
        orElse: () => CargoType.other,
      ),
      cargoDescription: json['cargo_description'] as String?,
      cargoWeight: (json['cargo_weight'] as num).toDouble(),
      notes: json['notes'] as String?,
      estimatedFare: (json['estimated_fare'] as num).toDouble(),
      actualFare: (json['actual_fare'] as num?)?.toDouble(),
      status: TripStatus.values.firstWhere(
        (e) => e.toString().split('.').last == (json['status'] as String),
        orElse: () => TripStatus.pending,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      acceptedAt: json['accepted_at'] != null
          ? DateTime.parse(json['accepted_at'] as String)
          : null,
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'] as String)
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      otpCode: json['otp_code'] as String?,
      isOtpVerified: json['is_otp_verified'] as bool? ?? false,
      paymentMethod: json['payment_method'] as String?,
      transactionId: json['transaction_id'] as String?,
      paymentProofImageUrl: json['payment_proof_image_url'] as String?,
      distance: (json['distance'] as num).toDouble(),
      estimatedDurationMinutes: json['estimated_duration_minutes'] as int,
      actualDurationMinutes: json['actual_duration_minutes'] as int?,
      merchantRating: (json['merchant_rating'] as num?)?.toDouble(),
      driverRating: (json['driver_rating'] as num?)?.toDouble(),
      merchantReview: json['merchant_review'] as String?,
      driverReview: json['driver_review'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'merchant_id': merchantId,
      'driver_id': driverId,
      'pickup_latitude': pickupLatitude,
      'pickup_longitude': pickupLongitude,
      'pickup_address': pickupAddress,
      'dropoff_latitude': dropoffLatitude,
      'dropoff_longitude': dropoffLongitude,
      'dropoff_address': dropoffAddress,
      'cargo_type': cargoType.toString().split('.').last,
      'cargo_description': cargoDescription,
      'cargo_weight': cargoWeight,
      'notes': notes,
      'estimated_fare': estimatedFare,
      'actual_fare': actualFare,
      'status': status.toString().split('.').last,
      'created_at': createdAt.toIso8601String(),
      'accepted_at': acceptedAt?.toIso8601String(),
      'started_at': startedAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'otp_code': otpCode,
      'is_otp_verified': isOtpVerified,
      'payment_method': paymentMethod,
      'transaction_id': transactionId,
      'payment_proof_image_url': paymentProofImageUrl,
      'distance': distance,
      'estimated_duration_minutes': estimatedDurationMinutes,
      'actual_duration_minutes': actualDurationMinutes,
      'merchant_rating': merchantRating,
      'driver_rating': driverRating,
      'merchant_review': merchantReview,
      'driver_review': driverReview,
    };
  }

  Trip copyWith({
    String? id,
    String? merchantId,
    String? driverId,
    double? pickupLatitude,
    double? pickupLongitude,
    String? pickupAddress,
    double? dropoffLatitude,
    double? dropoffLongitude,
    String? dropoffAddress,
    CargoType? cargoType,
    String? cargoDescription,
    double? cargoWeight,
    String? notes,
    double? estimatedFare,
    double? actualFare,
    TripStatus? status,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? otpCode,
    bool? isOtpVerified,
    String? paymentMethod,
    String? transactionId,
    String? paymentProofImageUrl,
    double? distance,
    int? estimatedDurationMinutes,
    int? actualDurationMinutes,
    double? merchantRating,
    double? driverRating,
    String? merchantReview,
    String? driverReview,
  }) {
    return Trip(
      id: id ?? this.id,
      merchantId: merchantId ?? this.merchantId,
      driverId: driverId ?? this.driverId,
      pickupLatitude: pickupLatitude ?? this.pickupLatitude,
      pickupLongitude: pickupLongitude ?? this.pickupLongitude,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      dropoffLatitude: dropoffLatitude ?? this.dropoffLatitude,
      dropoffLongitude: dropoffLongitude ?? this.dropoffLongitude,
      dropoffAddress: dropoffAddress ?? this.dropoffAddress,
      cargoType: cargoType ?? this.cargoType,
      cargoDescription: cargoDescription ?? this.cargoDescription,
      cargoWeight: cargoWeight ?? this.cargoWeight,
      notes: notes ?? this.notes,
      estimatedFare: estimatedFare ?? this.estimatedFare,
      actualFare: actualFare ?? this.actualFare,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      otpCode: otpCode ?? this.otpCode,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId ?? this.transactionId,
      paymentProofImageUrl: paymentProofImageUrl ?? this.paymentProofImageUrl,
      distance: distance ?? this.distance,
      estimatedDurationMinutes: estimatedDurationMinutes ?? this.estimatedDurationMinutes,
      actualDurationMinutes: actualDurationMinutes ?? this.actualDurationMinutes,
      merchantRating: merchantRating ?? this.merchantRating,
      driverRating: driverRating ?? this.driverRating,
      merchantReview: merchantReview ?? this.merchantReview,
      driverReview: driverReview ?? this.driverReview,
    );
  }

  @override
  String toString() {
    return 'Trip(id: $id, merchantId: $merchantId, driverId: $driverId, status: $status)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Trip &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
