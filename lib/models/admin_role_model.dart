// نموذج الدور الإداري
class AdminRole {
  final String id;
  final String name;
  final String nameAr;
  final String description;
  final AdminRoleType type;
  final List<Permission> permissions;
  final int priorityLevel; // 1 = أعلى، 5 = أقل
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  AdminRole({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.description,
    required this.type,
    required this.permissions,
    required this.priorityLevel,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  factory AdminRole.fromJson(Map<String, dynamic> json) {
    return AdminRole(
      id: json['id'] as String,
      name: json['name'] as String,
      nameAr: json['name_ar'] as String,
      description: json['description'] as String,
      type: AdminRoleType.values[json['type'] as int],
      permissions: (json['permissions'] as List)
          .map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList(),
      priorityLevel: json['priority_level'] as int,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_ar': nameAr,
      'description': description,
      'type': type.index,
      'permissions': permissions.map((e) => e.toJson()).toList(),
      'priority_level': priorityLevel,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool hasPermission(String permissionCode) {
    return permissions.any((p) => p.code == permissionCode && p.isGranted);
  }

  bool hasAllPermissions(List<String> permissionCodes) {
    return permissionCodes.every((code) => hasPermission(code));
  }
}

// أنواع الأدوار الإدارية
enum AdminRoleType {
  superAdmin, // التحكم الكامل
  operationsManager, // مدير العمليات
  driverVerificationOfficer, // مسؤول التحقق من السائقين
  financeManager, // مدير مالي
  supportAgent, // وكيل خدمة العملاء
}

// نموذج الصلاحية
class Permission {
  final String id;
  final String code;
  final String name;
  final String nameAr;
  final String description;
  final PermissionCategory category;
  final bool isGranted;

  Permission({
    required this.id,
    required this.code,
    required this.name,
    required this.nameAr,
    required this.description,
    required this.category,
    required this.isGranted,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      nameAr: json['name_ar'] as String,
      description: json['description'] as String,
      category: PermissionCategory.values[json['category'] as int],
      isGranted: json['is_granted'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'name_ar': nameAr,
      'description': description,
      'category': category.index,
      'is_granted': isGranted,
    };
  }
}

// فئات الصلاحيات
enum PermissionCategory {
  userManagement, // إدارة المستخدمين
  driverManagement, // إدارة السائقين
  financeManagement, // الإدارة المالية
  tripManagement, // إدارة الرحلات
  offerManagement, // إدارة العروض
  supportManagement, // إدارة الدعم
  systemConfiguration, // إعدادات النظام
  reporting, // التقارير
  auditLog, // سجل التدقيق
}

// الصلاحيات المعرفة مسبقاً
class PredefinedPermissions {
  // إدارة المستخدمين
  static const String viewUsers = 'view_users';
  static const String createUser = 'create_user';
  static const String editUser = 'edit_user';
  static const String deleteUser = 'delete_user';
  static const String suspendUser = 'suspend_user';
  static const String manageUserRoles = 'manage_user_roles';

  // إدارة السائقين
  static const String viewDrivers = 'view_drivers';
  static const String verifyDriver = 'verify_driver';
  static const String rejectDriver = 'reject_driver';
  static const String suspendDriver = 'suspend_driver';
  static const String viewDriverDocuments = 'view_driver_documents';
  static const String detectFraud = 'detect_fraud';

  // الإدارة المالية
  static const String viewFinancials = 'view_financials';
  static const String approvePayments = 'approve_payments';
  static const String processWithdrawals = 'process_withdrawals';
  static const String manageWallets = 'manage_wallets';
  static const String viewTransactions = 'view_transactions';
  static const String generateFinancialReports = 'generate_financial_reports';

  // إدارة الرحلات
  static const String viewTrips = 'view_trips';
  static const String monitorLiveTrips = 'monitor_live_trips';
  static const String cancelTrip = 'cancel_trip';
  static const String resolveDisputes = 'resolve_disputes';

  // إدارة العروض
  static const String viewOffers = 'view_offers';
  static const String createOffer = 'create_offer';
  static const String editOffer = 'edit_offer';
  static const String deleteOffer = 'delete_offer';
  static const String activateOffer = 'activate_offer';
  static const String deactivateOffer = 'deactivate_offer';

  // إدارة الدعم
  static const String viewTickets = 'view_tickets';
  static const String respondToTickets = 'respond_to_tickets';
  static const String closeTickets = 'close_tickets';
  static const String escalateTickets = 'escalate_tickets';

  // إعدادات النظام
  static const String manageCommissions = 'manage_commissions';
  static const String manageAreas = 'manage_areas';
  static const String manageSystemSettings = 'manage_system_settings';
  static const String shutdownSystem = 'shutdown_system';
  static const String shutdownArea = 'shutdown_area';

  // التقارير
  static const String viewReports = 'view_reports';
  static const String generateReports = 'generate_reports';
  static const String exportData = 'export_data';

  // سجل التدقيق
  static const String viewAuditLog = 'view_audit_log';
  static const String viewAdminActions = 'view_admin_actions';
}

// نموذج مسؤول النظام
class AdminUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final AdminRole role;
  final bool isActive;
  final DateTime lastLogin;
  final List<String> assignedAreas; // المناطق المسؤول عنها
  final DateTime createdAt;
  final DateTime? updatedAt;

  AdminUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.isActive,
    required this.lastLogin,
    required this.assignedAreas,
    required this.createdAt,
    this.updatedAt,
  });

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    return AdminUser(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: AdminRole.fromJson(json['role'] as Map<String, dynamic>),
      isActive: json['is_active'] as bool,
      lastLogin: DateTime.parse(json['last_login'] as String),
      assignedAreas: List<String>.from(json['assigned_areas'] as List),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.toJson(),
      'is_active': isActive,
      'last_login': lastLogin.toIso8601String(),
      'assigned_areas': assignedAreas,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool canManageArea(String areaId) {
    return assignedAreas.isEmpty || assignedAreas.contains(areaId);
  }
}

// نموذج سجل التدقيق
class AuditLog {
  final String id;
  final String adminId;
  final String adminName;
  final String action;
  final String actionAr;
  final String targetType; // user, driver, trip, offer, etc.
  final String targetId;
  final Map<String, dynamic> changes;
  final String ipAddress;
  final DateTime timestamp;

  AuditLog({
    required this.id,
    required this.adminId,
    required this.adminName,
    required this.action,
    required this.actionAr,
    required this.targetType,
    required this.targetId,
    required this.changes,
    required this.ipAddress,
    required this.timestamp,
  });

  factory AuditLog.fromJson(Map<String, dynamic> json) {
    return AuditLog(
      id: json['id'] as String,
      adminId: json['admin_id'] as String,
      adminName: json['admin_name'] as String,
      action: json['action'] as String,
      actionAr: json['action_ar'] as String,
      targetType: json['target_type'] as String,
      targetId: json['target_id'] as String,
      changes: json['changes'] as Map<String, dynamic>,
      ipAddress: json['ip_address'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'admin_id': adminId,
      'admin_name': adminName,
      'action': action,
      'action_ar': actionAr,
      'target_type': targetType,
      'target_id': targetId,
      'changes': changes,
      'ip_address': ipAddress,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

// نموذج إحصائيات الأداء الإداري
class AdminPerformanceStats {
  final String adminId;
  final String adminName;
  final int actionsCount;
  final int decisionsCount;
  final double averageResponseTime; // بالدقائق
  final int resolvedTickets;
  final int pendingTickets;
  final DateTime periodStart;
  final DateTime periodEnd;

  AdminPerformanceStats({
    required this.adminId,
    required this.adminName,
    required this.actionsCount,
    required this.decisionsCount,
    required this.averageResponseTime,
    required this.resolvedTickets,
    required this.pendingTickets,
    required this.periodStart,
    required this.periodEnd,
  });

  factory AdminPerformanceStats.fromJson(Map<String, dynamic> json) {
    return AdminPerformanceStats(
      adminId: json['admin_id'] as String,
      adminName: json['admin_name'] as String,
      actionsCount: json['actions_count'] as int,
      decisionsCount: json['decisions_count'] as int,
      averageResponseTime: (json['average_response_time'] as num).toDouble(),
      resolvedTickets: json['resolved_tickets'] as int,
      pendingTickets: json['pending_tickets'] as int,
      periodStart: DateTime.parse(json['period_start'] as String),
      periodEnd: DateTime.parse(json['period_end'] as String),
    );
  }
}
