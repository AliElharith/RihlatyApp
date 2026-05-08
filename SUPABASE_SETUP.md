# 🔗 دليل ربط Supabase - تطبيق رحلتي

## 📋 المحتويات

1. [إنشاء حساب Supabase](#إنشاء-حساب-supabase)
2. [إنشاء المشروع](#إنشاء-المشروع)
3. [إنشاء جداول قاعدة البيانات](#إنشاء-جداول-قاعدة-البيانات)
4. [تكوين المصادقة](#تكوين-المصادقة)
5. [إعداد التطبيق](#إعداد-التطبيق)
6. [اختبار الاتصال](#اختبار-الاتصال)

---

## 🚀 إنشاء حساب Supabase

### الخطوة 1: الذهاب إلى الموقع
1. اذهب إلى [https://supabase.com](https://supabase.com)
2. انقر على **"Sign Up"**
3. سجل باستخدام بريدك الإلكتروني أو حساب GitHub

### الخطوة 2: التحقق من البريد الإلكتروني
- تحقق من بريدك الإلكتروني
- انقر على رابط التحقق

---

## 📁 إنشاء المشروع

### الخطوة 1: إنشاء مشروع جديد
1. بعد تسجيل الدخول، انقر على **"New Project"**
2. اختر اسم المشروع: **"rihlaty"**
3. اختر كلمة مرور قوية
4. اختر المنطقة الجغرافية (اختر الأقرب لك)
5. انقر على **"Create new project"**

### الخطوة 2: انتظر التهيئة
- سيستغرق الأمر 2-3 دقائق
- ستظهر رسالة عند انتهاء التهيئة

### الخطوة 3: احصل على المفاتيح
1. اذهب إلى **Settings** (الإعدادات)
2. اختر **API**
3. انسخ:
   - **Project URL** (استخدمه كـ `SUPABASE_URL`)
   - **anon public** (استخدمه كـ `SUPABASE_ANON_KEY`)

```
SUPABASE_URL: https://your-project.supabase.co
SUPABASE_ANON_KEY: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

---

## 🗄️ إنشاء جداول قاعدة البيانات

### الطريقة 1: استخدام SQL Editor (الأفضل)

1. اذهب إلى **SQL Editor** في لوحة التحكم
2. انقر على **"New Query"**
3. انسخ محتوى ملف `supabase_schema.sql` بالكامل
4. الصق الكود في محرر SQL
5. انقر على **"Run"** أو اضغط `Ctrl+Enter`

```sql
-- سيتم تنفيذ جميع الجداول والفهارس والبيانات الافتراضية
```

### الطريقة 2: إنشاء يدوي (خطوة بخطوة)

إذا فضلت الطريقة اليدوية، يمكنك:

1. اذهب إلى **Table Editor**
2. انقر على **"New Table"**
3. أنشئ الجداول التالية:

#### جدول المستخدمين (users)
```
- id (UUID) - Primary Key
- email (Text) - Unique
- phone (Text) - Unique
- name (Text)
- role (Text) - merchant, driver, admin
- profile_image_url (Text)
- is_verified (Boolean)
- is_active (Boolean)
- wallet_balance (Number)
- rating (Number)
- created_at (Timestamp)
- updated_at (Timestamp)
```

#### جدول السائقين (drivers)
```
- id (UUID) - Foreign Key to users
- license_number (Text) - Unique
- license_expiry (Date)
- vehicle_type (Text)
- vehicle_plate (Text) - Unique
- vehicle_image_url (Text)
- national_id (Text) - Unique
- is_verified (Boolean)
- status (Text) - online, offline, busy
- total_trips (Number)
- completed_trips (Number)
- created_at (Timestamp)
```

#### جدول الرحلات (trips)
```
- id (UUID) - Primary Key
- merchant_id (UUID) - Foreign Key
- driver_id (UUID) - Foreign Key
- pickup_address (Text)
- dropoff_address (Text)
- package_type (Text)
- estimated_fare (Number)
- final_fare (Number)
- status (Text) - pending, accepted, in_progress, completed, cancelled
- created_at (Timestamp)
- completed_at (Timestamp)
```

#### جدول المحفظة (wallet_transactions)
```
- id (UUID) - Primary Key
- user_id (UUID) - Foreign Key
- transaction_type (Text) - credit, debit, refund
- amount (Number)
- description (Text)
- trip_id (UUID) - Foreign Key
- created_at (Timestamp)
```

#### جدول العروض (offers)
```
- id (UUID) - Primary Key
- title (Text)
- description (Text)
- offer_type (Text) - percentage, fixed_amount, free_trip
- discount_percentage (Number)
- is_active (Boolean)
- start_date (Timestamp)
- end_date (Timestamp)
- usage_count (Number)
- created_at (Timestamp)
```

---

## 🔐 تكوين المصادقة

### الخطوة 1: تفعيل المصادقة
1. اذهب إلى **Authentication** في لوحة التحكم
2. انقر على **"Providers"**
3. تأكد من تفعيل **Email** (يجب أن يكون مفعلاً افتراضياً)

### الخطوة 2: إعدادات البريد الإلكتروني
1. اذهب إلى **Email Templates**
2. يمكنك تخصيص رسائل البريد الإلكتروني إذا أردت

### الخطوة 3: إعدادات الجلسة
1. اذهب إلى **Auth > Policies**
2. تأكد من السماح بالتسجيل الجديد

---

## ⚙️ إعداد التطبيق

### الخطوة 1: تحديث ملف Constants
في ملف `lib/config/constants.dart`:

```dart
class AppConstants {
  // استبدل بمفاتيحك الحقيقية
  static const String supabaseUrl = 'https://your-project.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key-here';
  
  // ... بقية الثوابت
}
```

### الخطوة 2: تثبيت المكتبات
```bash
flutter pub get
```

### الخطوة 3: تهيئة Supabase في main.dart
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة Supabase
  await SupabaseService().initialize();
  
  runApp(const MyApp());
}
```

---

## 🧪 اختبار الاتصال

### اختبار 1: التسجيل
```dart
// في شاشة التسجيل
final response = await SupabaseService().signUpWithPhone(
  '0501234567',
  'password123',
  'أحمد محمد',
  'merchant',
);

if (response.user != null) {
  print('✅ تم التسجيل بنجاح');
} else {
  print('❌ فشل التسجيل');
}
```

### اختبار 2: تسجيل الدخول
```dart
final response = await SupabaseService().signInWithPhone(
  '0501234567',
  'password123',
);

if (response.user != null) {
  print('✅ تم تسجيل الدخول بنجاح');
} else {
  print('❌ فشل تسجيل الدخول');
}
```

### اختبار 3: جلب بيانات المستخدم
```dart
final user = SupabaseService().getCurrentUser();
if (user != null) {
  final userData = await SupabaseService().getUserData(user.id);
  print('✅ بيانات المستخدم: $userData');
}
```

### اختبار 4: إنشاء رحلة
```dart
final tripId = await SupabaseService().createTrip({
  'merchant_id': merchantId,
  'pickup_address': 'شارع النيل، القاهرة',
  'dropoff_address': 'شارع التحرير، القاهرة',
  'package_type': 'صناديق',
  'estimated_fare': 50.0,
  'status': 'pending',
});

print('✅ تم إنشاء رحلة: $tripId');
```

---

## 🐛 استكشاف الأخطاء

### خطأ: "Connection refused"
**السبب**: بيانات Supabase غير صحيحة

**الحل**:
1. تحقق من `SUPABASE_URL` و `SUPABASE_ANON_KEY`
2. تأكد من نسخهما بشكل صحيح بدون مسافات
3. أعد تشغيل التطبيق

### خطأ: "Invalid API key"
**السبب**: مفتاح API غير صحيح

**الحل**:
1. اذهب إلى Settings > API
2. انسخ المفتاح الصحيح
3. حدّث ملف Constants

### خطأ: "Table does not exist"
**السبب**: لم يتم إنشاء الجداول

**الحل**:
1. اذهب إلى SQL Editor
2. نفّذ ملف `supabase_schema.sql`
3. تحقق من إنشاء الجداول في Table Editor

### خطأ: "Permission denied"
**السبب**: سياسات الأمان غير صحيحة

**الحل**:
1. اذهب إلى Authentication > Policies
2. أضف سياسات جديدة إذا لزم الأمر
3. تأكد من السماح بالعمليات المطلوبة

---

## 📊 التحقق من البيانات

### عرض البيانات في لوحة التحكم
1. اذهب إلى **Table Editor**
2. اختر الجدول الذي تريد عرضه
3. ستظهر جميع البيانات

### تشغيل استعلامات SQL
1. اذهب إلى **SQL Editor**
2. اكتب استعلام SQL
3. انقر على **Run**

```sql
-- مثال: الحصول على جميع المستخدمين
SELECT * FROM users;

-- مثال: الحصول على الرحلات المعلقة
SELECT * FROM trips WHERE status = 'pending';

-- مثال: الحصول على إجمالي الرحلات لكل تاجر
SELECT merchant_id, COUNT(*) as total_trips FROM trips GROUP BY merchant_id;
```

---

## 🔒 أفضل الممارسات الأمنية

### 1. حماية المفاتيح
- ❌ لا تشارك مفاتيحك مع أحد
- ❌ لا تضعها في GitHub
- ✅ استخدم ملفات `.env` محلية

### 2. سياسات الأمان (RLS)
```sql
-- مثال: السماح للمستخدمين برؤية بياناتهم فقط
CREATE POLICY "Users can view their own data" ON users
  FOR SELECT USING (auth.uid() = id);
```

### 3. التحقق من الصلاحيات
```dart
// تحقق دائماً من صلاحيات المستخدم قبل أي عملية
if (user.role == 'admin') {
  // قم بالعملية الإدارية
}
```

### 4. تشفير البيانات الحساسة
```dart
// استخدم تشفير للبيانات الحساسة
String encryptedData = encrypt(sensitiveData);
```

---

## 📞 الدعم والمساعدة

### موارد مفيدة
- [توثيق Supabase](https://supabase.com/docs)
- [منتدى Supabase](https://github.com/supabase/supabase/discussions)
- [مثال Flutter + Supabase](https://github.com/supabase/supabase-flutter/tree/main/examples)

### الحصول على المساعدة
- البريد الإلكتروني: support@rihlaty.com
- الموقع: www.rihlaty.com

---

## ✅ قائمة التحقق

- [ ] تم إنشاء حساب Supabase
- [ ] تم إنشاء مشروع جديد
- [ ] تم نسخ `SUPABASE_URL` و `SUPABASE_ANON_KEY`
- [ ] تم تحديث ملف `constants.dart`
- [ ] تم تنفيذ ملف `supabase_schema.sql`
- [ ] تم تثبيت المكتبات (`flutter pub get`)
- [ ] تم اختبار الاتصال بنجاح
- [ ] تم التحقق من البيانات في لوحة التحكم

---

**تم! الآن التطبيق متصل بـ Supabase وجاهز للعمل! 🎉**
