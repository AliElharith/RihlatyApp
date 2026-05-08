# 🚀 دليل البدء السريع - تطبيق رحلتي

## ✅ المتطلبات

- **Flutter**: 3.11.5 أو أحدث
- **Dart**: 3.11.5 أو أحدث
- **Android Studio** أو **Xcode**
- **Git**

## 📥 التثبيت

### 1. استخراج الملف
```bash
unzip rihlaty_app.zip
cd rihlaty_app
```

### 2. تثبيت المكتبات
```bash
flutter pub get
```

### 3. إعداد Supabase (اختياري)
عدّل `lib/config/constants.dart`:
```dart
const String SUPABASE_URL = 'your_project_url';
const String SUPABASE_ANON_KEY = 'your_anon_key';
```

### 4. تشغيل التطبيق
```bash
flutter run
```

## 📱 حسابات الاختبار

| النوع | الهاتف | كلمة المرور |
|------|--------|-----------|
| تاجر | 0501234567 | password123 |
| سائق | 0509876543 | password123 |
| إدارة | 0505555555 | admin123 |

## 🎯 الشاشات الرئيسية

### للتاجر
- ✅ الشاشة الرئيسية
- ✅ طلب رحلة جديدة
- ✅ تتبع الرحلة
- ✅ المحفظة
- ✅ الملف الشخصي

### للسائق
- ✅ الشاشة الرئيسية
- ✅ الرحلات المتاحة
- ✅ تتبع الرحلة
- ✅ المحفظة
- ✅ الملف الشخصي

### للإدارة
- ✅ لوحة التحكم الشاملة
- ✅ إدارة المستخدمين
- ✅ إدارة السائقين
- ✅ الإدارة المالية
- ✅ خدمة العملاء
- ✅ إدارة العروض
- ✅ الإعدادات

## 🎨 الميزات

✨ تصميم عصري وأنيق
✨ أنيميشنات احترافية
✨ تدرجات لونية جميلة
✨ دعم RTL للعربية
✨ نظام إداري متكامل
✨ إدارة العروض والتخفيفات

## 📚 التوثيق

- **DOCUMENTATION.md** - التوثيق الشاملة
- **SETUP.md** - دليل البدء المفصل
- **ADMIN_ROLES_DOCUMENTATION.md** - توثيق الأدوار الإدارية
- **FILES_STRUCTURE.md** - هيكل الملفات

## 🐛 استكشاف الأخطاء

### خطأ: "flutter command not found"
```bash
export PATH="$PATH:[flutter-path]/bin"
```

### خطأ: "Gradle build failed"
```bash
flutter clean
flutter pub get
flutter run
```

### خطأ: "CocoaPods error" (iOS)
```bash
cd ios
rm Podfile.lock
cd ..
flutter pub get
flutter run
```

## 🔧 الأوامر المفيدة

```bash
# تنظيف المشروع
flutter clean

# تحديث المكتبات
flutter pub get

# تشغيل الاختبارات
flutter test

# بناء APK
flutter build apk --release

# بناء AAB (Google Play)
flutter build appbundle --release

# بناء IPA (iOS)
flutter build ios --release
```

## 📞 الدعم

للمساعدة والاستفسارات:
- البريد: support@rihlaty.com
- الموقع: www.rihlaty.com

---

**استمتع بتطوير التطبيق! 🎉**
