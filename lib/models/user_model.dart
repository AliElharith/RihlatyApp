import 'package:flutter/foundation.dart';

enum UserRole { driver, merchant, admin }

class User {
  final String uid;
  final String phone;
  final UserRole role;
  final String? name;
  final String? fcmToken;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final bool isVerified;

  User({
    required this.uid,
    required this.phone,
    required this.role,
    this.name,
    this.fcmToken,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
    this.isVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as String,
      phone: json['phone'] as String,
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == (json['role'] as String),
        orElse: () => UserRole.merchant,
      ),
      name: json['name'] as String?,
      fcmToken: json['fcm_token'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      isActive: json['is_active'] as bool? ?? true,
      isVerified: json['is_verified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phone': phone,
      'role': role.toString().split('.').last,
      'name': name,
      'fcm_token': fcmToken,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'is_active': isActive,
      'is_verified': isVerified,
    };
  }

  User copyWith({
    String? uid,
    String? phone,
    UserRole? role,
    String? name,
    String? fcmToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isVerified,
  }) {
    return User(
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      name: name ?? this.name,
      fcmToken: fcmToken ?? this.fcmToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  String toString() {
    return 'User(uid: $uid, phone: $phone, role: $role, name: $name)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          phone == other.phone &&
          role == other.role;

  @override
  int get hashCode => uid.hashCode ^ phone.hashCode ^ role.hashCode;
}

class DriverProfile extends User {
  final String? bankAccountNumber;
  final String? vehicleType;
  final String? vehiclePlateNumber;
  final double? maxLoad;
  final String? licenseImageUrl;
  final String? vehicleLicenseImageUrl;
  final String? vehicleImageUrl;
  final double rating;
  final int completedTrips;
  final double acceptanceRate;
  final int rejectionCount;
  final double balance;
  final bool isOnline;
  final double? latitude;
  final double? longitude;

  DriverProfile({
    required String uid,
    required String phone,
    required DateTime createdAt,
    this.bankAccountNumber,
    this.vehicleType,
    this.vehiclePlateNumber,
    this.maxLoad,
    this.licenseImageUrl,
    this.vehicleLicenseImageUrl,
    this.vehicleImageUrl,
    this.rating = 0.0,
    this.completedTrips = 0,
    this.acceptanceRate = 0.0,
    this.rejectionCount = 0,
    this.balance = 0.0,
    this.isOnline = false,
    this.latitude,
    this.longitude,
    String? name,
    String? fcmToken,
    DateTime? updatedAt,
    bool isActive = true,
    bool isVerified = false,
  }) : super(
    uid: uid,
    phone: phone,
    role: UserRole.driver,
    name: name,
    fcmToken: fcmToken,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isActive: isActive,
    isVerified: isVerified,
  );

  factory DriverProfile.fromJson(Map<String, dynamic> json) {
    final user = User.fromJson(json);
    return DriverProfile(
      uid: user.uid,
      phone: user.phone,
      name: user.name,
      fcmToken: user.fcmToken,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
      isActive: user.isActive,
      isVerified: user.isVerified,
      bankAccountNumber: json['bank_account_number'] as String?,
      vehicleType: json['vehicle_type'] as String?,
      vehiclePlateNumber: json['vehicle_plate_number'] as String?,
      maxLoad: (json['max_load'] as num?)?.toDouble(),
      licenseImageUrl: json['license_image_url'] as String?,
      vehicleLicenseImageUrl: json['vehicle_license_image_url'] as String?,
      vehicleImageUrl: json['vehicle_image_url'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      completedTrips: json['completed_trips'] as int? ?? 0,
      acceptanceRate: (json['acceptance_rate'] as num?)?.toDouble() ?? 0.0,
      rejectionCount: json['rejection_count'] as int? ?? 0,
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      isOnline: json['is_online'] as bool? ?? false,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'bank_account_number': bankAccountNumber,
      'vehicle_type': vehicleType,
      'vehicle_plate_number': vehiclePlateNumber,
      'max_load': maxLoad,
      'license_image_url': licenseImageUrl,
      'vehicle_license_image_url': vehicleLicenseImageUrl,
      'vehicle_image_url': vehicleImageUrl,
      'rating': rating,
      'completed_trips': completedTrips,
      'acceptance_rate': acceptanceRate,
      'rejection_count': rejectionCount,
      'balance': balance,
      'is_online': isOnline,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  DriverProfile copyWith({
    String? uid,
    String? phone,
    String? name,
    String? fcmToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isVerified,
    String? bankAccountNumber,
    String? vehicleType,
    String? vehiclePlateNumber,
    double? maxLoad,
    String? licenseImageUrl,
    String? vehicleLicenseImageUrl,
    String? vehicleImageUrl,
    double? rating,
    int? completedTrips,
    double? acceptanceRate,
    int? rejectionCount,
    double? balance,
    bool? isOnline,
    double? latitude,
    double? longitude,
  }) {
    return DriverProfile(
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      fcmToken: fcmToken ?? this.fcmToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      vehicleType: vehicleType ?? this.vehicleType,
      vehiclePlateNumber: vehiclePlateNumber ?? this.vehiclePlateNumber,
      maxLoad: maxLoad ?? this.maxLoad,
      licenseImageUrl: licenseImageUrl ?? this.licenseImageUrl,
      vehicleLicenseImageUrl: vehicleLicenseImageUrl ?? this.vehicleLicenseImageUrl,
      vehicleImageUrl: vehicleImageUrl ?? this.vehicleImageUrl,
      rating: rating ?? this.rating,
      completedTrips: completedTrips ?? this.completedTrips,
      acceptanceRate: acceptanceRate ?? this.acceptanceRate,
      rejectionCount: rejectionCount ?? this.rejectionCount,
      balance: balance ?? this.balance,
      isOnline: isOnline ?? this.isOnline,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

class MerchantProfile extends User {
  final String? storeName;
  final String? storeLocation;
  final double? latitude;
  final double? longitude;
  final String? storeImageUrl;

  MerchantProfile({
    required String uid,
    required String phone,
    required DateTime createdAt,
    this.storeName,
    this.storeLocation,
    this.latitude,
    this.longitude,
    this.storeImageUrl,
    String? name,
    String? fcmToken,
    DateTime? updatedAt,
    bool isActive = true,
    bool isVerified = false,
  }) : super(
    uid: uid,
    phone: phone,
    role: UserRole.merchant,
    name: name,
    fcmToken: fcmToken,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isActive: isActive,
    isVerified: isVerified,
  );

  factory MerchantProfile.fromJson(Map<String, dynamic> json) {
    final user = User.fromJson(json);
    return MerchantProfile(
      uid: user.uid,
      phone: user.phone,
      name: user.name,
      fcmToken: user.fcmToken,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
      isActive: user.isActive,
      isVerified: user.isVerified,
      storeName: json['store_name'] as String?,
      storeLocation: json['store_location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      storeImageUrl: json['store_image_url'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'store_name': storeName,
      'store_location': storeLocation,
      'latitude': latitude,
      'longitude': longitude,
      'store_image_url': storeImageUrl,
    };
  }

  MerchantProfile copyWith({
    String? uid,
    String? phone,
    String? name,
    String? fcmToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isVerified,
    String? storeName,
    String? storeLocation,
    double? latitude,
    double? longitude,
    String? storeImageUrl,
  }) {
    return MerchantProfile(
      uid: uid ?? this.uid,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      fcmToken: fcmToken ?? this.fcmToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      storeName: storeName ?? this.storeName,
      storeLocation: storeLocation ?? this.storeLocation,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      storeImageUrl: storeImageUrl ?? this.storeImageUrl,
    );
  }
}
