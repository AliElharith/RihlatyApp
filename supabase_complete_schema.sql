-- ============================================
-- قاعدة بيانات تطبيق رحلتي الكاملة
-- ============================================

-- 1. جدول المستخدمين الأساسي
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  phone VARCHAR(20) UNIQUE NOT NULL,
  full_name VARCHAR(255) NOT NULL,
  user_type VARCHAR(50) NOT NULL CHECK (user_type IN ('user', 'driver', 'admin')),
  profile_image_url TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  is_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. جدول المستخدمين (العملاء)
CREATE TABLE IF NOT EXISTS user_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE,
  address TEXT,
  city VARCHAR(100),
  country VARCHAR(100),
  postal_code VARCHAR(20),
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  total_trips INT DEFAULT 0,
  total_spent DECIMAL(12, 2) DEFAULT 0,
  average_rating DECIMAL(3, 2) DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. جدول السائقين
CREATE TABLE IF NOT EXISTS drivers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE,
  license_number VARCHAR(50) UNIQUE NOT NULL,
  license_expiry DATE NOT NULL,
  vehicle_type VARCHAR(50) NOT NULL,
  vehicle_number VARCHAR(50) UNIQUE NOT NULL,
  vehicle_color VARCHAR(50),
  vehicle_model VARCHAR(100),
  vehicle_image_url TEXT,
  national_id VARCHAR(50) UNIQUE NOT NULL,
  national_id_image_url TEXT,
  is_verified BOOLEAN DEFAULT FALSE,
  verification_status VARCHAR(50) DEFAULT 'pending' CHECK (verification_status IN ('pending', 'approved', 'rejected', 'suspended')),
  total_trips INT DEFAULT 0,
  total_earnings DECIMAL(12, 2) DEFAULT 0,
  average_rating DECIMAL(3, 2) DEFAULT 0,
  is_online BOOLEAN DEFAULT FALSE,
  current_latitude DECIMAL(10, 8),
  current_longitude DECIMAL(11, 8),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. جدول المسؤولين
CREATE TABLE IF NOT EXISTS admin_users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE,
  admin_role VARCHAR(50) NOT NULL CHECK (admin_role IN (
    'super_admin',
    'operations_manager',
    'driver_verification_officer',
    'finance_manager',
    'support_agent'
  )),
  permissions TEXT[], -- JSON array of permissions
  assigned_region VARCHAR(255),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. جدول الرحلات
CREATE TABLE IF NOT EXISTS trips (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id VARCHAR(255) UNIQUE NOT NULL,
  user_id UUID NOT NULL,
  driver_id UUID,
  pickup_latitude DECIMAL(10, 8) NOT NULL,
  pickup_longitude DECIMAL(11, 8) NOT NULL,
  pickup_address TEXT NOT NULL,
  dropoff_latitude DECIMAL(10, 8) NOT NULL,
  dropoff_longitude DECIMAL(11, 8) NOT NULL,
  dropoff_address TEXT NOT NULL,
  trip_distance DECIMAL(10, 2),
  estimated_duration INT, -- بالدقائق
  base_price DECIMAL(10, 2),
  final_price DECIMAL(10, 2),
  trip_status VARCHAR(50) DEFAULT 'pending' CHECK (trip_status IN (
    'pending', 'accepted', 'in_progress', 'completed', 'cancelled', 'rejected'
  )),
  payment_status VARCHAR(50) DEFAULT 'pending' CHECK (payment_status IN (
    'pending', 'completed', 'failed', 'refunded'
  )),
  scheduled_time TIMESTAMP WITH TIME ZONE,
  started_at TIMESTAMP WITH TIME ZONE,
  completed_at TIMESTAMP WITH TIME ZONE,
  cancellation_reason TEXT,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. جدول المحافظ
CREATE TABLE IF NOT EXISTS wallets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE,
  balance DECIMAL(12, 2) DEFAULT 0,
  total_added DECIMAL(12, 2) DEFAULT 0,
  total_spent DECIMAL(12, 2) DEFAULT 0,
  currency VARCHAR(10) DEFAULT 'SAR',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 7. جدول المدفوعات
CREATE TABLE IF NOT EXISTS payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id UUID NOT NULL,
  user_id UUID NOT NULL,
  driver_id UUID,
  amount DECIMAL(10, 2) NOT NULL,
  payment_method VARCHAR(50) NOT NULL CHECK (payment_method IN (
    'wallet', 'credit_card', 'debit_card', 'cash'
  )),
  payment_status VARCHAR(50) DEFAULT 'pending' CHECK (payment_status IN (
    'pending', 'completed', 'failed', 'refunded'
  )),
  transaction_id VARCHAR(255),
  commission_amount DECIMAL(10, 2) DEFAULT 0,
  driver_earnings DECIMAL(10, 2) DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 8. جدول التقييمات
CREATE TABLE IF NOT EXISTS ratings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id UUID NOT NULL UNIQUE,
  rater_id UUID NOT NULL,
  rated_user_id UUID NOT NULL,
  rating_type VARCHAR(50) NOT NULL CHECK (rating_type IN ('user_to_driver', 'driver_to_user')),
  rating_score INT NOT NULL CHECK (rating_score >= 1 AND rating_score <= 5),
  comment TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 9. جدول طلبات الدعم
CREATE TABLE IF NOT EXISTS support_tickets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL,
  trip_id UUID,
  subject VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  ticket_status VARCHAR(50) DEFAULT 'open' CHECK (ticket_status IN (
    'open', 'in_progress', 'resolved', 'closed'
  )),
  priority VARCHAR(50) DEFAULT 'medium' CHECK (priority IN (
    'low', 'medium', 'high', 'urgent'
  )),
  assigned_to UUID, -- support agent
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 10. جدول العروض والتخفيفات
CREATE TABLE IF NOT EXISTS offers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  offer_name VARCHAR(255) NOT NULL,
  offer_type VARCHAR(50) NOT NULL CHECK (offer_type IN (
    'percentage', 'fixed_amount', 'free_ride', 'reduced_commission', 'night_discount', 'new_user'
  )),
  discount_value DECIMAL(10, 2) NOT NULL,
  max_discount DECIMAL(10, 2),
  min_trip_amount DECIMAL(10, 2),
  usage_limit INT,
  used_count INT DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE,
  start_date TIMESTAMP WITH TIME ZONE,
  end_date TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 11. جدول استخدام العروض
CREATE TABLE IF NOT EXISTS offer_usage (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  offer_id UUID NOT NULL,
  user_id UUID NOT NULL,
  trip_id UUID NOT NULL,
  discount_applied DECIMAL(10, 2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 12. جدول طلبات تحديد سعر الرحلة
CREATE TABLE IF NOT EXISTS trip_pricing_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id VARCHAR(255) NOT NULL UNIQUE,
  user_id UUID NOT NULL,
  selected_driver_id UUID,
  pickup_lat DECIMAL(10, 8) NOT NULL,
  pickup_lng DECIMAL(11, 8) NOT NULL,
  dropoff_lat DECIMAL(10, 8) NOT NULL,
  dropoff_lng DECIMAL(11, 8) NOT NULL,
  pickup_address TEXT NOT NULL,
  dropoff_address TEXT NOT NULL,
  calculated_distance DECIMAL(10, 2) NOT NULL,
  suggested_price DECIMAL(10, 2) NOT NULL,
  admin_approved_price DECIMAL(10, 2),
  trip_status VARCHAR(50) DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  approved_at TIMESTAMP WITH TIME ZONE,
  approved_by_admin UUID,
  price_adjustment_reason TEXT,
  requires_admin_approval BOOLEAN DEFAULT FALSE,
  notes TEXT,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 13. جدول إشعارات السائقين
CREATE TABLE IF NOT EXISTS driver_notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  driver_id UUID NOT NULL,
  trip_id VARCHAR(255) NOT NULL,
  type VARCHAR(50) NOT NULL DEFAULT 'trip_offer',
  title VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  price DECIMAL(10, 2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  is_read BOOLEAN DEFAULT FALSE,
  read_at TIMESTAMP WITH TIME ZONE
);

-- 14. جدول سجل تعديلات الأسعار
CREATE TABLE IF NOT EXISTS price_adjustment_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id VARCHAR(255) NOT NULL,
  admin_id UUID NOT NULL,
  original_price DECIMAL(10, 2) NOT NULL,
  adjusted_price DECIMAL(10, 2) NOT NULL,
  adjustment_reason TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 15. جدول سجل التدقيق
CREATE TABLE IF NOT EXISTS audit_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  admin_id UUID NOT NULL,
  action VARCHAR(255) NOT NULL,
  entity_type VARCHAR(100),
  entity_id VARCHAR(255),
  old_values JSONB,
  new_values JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- الفهارس لتحسين الأداء
-- ============================================

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone);
CREATE INDEX IF NOT EXISTS idx_users_user_type ON users(user_type);
CREATE INDEX IF NOT EXISTS idx_user_profiles_user_id ON user_profiles(user_id);
CREATE INDEX IF NOT EXISTS idx_drivers_user_id ON drivers(user_id);
CREATE INDEX IF NOT EXISTS idx_drivers_verification_status ON drivers(verification_status);
CREATE INDEX IF NOT EXISTS idx_drivers_is_online ON drivers(is_online);
CREATE INDEX IF NOT EXISTS idx_admin_users_user_id ON admin_users(user_id);
CREATE INDEX IF NOT EXISTS idx_admin_users_role ON admin_users(admin_role);
CREATE INDEX IF NOT EXISTS idx_trips_user_id ON trips(user_id);
CREATE INDEX IF NOT EXISTS idx_trips_driver_id ON trips(driver_id);
CREATE INDEX IF NOT EXISTS idx_trips_trip_id ON trips(trip_id);
CREATE INDEX IF NOT EXISTS idx_trips_status ON trips(trip_status);
CREATE INDEX IF NOT EXISTS idx_trips_created_at ON trips(created_at);
CREATE INDEX IF NOT EXISTS idx_wallets_user_id ON wallets(user_id);
CREATE INDEX IF NOT EXISTS idx_payments_trip_id ON payments(trip_id);
CREATE INDEX IF NOT EXISTS idx_payments_user_id ON payments(user_id);
CREATE INDEX IF NOT EXISTS idx_payments_driver_id ON payments(driver_id);
CREATE INDEX IF NOT EXISTS idx_payments_status ON payments(payment_status);
CREATE INDEX IF NOT EXISTS idx_ratings_trip_id ON ratings(trip_id);
CREATE INDEX IF NOT EXISTS idx_ratings_rater_id ON ratings(rater_id);
CREATE INDEX IF NOT EXISTS idx_support_tickets_user_id ON support_tickets(user_id);
CREATE INDEX IF NOT EXISTS idx_support_tickets_status ON support_tickets(ticket_status);
CREATE INDEX IF NOT EXISTS idx_offers_is_active ON offers(is_active);
CREATE INDEX IF NOT EXISTS idx_offer_usage_user_id ON offer_usage(user_id);
CREATE INDEX IF NOT EXISTS idx_trip_pricing_trip_id ON trip_pricing_requests(trip_id);
CREATE INDEX IF NOT EXISTS idx_trip_pricing_user_id ON trip_pricing_requests(user_id);
CREATE INDEX IF NOT EXISTS idx_trip_pricing_status ON trip_pricing_requests(trip_status);
CREATE INDEX IF NOT EXISTS idx_driver_notifications_driver_id ON driver_notifications(driver_id);
CREATE INDEX IF NOT EXISTS idx_driver_notifications_is_read ON driver_notifications(is_read);
CREATE INDEX IF NOT EXISTS idx_price_adjustment_logs_trip_id ON price_adjustment_logs(trip_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_admin_id ON audit_logs(admin_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_created_at ON audit_logs(created_at);

-- ============================================
-- البيانات الافتراضية
-- ============================================

-- إضافة عينة من العروض
INSERT INTO offers (offer_name, offer_type, discount_value, is_active, start_date, end_date)
VALUES
  ('خصم 10% للمستخدمين الجدد', 'percentage', 10, TRUE, NOW(), NOW() + INTERVAL '30 days'),
  ('خصم 5 ريال على الرحلة', 'fixed_amount', 5, TRUE, NOW(), NOW() + INTERVAL '30 days'),
  ('رحلة مجانية بعد 3 رحلات', 'free_ride', 0, TRUE, NOW(), NOW() + INTERVAL '60 days'),
  ('خصم ليلي 15%', 'night_discount', 15, TRUE, NOW(), NOW() + INTERVAL '90 days'),
  ('عمولة مخفضة للسائقين', 'reduced_commission', 2, TRUE, NOW(), NOW() + INTERVAL '30 days');

-- ============================================
-- النهاية
-- ============================================
