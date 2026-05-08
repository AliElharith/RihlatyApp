-- جدول طلبات تحديد سعر الرحلة من الإدارة
CREATE TABLE IF NOT EXISTS trip_pricing_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id VARCHAR(255) NOT NULL UNIQUE,
  user_id UUID NOT NULL REFERENCES users(id),
  selected_driver_id UUID REFERENCES drivers(id),
  pickup_lat DECIMAL(10, 8) NOT NULL,
  pickup_lng DECIMAL(11, 8) NOT NULL,
  dropoff_lat DECIMAL(10, 8) NOT NULL,
  dropoff_lng DECIMAL(11, 8) NOT NULL,
  pickup_address TEXT NOT NULL,
  dropoff_address TEXT NOT NULL,
  calculated_distance DECIMAL(10, 2) NOT NULL,
  suggested_price DECIMAL(10, 2) NOT NULL,
  admin_approved_price DECIMAL(10, 2),
  trip_status VARCHAR(50) DEFAULT 'pending' CHECK (trip_status IN ('pending', 'approved', 'rejected', 'completed')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  approved_at TIMESTAMP WITH TIME ZONE,
  approved_by_admin UUID REFERENCES admin_users(id),
  price_adjustment_reason TEXT,
  requires_admin_approval BOOLEAN DEFAULT FALSE,
  notes TEXT,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- جدول إشعارات السائقين بالرحلات
CREATE TABLE IF NOT EXISTS driver_notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  driver_id UUID NOT NULL REFERENCES drivers(id),
  trip_id VARCHAR(255) NOT NULL,
  type VARCHAR(50) NOT NULL DEFAULT 'trip_offer',
  title VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  price DECIMAL(10, 2),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  is_read BOOLEAN DEFAULT FALSE,
  read_at TIMESTAMP WITH TIME ZONE
);

-- جدول سجل تعديلات الأسعار
CREATE TABLE IF NOT EXISTS price_adjustment_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  trip_id VARCHAR(255) NOT NULL,
  admin_id UUID NOT NULL REFERENCES admin_users(id),
  original_price DECIMAL(10, 2) NOT NULL,
  adjusted_price DECIMAL(10, 2) NOT NULL,
  adjustment_reason TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- الفهارس
CREATE INDEX idx_trip_pricing_trip_id ON trip_pricing_requests(trip_id);
CREATE INDEX idx_trip_pricing_user_id ON trip_pricing_requests(user_id);
CREATE INDEX idx_trip_pricing_status ON trip_pricing_requests(trip_status);
CREATE INDEX idx_trip_pricing_created_at ON trip_pricing_requests(created_at);
CREATE INDEX idx_driver_notifications_driver_id ON driver_notifications(driver_id);
CREATE INDEX idx_driver_notifications_is_read ON driver_notifications(is_read);
CREATE INDEX idx_price_adjustment_logs_trip_id ON price_adjustment_logs(trip_id);

-- سياسات الأمان (RLS)
ALTER TABLE trip_pricing_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE driver_notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE price_adjustment_logs ENABLE ROW LEVEL SECURITY;

-- سياسة للمستخدمين العاديين
CREATE POLICY "Users can view their own trip pricing requests"
  ON trip_pricing_requests FOR SELECT
  USING (auth.uid() = user_id);

-- سياسة للإدارة
CREATE POLICY "Admins can view all trip pricing requests"
  ON trip_pricing_requests FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM admin_users
      WHERE admin_users.id = auth.uid()
    )
  );

-- سياسة لإشعارات السائقين
CREATE POLICY "Drivers can view their own notifications"
  ON driver_notifications FOR SELECT
  USING (auth.uid() = driver_id);

