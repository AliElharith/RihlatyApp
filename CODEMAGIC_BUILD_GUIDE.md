# 🚀 دليل البناء على Codemagic - تطبيق رحلتي

## 📋 المحتويات

1. [إنشاء حساب Codemagic](#إنشاء-حساب-codemagic)
2. [ربط المشروع](#ربط-المشروع)
3. [إعداد البناء](#إعداد-البناء)
4. [تحميل الـ Keystore](#تحميل-الـ-keystore)
5. [بناء APK](#بناء-apk)
6. [تحميل على Google Play](#تحميل-على-google-play)

---

## 🔐 إنشاء حساب Codemagic

### الخطوة 1: الذهاب إلى الموقع
1. اذهب إلى [https://codemagic.io](https://codemagic.io)
2. انقر على **"Sign Up"**
3. اختر **"GitHub"** أو **"Google"** للتسجيل السريع

### الخطوة 2: التحقق من البريد الإلكتروني
- تحقق من بريدك الإلكتروني
- انقر على رابط التفعيل

---

## 📁 ربط المشروع

### الطريقة 1: من GitHub (الأفضل)

#### 1️⃣ رفع المشروع على GitHub

```bash
# إنشاء مستودع GitHub جديد
# اذهب إلى https://github.com/new
# أنشئ مستودع باسم "rihlaty-app"

# في مجلد المشروع:
cd /path/to/rihlaty_app
git init
git add .
git commit -m "Initial commit: Rihlaty App"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/rihlaty-app.git
git push -u origin main
```

#### 2️⃣ ربط Codemagic مع GitHub

1. في Codemagic، انقر على **"Add application"**
2. اختر **"GitHub"**
3. صرّح Codemagic بالوصول إلى حسابك
4. اختر المستودع **"rihlaty-app"**
5. انقر على **"Authorize"**

### الطريقة 2: من ZIP (إذا لم تستخدم GitHub)

1. في Codemagic، انقر على **"Add application"**
2. اختر **"Upload"**
3. اختر ملف ZIP الخاص بك
4. انقر على **"Upload"**

---

## ⚙️ إعداد البناء

### الخطوة 1: إنشاء Build Configuration

1. بعد ربط المشروع، انقر على **"Start your first build"**
2. اختر **"Android"**
3. انقر على **"Create configuration"**

### الخطوة 2: إعدادات البناء الأساسية

| الإعداد | القيمة |
|--------|--------|
| **Build mode** | Release |
| **Artifact type** | APK |
| **Flutter version** | Latest stable |
| **Xcode version** | Latest |

### الخطوة 3: تفعيل الميزات

- ✅ **Publish** - لتحميل APK تلقائياً
- ✅ **Post-build script** - لتشغيل أوامر بعد البناء
- ✅ **Webhooks** - لتشغيل البناء تلقائياً عند الـ push

---

## 🔑 تحميل الـ Keystore

### الخطوة 1: تحضير الملفات

لديك بالفعل:
- ✅ `rihlaty_keystore.jks` - ملف التوقيع
- ✅ `android/key.properties` - بيانات التوقيع

### الخطوة 2: تحميل في Codemagic

1. في Codemagic، اذهب إلى **Settings** (الإعدادات)
2. اختر **"Code signing"**
3. انقر على **"Android signing"**
4. اختر **"Upload keystore"**
5. اختر ملف `rihlaty_keystore.jks`
6. أدخل:
   - **Keystore password**: `rihlaty@2024`
   - **Key alias**: `rihlaty_key`
   - **Key password**: `rihlaty@2024`
7. انقر على **"Upload"**

### الخطوة 3: تفعيل التوقيع

1. في إعدادات البناء، اختر **"Android signing"**
2. اختر الـ keystore الذي حملته للتو
3. تأكد من تفعيل **"Sign release build"**

---

## 🏗️ بناء APK

### الخطوة 1: بدء البناء

1. في Codemagic، انقر على **"Build"** أو **"Start new build"**
2. اختر **"Android"**
3. اختر **"Release"**
4. انقر على **"Build"**

### الخطوة 2: مراقبة البناء

- ستظهر شاشة **Build logs**
- انتظر حتى ينتهي البناء (عادة 5-10 دقائق)
- ستظهر رسالة **"Build successful"** عند الانتهاء

### الخطوة 3: تحميل APK

1. بعد انتهاء البناء، انقر على **"Download"**
2. اختر **"APK"**
3. سيتم تحميل الملف على جهازك

---

## 📱 تثبيت على جهازك

### من الكمبيوتر

```bash
# تثبيت ADB (Android Debug Bridge)
# ثم:
adb install /path/to/rihlaty_app-release.apk
```

### من الهاتف مباشرة

1. انسخ ملف APK إلى هاتفك
2. افتح مدير الملفات
3. اضغط على ملف APK
4. اختر **"تثبيت"**
5. اسمح بالتثبيت من مصادر غير معروفة إذا لزم الأمر

---

## 🎯 تحميل على Google Play

### الخطوة 1: إنشاء حساب Google Play Developer

1. اذهب إلى [https://play.google.com/console](https://play.google.com/console)
2. انقر على **"Create account"**
3. ادفع رسم التسجيل ($25)
4. أكمل ملف الحساب

### الخطوة 2: إنشاء تطبيق جديد

1. في Google Play Console، انقر على **"Create app"**
2. أدخل:
   - **App name**: Rihlaty
   - **Default language**: Arabic
   - **App type**: Application
3. انقر على **"Create"**

### الخطوة 3: إعداد التطبيق

1. اذهب إلى **"App content"** وأكمل المعلومات
2. اذهب إلى **"Pricing & distribution"**
3. اختر البلدان المستهدفة
4. انقر على **"Save"**

### الخطوة 4: تحميل APK

1. اذهب إلى **"Release"** > **"Production"**
2. انقر على **"Create new release"**
3. اختر **"Browse files"**
4. اختر ملف APK من Codemagic
5. أضف **"Release notes"** (ملاحظات الإصدار)
6. انقر على **"Review"**
7. انقر على **"Release to production"**

---

## 📊 معلومات الـ Keystore

| المعلومة | القيمة |
|---------|--------|
| **Keystore file** | rihlaty_keystore.jks |
| **Keystore password** | rihlaty@2024 |
| **Key alias** | rihlaty_key |
| **Key password** | rihlaty@2024 |
| **Validity** | 10000 days (~27 years) |
| **Algorithm** | RSA 2048-bit |

⚠️ **مهم**: احفظ هذه المعلومات في مكان آمن! ستحتاجها لتحديث التطبيق لاحقاً.

---

## 🔄 تحديث التطبيق

### عند إصدار نسخة جديدة:

1. حدّث `pubspec.yaml` - غيّر `version: 1.0.0+1` إلى `1.0.1+2`
2. اضغط على GitHub:
   ```bash
   git add .
   git commit -m "Version 1.0.1"
   git push
   ```
3. Codemagic سيبني تلقائياً (إذا فعّلت Webhooks)
4. حمّل APK الجديد من Codemagic
5. رفعه على Google Play

---

## 🐛 استكشاف الأخطاء

### خطأ: "Build failed"
- تحقق من **Build logs**
- تأكد من أن جميع المكتبات مثبتة: `flutter pub get`
- جرّب: `flutter clean && flutter pub get`

### خطأ: "Signing failed"
- تأكد من كلمات المرور صحيحة
- تأكد من أن الـ keystore محمّل في Codemagic
- تحقق من `key.properties`

### خطأ: "Google Maps not showing"
- تأكد من API key صحيح في `AndroidManifest.xml`
- تفعّل Google Maps API في Google Cloud Console
- أضف بصمة التطبيق (SHA-1) إلى Google Cloud Console

---

## 📞 الدعم والمساعدة

### موارد مفيدة
- [توثيق Codemagic](https://docs.codemagic.io)
- [توثيق Flutter](https://flutter.dev/docs)
- [Google Play Console Help](https://support.google.com/googleplay/android-developer)

### الحصول على المساعدة
- البريد الإلكتروني: support@rihlaty.com
- الموقع: www.rihlaty.com

---

## ✅ قائمة التحقق

- [ ] تم إنشاء حساب Codemagic
- [ ] تم ربط المشروع (GitHub أو ZIP)
- [ ] تم تحميل الـ keystore
- [ ] تم إعداد البناء
- [ ] تم بناء APK بنجاح
- [ ] تم تثبيت APK على الهاتف
- [ ] تم اختبار التطبيق
- [ ] تم إنشاء حساب Google Play Developer
- [ ] تم تحميل على Google Play
- [ ] تم نشر التطبيق

---

**تم! التطبيق الآن جاهز للبناء والنشر! 🎉**
