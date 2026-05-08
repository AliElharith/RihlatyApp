# 📋 توثيق الأدوار الإدارية والعروض

## جدول المحتويات
1. [الأدوار الإدارية](#الأدوار-الإدارية)
2. [الصلاحيات](#الصلاحيات)
3. [نظام العروض والتخفيفات](#نظام-العروض-والتخفيفات)
4. [سجل التدقيق](#سجل-التدقيق)
5. [أمثلة الاستخدام](#أمثلة-الاستخدام)

---

## 🎯 الأدوار الإدارية

### 1. Super Admin (مسؤول النظام الأساسي)

#### الوصف
صاحب القرار النهائي في النظام بصلاحيات كاملة لا محدودة.

#### الصلاحيات الرئيسية
| الصلاحية | الوصف |
|---------|-------|
| **إدارة المستخدمين** | إنشاء وتعديل وحذف أي مستخدم |
| **إدارة الأدوار** | تعديل الأدوار والصلاحيات |
| **تعديل العمولات** | تغيير نسب العمولات بالكامل |
| **التحكم المالي الكامل** | الوصول الكامل للحسابات المالية |
| **إيقاف النظام** | إيقاف النظام أو منطقة كاملة |
| **إدارة الإعدادات** | التحكم في جميع إعدادات النظام |

#### المسؤوليات
- ✅ الإشراف العام على النظام
- ✅ اتخاذ القرارات الاستراتيجية
- ✅ إدارة الأزمات الكبرى
- ✅ تعيين وإدارة الأدوار الأخرى

#### مثال الاستخدام
```dart
// التحقق من صلاحية Super Admin
if (adminUser.role.hasPermission('shutdown_system')) {
  // يمكن إيقاف النظام
}
```

---

### 2. Operations Manager (مدير العمليات)

#### الوصف
**أهم دور في المشروع!** مسؤول عن العمليات اليومية والتنسيق بين جميع الأقسام.

#### الصلاحيات الرئيسية
| الصلاحية | الوصف |
|---------|-------|
| **متابعة الرحلات الحية** | مراقبة جميع الرحلات في الوقت الفعلي |
| **حل المشاكل اليومية** | معالجة الشكاوى والنزاعات |
| **مراقبة الأداء** | تتبع مؤشرات الأداء الرئيسية |
| **إدارة الطوارئ** | التعامل مع الحالات الطارئة |
| **تقارير الأداء** | إنشاء تقارير يومية وأسبوعية |

#### المسؤوليات
- ✅ متابعة الرحلات الحية 24/7
- ✅ حل النزاعات بين السائقين والتجار
- ✅ مراقبة جودة الخدمة
- ✅ الإبلاغ عن المشاكل الفنية
- ✅ تنسيق مع الأقسام الأخرى

#### تحذير ⚠️
> **بدون هذا الدور: المشروع حيكون "فوضى منظمة"**
> 
> لا أحد سيراقب الرحلات الحية، لا أحد سيحل المشاكل، وستكون هناك فوضى في التنسيق.

#### مثال الاستخدام
```dart
// مدير العمليات يراقب الرحلات الحية
if (adminUser.role.hasPermission('monitor_live_trips')) {
  // عرض جميع الرحلات الحية على الخريطة
  showLiveTripsMap();
}
```

---

### 3. Driver Verification Officer (مسؤول التحقق من السائقين)

#### الوصف
مسؤول عن التحقق من هوية السائقين ومراجعة المستندات والكشف عن الاحتيال.

#### الصلاحيات الرئيسية
| الصلاحية | الوصف |
|---------|-------|
| **مراجعة المستندات** | فحص جميع مستندات السائق |
| **قبول السائقين** | الموافقة على تفعيل الحساب |
| **رفض السائقين** | رفض الطلبات المريبة |
| **كشف الاحتيال** | تحديد السائقين المشبوهين |
| **تعليق الحساب** | إيقاف حساب السائق مؤقتاً |

#### المسؤوليات
- ✅ فحص المستندات الشخصية (رخصة القيادة، البطاقة الشخصية)
- ✅ التحقق من سجل السائق
- ✅ كشف الحسابات المزيفة
- ✅ التحقق من صور السائق والمركبة
- ✅ اتخاذ قرارات القبول/الرفض

#### تحذير ⚠️
> **أخطر حاجة: سائق غير موثوق = نهاية الثقة في التطبيق**
> 
> سائق واحد غير موثوق يمكن أن يدمر سمعة التطبيق بالكامل.

#### مثال الاستخدام
```dart
// مسؤول التحقق يراجع طلب سائق جديد
if (adminUser.role.hasPermission('verify_driver')) {
  // عرض المستندات والبيانات
  showDriverVerificationForm(driver);
  
  // الموافقة أو الرفض
  if (documentsAreValid) {
    approveDriver(driver.id);
  } else {
    rejectDriver(driver.id, reason);
  }
}
```

---

### 4. Finance Manager (مدير مالي)

#### الوصف
مسؤول عن جميع العمليات المالية والمدفوعات والمحافظ.

#### الصلاحيات الرئيسية
| الصلاحية | الوصف |
|---------|-------|
| **تأكيد المدفوعات** | الموافقة على المدفوعات |
| **إدارة المحافظ** | التحكم في رصيد المحافظ |
| **معالجة السحب** | الموافقة على طلبات السحب |
| **التقارير المالية** | إنشاء تقارير مالية |
| **تتبع المعاملات** | مراجعة جميع المعاملات |

#### المسؤوليات
- ✅ مراجعة طلبات السحب
- ✅ التحقق من صحة المدفوعات
- ✅ إدارة الحسابات البنكية
- ✅ معالجة النزاعات المالية
- ✅ إنشاء تقارير مالية دورية

#### تحذير ⚠️
> **دور ثقيل جداً خاصة مع نظام الدفع اليدوي**
> 
> كل معاملة مالية يجب أن تمر عبر هذا الدور للتحقق والموافقة.

#### مثال الاستخدام
```dart
// مدير مالي يوافق على طلب سحب
if (adminUser.role.hasPermission('process_withdrawals')) {
  // عرض طلبات السحب المعلقة
  showPendingWithdrawals();
  
  // الموافقة على الطلب
  approveWithdrawal(withdrawal.id, amount);
}
```

---

### 5. Support Agent (وكيل خدمة العملاء)

#### الوصف
مسؤول عن التعامل مع شكاوى العملاء والرد على الاستفسارات.

#### الصلاحيات الرئيسية
| الصلاحية | الوصف |
|---------|-------|
| **عرض التذاكر** | رؤية جميع شكاوى العملاء |
| **الرد على الشكاوى** | إرسال ردود للعملاء |
| **حل النزاعات** | معالجة النزاعات البسيطة |
| **إغلاق التذاكر** | إنهاء الشكاوى المحلولة |
| **تصعيد الحالات** | نقل الحالات المعقدة للإدارة |

#### المسؤوليات
- ✅ الرد على استفسارات العملاء
- ✅ حل المشاكل البسيطة
- ✅ توثيق الشكاوى
- ✅ متابعة رضا العملاء
- ✅ تصعيد الحالات المعقدة

#### مثال الاستخدام
```dart
// وكيل الدعم يرد على شكوى عميل
if (adminUser.role.hasPermission('respond_to_tickets')) {
  // عرض التذاكر المعلقة
  showPendingTickets();
  
  // الرد على التذكرة
  respondToTicket(ticket.id, response);
}
```

---

## 🔐 الصلاحيات

### تصنيفات الصلاحيات

#### 1. إدارة المستخدمين (User Management)
```
- view_users: عرض قائمة المستخدمين
- create_user: إنشاء مستخدم جديد
- edit_user: تعديل بيانات المستخدم
- delete_user: حذف المستخدم
- suspend_user: تعليق حساب المستخدم
- manage_user_roles: تعديل أدوار المستخدمين
```

#### 2. إدارة السائقين (Driver Management)
```
- view_drivers: عرض قائمة السائقين
- verify_driver: الموافقة على السائق
- reject_driver: رفض طلب السائق
- suspend_driver: تعليق حساب السائق
- view_driver_documents: عرض مستندات السائق
- detect_fraud: كشف الاحتيال
```

#### 3. الإدارة المالية (Finance Management)
```
- view_financials: عرض البيانات المالية
- approve_payments: الموافقة على المدفوعات
- process_withdrawals: معالجة طلبات السحب
- manage_wallets: إدارة المحافظ
- view_transactions: عرض المعاملات
- generate_financial_reports: إنشاء تقارير مالية
```

#### 4. إدارة الرحلات (Trip Management)
```
- view_trips: عرض الرحلات
- monitor_live_trips: مراقبة الرحلات الحية
- cancel_trip: إلغاء رحلة
- resolve_disputes: حل النزاعات
```

#### 5. إدارة العروض (Offer Management)
```
- view_offers: عرض العروض
- create_offer: إنشاء عرض جديد
- edit_offer: تعديل العرض
- delete_offer: حذف العرض
- activate_offer: تفعيل العرض
- deactivate_offer: تعطيل العرض
```

#### 6. إدارة الدعم (Support Management)
```
- view_tickets: عرض التذاكر
- respond_to_tickets: الرد على التذاكر
- close_tickets: إغلاق التذاكر
- escalate_tickets: تصعيد التذاكر
```

#### 7. إعدادات النظام (System Configuration)
```
- manage_commissions: إدارة العمولات
- manage_areas: إدارة المناطق
- manage_system_settings: إعدادات النظام
- shutdown_system: إيقاف النظام
- shutdown_area: إيقاف منطقة
```

---

## 🎁 نظام العروض والتخفيفات

### أنواع العروض

#### 1. Percentage Discount (خصم نسبة مئوية)
```dart
Offer(
  type: OfferType.percentage,
  discountPercentage: 20.0, // 20% خصم
  title: 'خصم 20% على جميع الرحلات',
)
```

#### 2. Fixed Amount (خصم مبلغ ثابت)
```dart
Offer(
  type: OfferType.fixedAmount,
  discountPercentage: 10.0, // 10 ر.س خصم
  title: 'خصم 10 ريال على الرحلة',
)
```

#### 3. Free Trip (رحلة مجانية)
```dart
Offer(
  type: OfferType.freeTrip,
  freeTripsAfterTrips: 3, // رحلة مجانية بعد 3 رحلات
  title: 'رحلة مجانية بعد كل 3 رحلات',
  description: 'للسائقين والتجار',
)
```

#### 4. Reduced Commission (عمولة مخفضة)
```dart
Offer(
  type: OfferType.reducedCommission,
  discountPercentage: 5.0, // عمولة مخفضة 5%
  title: 'عمولة مخفضة للسائقين الجدد',
)
```

#### 5. Night Discount (خصم ليلي)
```dart
Offer(
  type: OfferType.nightDiscount,
  discountPercentage: 15.0, // 15% خصم
  title: 'خصم 15% على الرحلات الليلية',
  description: 'من 10 مساءً إلى 6 صباحاً',
)
```

#### 6. New User Offer (عرض للمستخدمين الجدد)
```dart
Offer(
  type: OfferType.newUserOffer,
  discountPercentage: 25.0, // 25% خصم
  title: 'عرض ترحيب: خصم 25% لأول 5 رحلات',
)
```

### نظام العرض الأساسي: "رحلة مجانية بعد 3 رحلات"

#### الآلية
```
الرحلة 1 ✓ (مدفوعة)
الرحلة 2 ✓ (مدفوعة)
الرحلة 3 ✓ (مدفوعة)
الرحلة 4 ✓ (مجانية!) ← تطبيق العرض تلقائياً
الرحلة 5 ✓ (مدفوعة) ← إعادة العداد
```

#### التطبيق
```dart
// حساب عدد الرحلات للمستخدم
int tripCount = await getTripCountForUser(userId);

// التحقق من استحقاق العرض
if (tripCount % 3 == 0 && tripCount > 0) {
  // تطبيق رحلة مجانية
  applyFreeTrip(userId, tripId);
  
  // إنشاء سجل استخدام العرض
  createOfferUsage(
    offerId: 'free_trip_offer',
    userId: userId,
    tripId: tripId,
    savingsAmount: tripPrice,
  );
}
```

### إدارة العروض

#### إنشاء عرض جديد
```dart
// يجب أن يكون لديك صلاحية 'create_offer'
if (adminUser.role.hasPermission('create_offer')) {
  Offer newOffer = Offer(
    title: 'عرض خاص',
    description: 'خصم 30% على الرحلات',
    type: OfferType.percentage,
    discountPercentage: 30.0,
    startDate: DateTime.now(),
    endDate: DateTime.now().add(Duration(days: 7)),
    applicableRoles: ['merchant', 'driver'],
    isActive: true,
  );
  
  await createOffer(newOffer);
}
```

#### تعديل عرض
```dart
if (adminUser.role.hasPermission('edit_offer')) {
  Offer updatedOffer = existingOffer.copyWith(
    discountPercentage: 25.0,
    endDate: DateTime.now().add(Duration(days: 14)),
  );
  
  await updateOffer(updatedOffer);
}
```

#### تعطيل/تفعيل عرض
```dart
if (adminUser.role.hasPermission('deactivate_offer')) {
  await deactivateOffer(offerId);
}

if (adminUser.role.hasPermission('activate_offer')) {
  await activateOffer(offerId);
}
```

### إحصائيات العروض

```dart
// الحصول على إحصائيات العروض
OfferStats stats = await getOfferStats();

print('إجمالي العروض: ${stats.totalOffers}');
print('العروض النشطة: ${stats.activeOffers}');
print('إجمالي الاستخدام: ${stats.totalUsage}');
print('إجمالي التوفير: ${stats.totalSavings} ر.س');

// أفضل العروض أداءً
for (var offer in stats.topOffers) {
  print('${offer.title}: ${offer.usageCount} استخدام');
}
```

---

## 📊 سجل التدقيق

### تسجيل الإجراءات الإدارية

```dart
// تسجيل أي إجراء إداري
AuditLog log = AuditLog(
  adminId: adminUser.id,
  adminName: adminUser.name,
  action: 'approve_driver',
  actionAr: 'الموافقة على السائق',
  targetType: 'driver',
  targetId: driver.id,
  changes: {
    'status': 'pending → verified',
    'verified_at': DateTime.now().toString(),
  },
  ipAddress: userIpAddress,
  timestamp: DateTime.now(),
);

await logAuditAction(log);
```

### عرض سجل التدقيق

```dart
// عرض جميع الإجراءات الإدارية
List<AuditLog> logs = await getAuditLogs(
  startDate: DateTime.now().subtract(Duration(days: 30)),
  endDate: DateTime.now(),
);

for (var log in logs) {
  print('${log.adminName}: ${log.actionAr} - ${log.targetType}');
}
```

---

## 💡 أمثلة الاستخدام

### مثال 1: Super Admin يعطل منطقة

```dart
if (currentUser.role.type == AdminRoleType.superAdmin &&
    currentUser.role.hasPermission('shutdown_area')) {
  
  // إيقاف منطقة معينة
  await shutdownArea(
    areaId: 'cairo_area_1',
    reason: 'صيانة الخوادم',
    duration: Duration(hours: 2),
  );
  
  // تسجيل الإجراء
  await logAuditAction(
    action: 'shutdown_area',
    targetId: 'cairo_area_1',
  );
}
```

### مثال 2: Operations Manager يحل نزاع

```dart
if (currentUser.role.type == AdminRoleType.operationsManager &&
    currentUser.role.hasPermission('resolve_disputes')) {
  
  // حل النزاع لصالح التاجر
  await resolveDispute(
    tripId: trip.id,
    decision: DisputeDecision.merchantWins,
    reason: 'السائق لم يصل للموقع المحدد',
    refundAmount: trip.amount,
  );
  
  // إرسال إشعار للطرفين
  await notifyUser(driver.id, 'تم حل النزاع');
  await notifyUser(merchant.id, 'تم حل النزاع');
}
```

### مثال 3: Driver Verification Officer يرفض سائق

```dart
if (currentUser.role.type == AdminRoleType.driverVerificationOfficer &&
    currentUser.role.hasPermission('reject_driver')) {
  
  // رفض طلب السائق
  await rejectDriver(
    driverId: driver.id,
    reason: 'المستندات غير واضحة',
    rejectionReason: RejectionReason.unclearDocuments,
  );
  
  // إرسال إشعار للسائق
  await notifyUser(driver.id, 'تم رفض طلبك. الرجاء تحديث المستندات');
}
```

### مثال 4: Finance Manager يوافق على سحب

```dart
if (currentUser.role.type == AdminRoleType.financeManager &&
    currentUser.role.hasPermission('process_withdrawals')) {
  
  // الموافقة على طلب السحب
  await approveWithdrawal(
    withdrawalId: withdrawal.id,
    amount: withdrawal.amount,
    bankAccount: withdrawal.bankAccount,
  );
  
  // تحديث رصيد المحفظة
  await updateWalletBalance(
    userId: withdrawal.userId,
    amount: -withdrawal.amount,
  );
  
  // إرسال إشعار
  await notifyUser(withdrawal.userId, 'تم الموافقة على طلب السحب');
}
```

### مثال 5: Support Agent يرد على شكوى

```dart
if (currentUser.role.type == AdminRoleType.supportAgent &&
    currentUser.role.hasPermission('respond_to_tickets')) {
  
  // الرد على التذكرة
  await respondToTicket(
    ticketId: ticket.id,
    response: 'شكراً على تواصلك. سيتم معالجة مشكلتك في أقرب وقت',
    priority: TicketPriority.high,
  );
  
  // تحديث حالة التذكرة
  await updateTicketStatus(
    ticketId: ticket.id,
    status: TicketStatus.inProgress,
  );
}
```

---

## 🔄 تدفق العمل الموصى به

### تدفق معالجة الشكاوى

```
Support Agent يستقبل الشكوى
        ↓
تقييم الشكوى (بسيطة/معقدة)
        ↓
إذا بسيطة: Support Agent يحلها
        ↓
إذا معقدة: تصعيد إلى Operations Manager
        ↓
Operations Manager يحل النزاع
        ↓
إذا تتعلق بمال: Finance Manager يتولى المعالجة
        ↓
تسجيل الإجراء في سجل التدقيق
        ↓
إرسال إشعار للعميل
```

### تدفق التحقق من السائق

```
سائق جديد يقدم طلب
        ↓
Driver Verification Officer يراجع المستندات
        ↓
التحقق من الهوية والرخصة والمركبة
        ↓
كشف الاحتيال (التحقق من الصور)
        ↓
قبول ✓ أو رفض ✗
        ↓
إرسال إشعار للسائق
        ↓
تسجيل الإجراء في سجل التدقيق
```

---

## 📈 مؤشرات الأداء الرئيسية (KPIs)

### للعمليات
- عدد الرحلات الحية
- معدل إكمال الرحلات
- متوسط وقت الانتظار
- معدل الرضا

### للسائقين
- عدد السائقين الموثقين
- معدل قبول الطلبات
- متوسط التقييم
- معدل الاحتفاظ

### المالية
- إجمالي الإيرادات
- العمولات المجمعة
- المدفوعات المعلقة
- معدل الاحتفاظ بالأموال

### الدعم
- عدد التذاكر المعلقة
- متوسط وقت الرد
- معدل حل المشاكل
- رضا العملاء

---

## 🔒 أفضل الممارسات الأمنية

1. **التحقق من الصلاحيات دائماً**
   ```dart
   if (!adminUser.role.hasPermission(requiredPermission)) {
     throw UnauthorizedException('ليس لديك صلاحية لهذا الإجراء');
   }
   ```

2. **تسجيل جميع الإجراءات**
   ```dart
   await logAuditAction(action, targetId, changes);
   ```

3. **التحقق من الهوية**
   ```dart
   if (adminUser.isActive && adminUser.lastLogin.isRecent()) {
     // السماح بالإجراء
   }
   ```

4. **تحديد المناطق المسؤول عنها**
   ```dart
   if (!adminUser.canManageArea(areaId)) {
     throw UnauthorizedException('أنت لا تدير هذه المنطقة');
   }
   ```

---

**آخر تحديث**: يناير 2024
**الإصدار**: 1.0.0
