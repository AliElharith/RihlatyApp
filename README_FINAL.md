# 🚀 تطبيق رحلتي - Rihlaty App

## 📱 نظرة عامة

**رحلتي** هو تطبيق جوال متقدم يربط المستخدمين بسائقي التكاتك والسيارات لنقل البضائع بسهولة وأمان. التطبيق مبني بـ Flutter ويعمل على Android و iOS.

### 🎯 الميزات الرئيسية

#### 👥 للمستخدمين
- ✅ تسجيل سهل وآمن
- ✅ طلب رحلة فورية
- ✅ **حجز مسبق متقدم** (Advanced Booking)
- ✅ **البحث عن سائق معين** بالاسم
- ✅ تتبع الرحلة الحية مع الخرائط
- ✅ محفظة رقمية
- ✅ سجل الرحلات
- ✅ نظام التقييم والمراجعات

#### 🚗 للسائقين
- ✅ تسجيل وتحقق من المستندات
- ✅ قبول الرحلات
- ✅ تتبع الموقع الحي
- ✅ إدارة الدخل
- ✅ سجل الرحلات المكتملة

#### 🛡️ للإدارة
- ✅ **5 أدوار إدارية** متقدمة:
  - Super Admin (التحكم الكامل)
  - Operations Manager (مدير العمليات)
  - Driver Verification Officer (مسؤول التحقق)
  - Finance Manager (مدير مالي)
  - Support Agent (خدمة العملاء)
- ✅ لوحة تحكم شاملة
- ✅ إدارة العروض والتخفيفات
- ✅ سجل التدقيق الشامل
- ✅ إدارة الدعم والنزاعات

---

## 🛠️ المتطلبات

### البرامج المطلوبة
- **Flutter**: 3.11.5+
- **Dart**: 3.11.5+
- **Android SDK**: API 21+
- **Java**: JDK 17+
- **Git**: للتحكم بالإصدارات

### الحسابات المطلوبة
- **Supabase**: لقاعدة البيانات
- **Google Maps API**: للخرائط
- **Firebase**: للإشعارات (اختياري)

---

## 📦 البدء السريع

### 1️⃣ استخراج الملف

```bash
unzip rihlaty_app.zip
cd rihlaty_app
```

### 2️⃣ تثبيت المكتبات

```bash
flutter pub get
```

### 3️⃣ إعداد Supabase

```bash
# اتبع دليل SUPABASE_SETUP.md
# أدخل بيانات Supabase في lib/config/constants.dart
```

### 4️⃣ تشغيل التطبيق

```bash
# على جهاز محاكاة
flutter run

# على جهاز فعلي
flutter run -d <device_id>
```

---

## 📁 هيكل المشروع

```
rihlaty_app/
├── lib/
│   ├── config/
│   │   ├── constants.dart          # ثوابت التطبيق
│   │   ├── theme.dart              # الثيم والألوان
│   │   └── router.dart             # التوجيه
│   ├── models/
│   │   ├── user_model.dart         # نموذج المستخدم
│   │   ├── trip_model.dart         # نموذج الرحلة
│   │   ├── advanced_booking_model.dart  # الحجز المسبق
│   │   ├── offer_model.dart        # نموذج العروض
│   │   └── admin_role_model.dart   # نموذج الأدوار
│   ├── services/
│   │   └── supabase_service.dart   # خدمات Supabase (50+ دالة)
│   ├── providers/
│   │   └── auth_provider.dart      # مزود المصادقة
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── splash_screen.dart
│   │   │   ├── login_screen.dart
│   │   │   └── register_screen.dart
│   │   ├── user/
│   │   │   ├── user_home_screen.dart
│   │   │   └── request_trip_screen.dart
│   │   ├── driver/
│   │   │   └── driver_home_screen.dart
│   │   ├── admin/
│   │   │   └── admin_dashboard_comprehensive.dart
│   │   └── shared/
│   │       ├── advanced_booking_screen.dart    # ✨ جديد
│   │       ├── driver_search_screen.dart       # ✨ جديد
│   │       ├── trip_tracking_screen.dart
│   │       ├── wallet_screen.dart
│   │       └── profile_screen.dart
│   └── main.dart
├── android/
│   ├── app/
│   │   ├── build.gradle.kts        # إعدادات البناء
│   │   ├── proguard-rules.pro       # قواعد ProGuard
│   │   └── src/main/AndroidManifest.xml
│   ├── key.properties              # بيانات التوقيع
│   └── ...
├── assets/
│   ├── images/
│   ├── icons/
│   ├── animations/
│   └── fonts/
├── pubspec.yaml                    # المكتبات والإعدادات
├── .gitignore                      # ملفات Git المستثناة
├── rihlaty_keystore.jks            # ملف التوقيع الرقمي
├── SUPABASE_SETUP.md               # دليل إعداد Supabase
├── CODEMAGIC_BUILD_GUIDE.md        # دليل البناء على Codemagic
└── README_FINAL.md                 # هذا الملف
```

---

## 🔧 الإعدادات المهمة

### 1️⃣ إعدادات Supabase

في `lib/config/constants.dart`:

```dart
class AppConstants {
  static const String supabaseUrl = 'https://your-project.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key-here';
}
```

### 2️⃣ إعدادات Google Maps

في `android/app/src/main/AndroidManifest.xml`:

```xml
<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY" />
```

### 3️⃣ إعدادات التوقيع

في `android/key.properties`:

```properties
storePassword=rihlaty@2024
keyPassword=rihlaty@2024
keyAlias=rihlaty_key
storeFile=../rihlaty_keystore.jks
```

---

## 🚀 البناء والنشر

### بناء APK للاختبار

```bash
flutter build apk --debug
```

### بناء APK للإصدار

```bash
flutter build apk --release
```

### بناء AAB لـ Google Play

```bash
flutter build appbundle --release
```

### البناء على Codemagic

اتبع دليل **CODEMAGIC_BUILD_GUIDE.md** الكامل

---

## 📊 المكتبات المستخدمة

| المكتبة | الإصدار | الاستخدام |
|--------|---------|----------|
| **google_maps_flutter** | 2.5.0 | الخرائط |
| **supabase_flutter** | 1.10.0 | قاعدة البيانات |
| **go_router** | 13.0.0 | التوجيه |
| **flutter_riverpod** | 2.4.0 | إدارة الحالة |
| **firebase_messaging** | 14.6.0 | الإشعارات |
| **geolocator** | 10.0.0 | تحديد الموقع |
| **image_picker** | 1.0.0 | اختيار الصور |
| **intl** | 0.19.0 | التدويل |
| **dio** | 5.3.0 | الشبكة |
| **logger** | 2.0.0 | التسجيل |

---

## 🔐 الأمان

### المصادقة
- ✅ مصادقة آمنة عبر Supabase
- ✅ تشفير كلمات المرور
- ✅ جلسات آمنة

### البيانات
- ✅ تشفير البيانات الحساسة
- ✅ سياسات الأمان (RLS)
- ✅ سجل تدقيق شامل

### التطبيق
- ✅ توقيع رقمي للـ APK
- ✅ ProGuard obfuscation
- ✅ معالجة الأخطاء الآمنة

---

## 📱 حسابات الاختبار

| النوع | الهاتف | كلمة المرور |
|------|--------|-----------|
| مستخدم | 0501234567 | password123 |
| سائق | 0509876543 | password123 |
| إدارة | 0505555555 | admin123 |

---

## 🐛 استكشاف الأخطاء

### خطأ: "Supabase connection failed"
```bash
# تحقق من الإنترنت
# تأكد من بيانات Supabase صحيحة
# جرّب: flutter clean && flutter pub get
```

### خطأ: "Google Maps not showing"
```bash
# تأكد من API key صحيح
# فعّل Google Maps API
# أضف SHA-1 fingerprint
```

### خطأ: "Build failed on Codemagic"
```bash
# اقرأ Build logs
# تأكد من keystore محمّل
# جرّب: flutter clean
```

---

## 📚 الملفات الإضافية

| الملف | الوصف |
|------|-------|
| **SUPABASE_SETUP.md** | دليل إعداد قاعدة البيانات |
| **CODEMAGIC_BUILD_GUIDE.md** | دليل البناء والنشر |
| **supabase_schema.sql** | مخطط قاعدة البيانات |
| **ADMIN_ROLES_DOCUMENTATION.md** | توثيق الأدوار الإدارية |

---

## 🔄 التحديثات والصيانة

### تحديث المكتبات

```bash
flutter pub upgrade
```

### تحديث إصدار التطبيق

في `pubspec.yaml`:

```yaml
version: 1.0.1+2  # Major.Minor.Patch+BuildNumber
```

### نشر نسخة جديدة

```bash
git add .
git commit -m "Version 1.0.1"
git push
# Codemagic سيبني تلقائياً
```

---

## 📞 الدعم والمساعدة

### موارد مفيدة
- [توثيق Flutter](https://flutter.dev/docs)
- [توثيق Supabase](https://supabase.com/docs)
- [توثيق Google Maps](https://developers.google.com/maps)
- [توثيق Codemagic](https://docs.codemagic.io)

### الاتصال
- **البريد الإلكتروني**: support@rihlaty.com
- **الموقع**: www.rihlaty.com
- **الهاتف**: +20 1234567890

---

## 📄 الترخيص

هذا المشروع مرخص تحت **MIT License**.

---

## 👥 المساهمون

- **الفريق**: فريق تطوير رحلتي
- **الإصدار**: 1.0.0
- **آخر تحديث**: مايو 2024

---

## ✅ قائمة التحقق قبل النشر

- [ ] تم اختبار جميع الشاشات
- [ ] تم اختبار الخرائط
- [ ] تم اختبار الحجز المسبق
- [ ] تم اختبار البحث عن السائق
- [ ] تم اختبار المصادقة
- [ ] تم اختبار الدفع
- [ ] تم اختبار الإشعارات
- [ ] تم اختبار الأداء
- [ ] تم اختبار الأمان
- [ ] تم بناء APK بنجاح
- [ ] تم تحميل على Google Play
- [ ] تم الحصول على تقييمات إيجابية

---

**شكراً لاستخدام تطبيق رحلتي! 🎉**

**للمزيد من المعلومات، اقرأ الملفات الأخرى في المشروع.**
