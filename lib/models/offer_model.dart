// نموذج العرض والتخفيف
class Offer {
  final String id;
  final String title;
  final String description;
  final OfferType type;
  final double discountPercentage;
  final int? freeTripsAfterTrips; // رحلة مجانية بعد عدد رحلات
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final int usageCount;
  final List<String> applicableRoles; // التجار، السائقين، الاثنين
  final String createdBy;
  final DateTime createdAt;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.discountPercentage,
    this.freeTripsAfterTrips,
    required this.startDate,
    this.endDate,
    required this.isActive,
    required this.usageCount,
    required this.applicableRoles,
    required this.createdBy,
    required this.createdAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: OfferType.values[json['type'] as int],
      discountPercentage: (json['discount_percentage'] as num).toDouble(),
      freeTripsAfterTrips: json['free_trips_after_trips'] as int?,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'] as String)
          : null,
      isActive: json['is_active'] as bool,
      usageCount: json['usage_count'] as int,
      applicableRoles: List<String>.from(json['applicable_roles'] as List),
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.index,
      'discount_percentage': discountPercentage,
      'free_trips_after_trips': freeTripsAfterTrips,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'is_active': isActive,
      'usage_count': usageCount,
      'applicable_roles': applicableRoles,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Offer copyWith({
    String? id,
    String? title,
    String? description,
    OfferType? type,
    double? discountPercentage,
    int? freeTripsAfterTrips,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    int? usageCount,
    List<String>? applicableRoles,
    String? createdBy,
    DateTime? createdAt,
  }) {
    return Offer(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      freeTripsAfterTrips: freeTripsAfterTrips ?? this.freeTripsAfterTrips,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      usageCount: usageCount ?? this.usageCount,
      applicableRoles: applicableRoles ?? this.applicableRoles,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// أنواع العروض
enum OfferType {
  percentage, // خصم نسبة مئوية
  fixedAmount, // خصم مبلغ ثابت
  freeTrip, // رحلة مجانية
  reducedCommission, // عمولة مخفضة
  nightDiscount, // خصم ليلي
  newUserOffer, // عرض للمستخدمين الجدد
}

// نموذج استخدام العرض
class OfferUsage {
  final String id;
  final String offerId;
  final String userId;
  final String tripId;
  final double savingsAmount;
  final DateTime usedAt;

  OfferUsage({
    required this.id,
    required this.offerId,
    required this.userId,
    required this.tripId,
    required this.savingsAmount,
    required this.usedAt,
  });

  factory OfferUsage.fromJson(Map<String, dynamic> json) {
    return OfferUsage(
      id: json['id'] as String,
      offerId: json['offer_id'] as String,
      userId: json['user_id'] as String,
      tripId: json['trip_id'] as String,
      savingsAmount: (json['savings_amount'] as num).toDouble(),
      usedAt: DateTime.parse(json['used_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'offer_id': offerId,
      'user_id': userId,
      'trip_id': tripId,
      'savings_amount': savingsAmount,
      'used_at': usedAt.toIso8601String(),
    };
  }
}

// نموذج إحصائيات العروض
class OfferStats {
  final int totalOffers;
  final int activeOffers;
  final int totalUsage;
  final double totalSavings;
  final List<OfferPerformance> topOffers;

  OfferStats({
    required this.totalOffers,
    required this.activeOffers,
    required this.totalUsage,
    required this.totalSavings,
    required this.topOffers,
  });

  factory OfferStats.fromJson(Map<String, dynamic> json) {
    return OfferStats(
      totalOffers: json['total_offers'] as int,
      activeOffers: json['active_offers'] as int,
      totalUsage: json['total_usage'] as int,
      totalSavings: (json['total_savings'] as num).toDouble(),
      topOffers: (json['top_offers'] as List)
          .map((e) => OfferPerformance.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

// أداء العرض
class OfferPerformance {
  final String offerId;
  final String title;
  final int usageCount;
  final double totalSavings;
  final double conversionRate;

  OfferPerformance({
    required this.offerId,
    required this.title,
    required this.usageCount,
    required this.totalSavings,
    required this.conversionRate,
  });

  factory OfferPerformance.fromJson(Map<String, dynamic> json) {
    return OfferPerformance(
      offerId: json['offer_id'] as String,
      title: json['title'] as String,
      usageCount: json['usage_count'] as int,
      totalSavings: (json['total_savings'] as num).toDouble(),
      conversionRate: (json['conversion_rate'] as num).toDouble(),
    );
  }
}
