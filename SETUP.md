# 🚀 دليل البدء السريع

## المتطلبات الأساسية

قبل البدء، تأكد من تثبيت:

- **Flutter**: [تحميل Flutter](https://flutter.dev/docs/get-started/install)
- **Dart**: يأتي مع Flutter
- **Android Studio** أو **Xcode** (حسب النظام)
- **Git**: [تحميل Git](https://git-scm.com)

## خطوات التثبيت

### 1️⃣ استنساخ المشروع

```bash
git clone <repository-url>
cd rihlaty_app
```

### 2️⃣ تثبيت المكتبات

```bash
flutter pub get
```

### 3️⃣ إعداد Supabase

#### أ) إنشاء حساب Supabase
1. اذهب إلى [supabase.com](https://supabase.com)
2. أنشئ حساباً جديداً
3. أنشئ مشروعاً جديداً

#### ب) الحصول على المفاتيح
1. اذهب إلى Project Settings
2. انسخ:
   - **Project URL**
   - **Anon Public Key**

#### ج) تحديث الإعدادات
عدّل `lib/config/constants.dart`:

```dart
const String SUPABASE_URL = 'https://your-project.supabase.co';
const String SUPABASE_ANON_KEY = 'your-anon-key';
```

### 4️⃣ تشغيل التطبيق

#### على Android
```bash
flutter run
```

#### على iOS
```bash
flutter run -d iphone
```

#### على جهاز محاكي
```bash
flutter run -d emulator-5554
```

## ✅ التحقق من التثبيت

```bash
# تحقق من تثبيت Flutter
flutter --version

# تحقق من توفر الأجهزة
flutter devices

# تشغيل الاختبارات
flutter test
```

## 🎯 الخطوات التالية

1. **اقرأ التوثيق الكاملة**: انظر `DOCUMENTATION.md`
2. **استكشف الشاشات**: جرّب جميع الشاشات والميزات
3. **عدّل الإعدادات**: خصص التطبيق حسب احتياجاتك
4. **أضف ميزات جديدة**: طور ميزات إضافية

## 🐛 استكشاف الأخطاء الشائعة

### ❌ خطأ: "flutter command not found"
```bash
# أضف Flutter إلى PATH
export PATH="$PATH:[flutter-path]/bin"
```

### ❌ خطأ: "Supabase connection failed"
- تحقق من المفاتيح في `constants.dart`
- تحقق من الاتصال بالإنترنت
- تحقق من حالة خادم Supabase

### ❌ خطأ: "Gradle build failed"
```bash
flutter clean
flutter pub get
flutter run
```

### ❌ خطأ: "CocoaPods error" (iOS)
```bash
cd ios
rm Podfile.lock
cd ..
flutter pub get
flutter run
```

## 📱 اختبار التطبيق

### حسابات اختبار

**تاجر:**
- الهاتف: 0501234567
- كلمة المرور: password123

**سائق:**
- الهاتف: 0509876543
- كلمة المرور: password123

**إدارة:**
- الهاتف: 0505555555
- كلمة المرور: admin123

## 🔧 الإعدادات المتقدمة

### تغيير الثيم

عدّل `lib/config/theme.dart`:

```dart
// تغيير اللون الأساسي
const Color primary = Color(0xFFB71C1C);

// تغيير الخط
const String fontFamily = 'Cairo';
```

### تفعيل الوضع الليلي

عدّل `lib/main.dart`:

```dart
theme: AppTheme.lightTheme(),
darkTheme: AppTheme.darkTheme(),
themeMode: ThemeMode.system,
```

### إضافة لغة جديدة

1. أنشئ ملف ترجمة جديد في `lib/l10n/`
2. أضف الترجمات
3. حدّث `main.dart`

## 📦 بناء التطبيق للإنتاج

### بناء APK (Android)
```bash
flutter build apk --release
```

### بناء AAB (Google Play)
```bash
flutter build appbundle --release
```

### بناء IPA (iOS)
```bash
flutter build ios --release
```

## 🚀 النشر

### نشر على Google Play
1. أنشئ حساب Google Play Developer
2. أنشئ تطبيقاً جديداً
3. حمّل AAB
4. أكمل البيانات والمراجعة

### نشر على App Store
1. أنشئ حساب Apple Developer
2. أنشئ تطبيقاً جديداً في App Store Connect
3. حمّل IPA
4. أكمل البيانات والمراجعة

## 📚 موارد إضافية

- [Flutter Documentation](https://flutter.dev/docs)
- [Supabase Tutorials](https://supabase.com/docs)
- [Riverpod Guide](https://riverpod.dev)
- [Material Design](https://material.io/design)

## 💡 نصائح مهمة

✅ استخدم `flutter analyze` للتحقق من الأخطاء
✅ استخدم `flutter format` لتنسيق الكود
✅ استخدم `flutter test` لتشغيل الاختبارات
✅ احفظ عملك بانتظام مع Git

## 📞 الحصول على الدعم

إذا واجهت مشاكل:

1. تحقق من [Flutter Issues](https://github.com/flutter/flutter/issues)
2. ابحث في [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
3. اتصل بفريق الدعم: support@rihlaty.com

---

**مرحباً بك في رحلتي! 🎉**

استمتع بتطوير التطبيق وإنشاء شيء رائع!
