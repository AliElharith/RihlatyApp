-- ============================================
-- تطبيق رحلتي - مخطط قاعدة البيانات
-- ============================================

-- 1. جدول المستخدمين
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  phone VARCHAR(20) UNIQUE NOT NULL,
  name VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL CHECK (role IN ('merchant', 'driver', 'admin')),
  profile_image_url TEXT,
  is_verified BOOLEAN DEFAULT FALSE,
  is_active BOOLEAN DEFAULT TRUE,
  rating DECIMAL(3,2) DEFAULT 0.0,
  total_ratings INT DEFAULT 0,
  wallet_balance DECIMAL(10,2) DEFAULT 0.0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_login TIMESTAMP
);

-- 2. جدول السائقين (معلومات إضافية)
CREATE TABLE IF NOT EXISTS drivers (
  id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  license_number VARCHAR(50) UNIQUE NOT NULL,
  license_expiry DATE NOT NULL,
  vehicle_type VARCHAR(50) NOT NULL,
  vehicle_plate VARCHAR(50) UNIQUE NOT NULL,
  vehicle_color VARCHAR(50),
  vehicle_image_url TEXT,
  national_id VARCHAR(50) UNIQUE NOT NULL,
  national_id_image_url TEXT,
  is_verified BOOLEAN DEFAULT FALSE,
  verification_date TIMESTAMP,
  verified_by UUID REFERENCES users(id),
  rejection_reason TEXT,
  total_trips INT DEFAULT 0,
  completed_trips INT DEFAULT 0,
  cancelled_trips INT DEFAULT 0,
  status VARCHAR(20) DEFAULT 'offline' CHECK (status IN ('online', 'offline', 'busy')),
  current_location POINT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. جدول التجار (معلومات إضافية)
CREATE TABLE IF NOT EXISTS merchants (
  id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  business_name VARCHAR(255) NOT NULL,
  business_type VARCHAR(100),
  business_license VARCHAR(50),
  tax_id VARCHAR(50),
  address TEXT,
  city VARCHAR(100),
  region VARCHAR(100),
  total_trips INT DEFAULT 0,
  completed_trips INT DEFAULT 0,
  cancelled_trips INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. جدول الرحلات
CREATE TABLE IF NOT EXISTS trips (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  merchant_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  driver_id UUID REFERENCES users(id) ON DELETE SET NULL,
  pickup_location POINT NOT NULL,
  pickup_address TEXT NOT NULL,
  dropoff_location POINT NOT NULL,
  dropoff_address TEXT NOT NULL,
  package_type VARCHAR(50) NOT NULL,
  package_description TEXT,
  package_weight DECIMAL(10,2),
  package_dimensions VARCHAR(100),
  estimated_fare DECIMAL(10,2) NOT NULL,
  final_fare DECIMAL(10,2),
  commission DECIMAL(10,2),
  status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'in_progress', 'completed', 'cancelled')),
  payment_status VARCHAR(50) DEFAULT 'pending' CHECK (payment_status IN ('pending', 'completed', 'failed')),
  payment_method VARCHAR(50),
  notes TEXT,
  merchant_rating DECIMAL(3,2),
  merchant_review TEXT,
  driver_rating DECIMAL(3,2),
  driver_review TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  started_at TIMESTAMP,
  completed_at TIMESTAMP,
  cancelled_at TIMESTAMP,
  cancellation_reason TEXT
);

-- 5. جدول المحافظ والمعاملات
CREATE TABLE IF NOT EXISTS wallet_transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  transaction_type VARCHAR(50) NOT NULL CHECK (transaction_type IN ('credit', 'debit', 'refund', 'commission', 'withdrawal')),
  amount DECIMAL(10,2) NOT NULL,
  description TEXT,
  trip_id UUID REFERENCES trips(id) ON DELETE SET NULL,
  status VARCHAR(50) DEFAULT 'completed' CHECK (status IN ('pending', 'completed', 'failed')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. جدول طلبات السحب
CREATE TABLE IF NOT EXISTS withdrawal_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  amount DECIMAL(10,2) NOT NULL,
  bank_account VARCHAR(50),
  bank_name VARCHAR(100),
  account_holder_name VARCHAR(255),
  status VARCHAR(50) DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected', 'completed')),
  rejection_reason TEXT,
  approved_by UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  completed_at TIMESTAMP
);

-- 7. جدول العروض والتخفيفات
CREATE TABLE IF NOT EXISTS offers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  offer_type VARCHAR(50) NOT NULL CHECK (offer_type IN ('percentage', 'fixed_amount', 'free_trip', 'reduced_commission', 'night_discount', 'new_user')),
  discount_percentage DECIMAL(5,2),
  discount_amount DECIMAL(10,2),
  free_trips_after_trips INT,
  start_date TIMESTAMP NOT NULL,
  end_date TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE,
  usage_count INT DEFAULT 0,
  applicable_roles TEXT[] DEFAULT ARRAY['merchant', 'driver'],
  created_by UUID NOT NULL REFERENCES users(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. جدول استخدام العروض
CREATE TABLE IF NOT EXISTS offer_usages (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  offer_id UUID NOT NULL REFERENCES offers(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  trip_id UUID NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
  savings_amount DECIMAL(10,2) NOT NULL,
  used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 9. جدول الأدوار الإدارية
CREATE TABLE IF NOT EXISTS admin_roles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) NOT NULL UNIQUE,
  name_ar VARCHAR(100) NOT NULL,
  description TEXT,
  role_type VARCHAR(50) NOT NULL CHECK (role_type IN ('super_admin', 'operations_manager', 'driver_verification_officer', 'finance_manager', 'support_agent')),
  priority_level INT NOT NULL,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 10. جدول الصلاحيات
CREATE TABLE IF NOT EXISTS permissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code VARCHAR(100) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  name_ar VARCHAR(255) NOT NULL,
  description TEXT,
  category VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 11. جدول ربط الأدوار بالصلاحيات
CREATE TABLE IF NOT EXISTS role_permissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  role_id UUID NOT NULL REFERENCES admin_roles(id) ON DELETE CASCADE,
  permission_id UUID NOT NULL REFERENCES permissions(id) ON DELETE CASCADE,
  is_granted BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(role_id, permission_id)
);

-- 12. جدول مسؤولي النظام
CREATE TABLE IF NOT EXISTS admin_users (
  id UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  role_id UUID NOT NULL REFERENCES admin_roles(id),
  assigned_areas TEXT[] DEFAULT ARRAY[]::TEXT[],
  last_login TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 13. جدول سجل التدقيق
CREATE TABLE IF NOT EXISTS audit_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  admin_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  admin_name VARCHAR(255) NOT NULL,
  action VARCHAR(100) NOT NULL,
  action_ar VARCHAR(100) NOT NULL,
  target_type VARCHAR(50) NOT NULL,
  target_id UUID NOT NULL,
  changes JSONB,
  ip_address VARCHAR(50),
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 14. جدول الشكاوى والنزاعات
CREATE TABLE IF NOT EXISTS support_tickets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  trip_id UUID REFERENCES trips(id) ON DELETE SET NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  ticket_type VARCHAR(50) NOT NULL CHECK (ticket_type IN ('complaint', 'dispute', 'inquiry', 'suggestion')),
  priority VARCHAR(50) DEFAULT 'medium' CHECK (priority IN ('low', 'medium', 'high', 'urgent')),
  status VARCHAR(50) DEFAULT 'open' CHECK (status IN ('open', 'in_progress', 'resolved', 'closed')),
  assigned_to UUID REFERENCES users(id),
  resolution TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  resolved_at TIMESTAMP
);

-- 15. جدول الإشعارات
CREATE TABLE IF NOT EXISTS notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  notification_type VARCHAR(50) NOT NULL,
  trip_id UUID REFERENCES trips(id) ON DELETE SET NULL,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  read_at TIMESTAMP
);

-- ============================================
-- الفهارس لتحسين الأداء
-- ============================================

CREATE INDEX idx_users_phone ON users(phone);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_drivers_status ON drivers(status);
CREATE INDEX idx_drivers_location ON drivers USING GIST(current_location);
CREATE INDEX idx_trips_merchant_id ON trips(merchant_id);
CREATE INDEX idx_trips_driver_id ON trips(driver_id);
CREATE INDEX idx_trips_status ON trips(status);
CREATE INDEX idx_trips_created_at ON trips(created_at);
CREATE INDEX idx_wallet_transactions_user_id ON wallet_transactions(user_id);
CREATE INDEX idx_wallet_transactions_created_at ON wallet_transactions(created_at);
CREATE INDEX idx_withdrawal_requests_user_id ON withdrawal_requests(user_id);
CREATE INDEX idx_withdrawal_requests_status ON withdrawal_requests(status);
CREATE INDEX idx_offers_is_active ON offers(is_active);
CREATE INDEX idx_audit_logs_admin_id ON audit_logs(admin_id);
CREATE INDEX idx_audit_logs_timestamp ON audit_logs(timestamp);
CREATE INDEX idx_support_tickets_user_id ON support_tickets(user_id);
CREATE INDEX idx_support_tickets_status ON support_tickets(status);
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);

-- ============================================
-- إدراج الأدوار الإدارية الافتراضية
-- ============================================

INSERT INTO admin_roles (name, name_ar, description, role_type, priority_level, is_active) VALUES
('Super Admin', 'مسؤول النظام الأساسي', 'التحكم الكامل في النظام', 'super_admin', 1, TRUE),
('Operations Manager', 'مدير العمليات', 'إدارة العمليات اليومية والرحلات الحية', 'operations_manager', 2, TRUE),
('Driver Verification Officer', 'مسؤول التحقق من السائقين', 'التحقق من هوية السائقين والمستندات', 'driver_verification_officer', 3, TRUE),
('Finance Manager', 'مدير مالي', 'إدارة المدفوعات والمحافظ', 'finance_manager', 4, TRUE),
('Support Agent', 'وكيل خدمة العملاء', 'التعامل مع الشكاوى والنزاعات', 'support_agent', 5, TRUE);

-- ============================================
-- إدراج الصلاحيات الافتراضية
-- ============================================

INSERT INTO permissions (code, name, name_ar, description, category) VALUES
-- User Management
('view_users', 'View Users', 'عرض المستخدمين', 'عرض قائمة المستخدمين', 'user_management'),
('create_user', 'Create User', 'إنشاء مستخدم', 'إنشاء حساب مستخدم جديد', 'user_management'),
('edit_user', 'Edit User', 'تعديل المستخدم', 'تعديل بيانات المستخدم', 'user_management'),
('delete_user', 'Delete User', 'حذف المستخدم', 'حذف حساب المستخدم', 'user_management'),
('suspend_user', 'Suspend User', 'تعليق المستخدم', 'تعليق حساب المستخدم مؤقتاً', 'user_management'),
('manage_user_roles', 'Manage User Roles', 'إدارة أدوار المستخدمين', 'تغيير أدوار المستخدمين', 'user_management'),

-- Driver Management
('view_drivers', 'View Drivers', 'عرض السائقين', 'عرض قائمة السائقين', 'driver_management'),
('verify_driver', 'Verify Driver', 'التحقق من السائق', 'الموافقة على تفعيل حساب السائق', 'driver_management'),
('reject_driver', 'Reject Driver', 'رفض السائق', 'رفض طلب تفعيل حساب السائق', 'driver_management'),
('suspend_driver', 'Suspend Driver', 'تعليق السائق', 'تعليق حساب السائق', 'driver_management'),
('view_driver_documents', 'View Driver Documents', 'عرض مستندات السائق', 'عرض المستندات المرفوعة', 'driver_management'),
('detect_fraud', 'Detect Fraud', 'كشف الاحتيال', 'تحديد الحسابات المزيفة', 'driver_management'),

-- Finance Management
('view_financials', 'View Financials', 'عرض البيانات المالية', 'عرض الحسابات المالية', 'finance_management'),
('approve_payments', 'Approve Payments', 'الموافقة على المدفوعات', 'الموافقة على المدفوعات', 'finance_management'),
('process_withdrawals', 'Process Withdrawals', 'معالجة السحب', 'معالجة طلبات السحب', 'finance_management'),
('manage_wallets', 'Manage Wallets', 'إدارة المحافظ', 'إدارة رصيد المحافظ', 'finance_management'),
('view_transactions', 'View Transactions', 'عرض المعاملات', 'عرض سجل المعاملات', 'finance_management'),
('generate_financial_reports', 'Generate Financial Reports', 'إنشاء تقارير مالية', 'إنشاء التقارير المالية', 'finance_management'),

-- Trip Management
('view_trips', 'View Trips', 'عرض الرحلات', 'عرض قائمة الرحلات', 'trip_management'),
('monitor_live_trips', 'Monitor Live Trips', 'مراقبة الرحلات الحية', 'مراقبة الرحلات الجارية', 'trip_management'),
('cancel_trip', 'Cancel Trip', 'إلغاء الرحلة', 'إلغاء رحلة', 'trip_management'),
('resolve_disputes', 'Resolve Disputes', 'حل النزاعات', 'حل النزاعات بين المستخدمين', 'trip_management'),

-- Offer Management
('view_offers', 'View Offers', 'عرض العروض', 'عرض قائمة العروض', 'offer_management'),
('create_offer', 'Create Offer', 'إنشاء عرض', 'إنشاء عرض جديد', 'offer_management'),
('edit_offer', 'Edit Offer', 'تعديل العرض', 'تعديل بيانات العرض', 'offer_management'),
('delete_offer', 'Delete Offer', 'حذف العرض', 'حذف العرض', 'offer_management'),
('activate_offer', 'Activate Offer', 'تفعيل العرض', 'تفعيل العرض', 'offer_management'),
('deactivate_offer', 'Deactivate Offer', 'تعطيل العرض', 'تعطيل العرض', 'offer_management'),

-- Support Management
('view_tickets', 'View Tickets', 'عرض التذاكر', 'عرض تذاكر الدعم', 'support_management'),
('respond_to_tickets', 'Respond to Tickets', 'الرد على التذاكر', 'الرد على تذاكر الدعم', 'support_management'),
('close_tickets', 'Close Tickets', 'إغلاق التذاكر', 'إغلاق تذاكر الدعم', 'support_management'),
('escalate_tickets', 'Escalate Tickets', 'تصعيد التذاكر', 'تصعيد التذاكر للإدارة', 'support_management'),

-- System Configuration
('manage_commissions', 'Manage Commissions', 'إدارة العمولات', 'تعديل نسب العمولات', 'system_configuration'),
('manage_areas', 'Manage Areas', 'إدارة المناطق', 'إدارة المناطق الجغرافية', 'system_configuration'),
('manage_system_settings', 'Manage System Settings', 'إدارة إعدادات النظام', 'تعديل إعدادات النظام', 'system_configuration'),
('shutdown_system', 'Shutdown System', 'إيقاف النظام', 'إيقاف النظام بالكامل', 'system_configuration'),
('shutdown_area', 'Shutdown Area', 'إيقاف منطقة', 'إيقاف منطقة جغرافية', 'system_configuration'),

-- Reporting
('view_reports', 'View Reports', 'عرض التقارير', 'عرض التقارير', 'reporting'),
('generate_reports', 'Generate Reports', 'إنشاء تقارير', 'إنشاء تقارير جديدة', 'reporting'),
('export_data', 'Export Data', 'تصدير البيانات', 'تصدير البيانات', 'reporting'),

-- Audit Log
('view_audit_log', 'View Audit Log', 'عرض سجل التدقيق', 'عرض سجل الإجراءات', 'audit_log'),
('view_admin_actions', 'View Admin Actions', 'عرض إجراءات الإدارة', 'عرض إجراءات المسؤولين', 'audit_log');

-- ============================================
-- ربط الأدوار بالصلاحيات
-- ============================================

-- Super Admin - جميع الصلاحيات
INSERT INTO role_permissions (role_id, permission_id, is_granted)
SELECT ar.id, p.id, TRUE
FROM admin_roles ar, permissions p
WHERE ar.role_type = 'super_admin';

-- Operations Manager
INSERT INTO role_permissions (role_id, permission_id, is_granted)
SELECT ar.id, p.id, TRUE
FROM admin_roles ar, permissions p
WHERE ar.role_type = 'operations_manager'
AND p.code IN ('view_trips', 'monitor_live_trips', 'cancel_trip', 'resolve_disputes', 'view_users', 'view_drivers', 'view_tickets', 'respond_to_tickets');

-- Driver Verification Officer
INSERT INTO role_permissions (role_id, permission_id, is_granted)
SELECT ar.id, p.id, TRUE
FROM admin_roles ar, permissions p
WHERE ar.role_type = 'driver_verification_officer'
AND p.code IN ('view_drivers', 'verify_driver', 'reject_driver', 'suspend_driver', 'view_driver_documents', 'detect_fraud');

-- Finance Manager
INSERT INTO role_permissions (role_id, permission_id, is_granted)
SELECT ar.id, p.id, TRUE
FROM admin_roles ar, permissions p
WHERE ar.role_type = 'finance_manager'
AND p.code IN ('view_financials', 'approve_payments', 'process_withdrawals', 'manage_wallets', 'view_transactions', 'generate_financial_reports', 'view_reports', 'export_data');

-- Support Agent
INSERT INTO role_permissions (role_id, permission_id, is_granted)
SELECT ar.id, p.id, TRUE
FROM admin_roles ar, permissions p
WHERE ar.role_type = 'support_agent'
AND p.code IN ('view_tickets', 'respond_to_tickets', 'close_tickets', 'escalate_tickets', 'view_trips', 'resolve_disputes');
