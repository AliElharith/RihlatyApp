import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../config/constants.dart';

// تعريف الأدوار الإدارية
enum AdminRole {
  superAdmin,
  operationsManager,
  driverVerificationOfficer,
  financeManager,
  supportAgent,
}

class AdminDashboardComprehensive extends ConsumerStatefulWidget {
  const AdminDashboardComprehensive({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminDashboardComprehensive> createState() =>
      _AdminDashboardComprehensiveState();
}

class _AdminDashboardComprehensiveState
    extends ConsumerState<AdminDashboardComprehensive>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  AdminRole _currentRole = AdminRole.superAdmin;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Role Indicator
            _buildRoleIndicator(),
            // Main Content
            _buildMainContent(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('لوحة التحكم الإدارية'),
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.notifications_outlined),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'مسؤول النظام',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getRoleLabel(_currentRole),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.dashboard,
            title: 'لوحة التحكم',
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 0);
            },
          ),
          _buildDrawerItem(
            icon: Icons.people,
            title: 'إدارة المستخدمين',
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 1);
            },
          ),
          _buildDrawerItem(
            icon: Icons.directions_car,
            title: 'إدارة السائقين',
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 2);
            },
          ),
          _buildDrawerItem(
            icon: Icons.attach_money,
            title: 'الإدارة المالية',
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 3);
            },
          ),
          _buildDrawerItem(
            icon: Icons.support_agent,
            title: 'خدمة العملاء',
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 4);
            },
          ),
          _buildDrawerItem(
            icon: Icons.local_offer,
            title: 'إدارة العروض',
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 5);
            },
          ),
          _buildDrawerItem(
            icon: Icons.settings,
            title: 'الإعدادات',
            onTap: () {
              Navigator.pop(context);
              setState(() => _selectedIndex = 6);
            },
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.logout,
            title: 'تسجيل الخروج',
            onTap: () {},
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? AppColors.error : AppColors.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? AppColors.error : AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildRoleIndicator() {
    return Container(
      margin: const EdgeInsets.all(AppDimensions.paddingMedium),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'الدور الحالي',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _getRoleLabel(_currentRole),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _getRolePermissionLevel(_currentRole),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardOverview();
      case 1:
        return _buildUserManagement();
      case 2:
        return _buildDriverManagement();
      case 3:
        return _buildFinanceManagement();
      case 4:
        return _buildCustomerSupport();
      case 5:
        return _buildOffersManagement();
      case 6:
        return _buildSettings();
      default:
        return _buildDashboardOverview();
    }
  }

  Widget _buildDashboardOverview() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'نظرة عامة على النظام',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          // KPI Cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildKPICard(
                title: 'إجمالي الرحلات',
                value: '5,234',
                icon: Icons.directions_car,
                color: const Color(0xFF6366F1),
              ),
              _buildKPICard(
                title: 'الإيرادات اليومية',
                value: '45,230 ر.س',
                icon: Icons.trending_up,
                color: const Color(0xFF10B981),
              ),
              _buildKPICard(
                title: 'المستخدمين النشطين',
                value: '1,245',
                icon: Icons.people,
                color: const Color(0xFFEC4899),
              ),
              _buildKPICard(
                title: 'معدل الرضا',
                value: '4.8/5',
                icon: Icons.star,
                color: const Color(0xFFF59E0B),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Live Trips
          const Text(
            'الرحلات الحية',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildLiveTripsCard(),
          const SizedBox(height: 24),
          // System Health
          const Text(
            'صحة النظام',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildSystemHealthCard(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildUserManagement() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'إدارة المستخدمين',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildUserStats(),
          const SizedBox(height: 24),
          const Text(
            'المستخدمين الجدد',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildUsersList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDriverManagement() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'إدارة السائقين',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildDriverStats(),
          const SizedBox(height: 24),
          const Text(
            'طلبات التحقق المعلقة',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildPendingDriversList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFinanceManagement() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الإدارة المالية',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildFinancialOverview(),
          const SizedBox(height: 24),
          const Text(
            'طلبات السحب المعلقة',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildWithdrawalRequests(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCustomerSupport() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'خدمة العملاء',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildSupportStats(),
          const SizedBox(height: 24),
          const Text(
            'التذاكر المعلقة',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildTicketsList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOffersManagement() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'إدارة العروض والتخفيفات',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildOffersOverview(),
          const SizedBox(height: 24),
          const Text(
            'العروض النشطة',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildActiveOffers(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الإعدادات',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingsSection(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildKPICard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveTripsCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'الرحلات الجارية حالياً',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTripStat('قيد الانتظار', '45'),
              _buildTripStat('قيد التنفيذ', '128'),
              _buildTripStat('مكتملة', '892'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTripStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSystemHealthCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHealthItem('الخادم الرئيسي', 'نشط', const Color(0xFF10B981)),
          _buildHealthItem('قاعدة البيانات', 'نشطة', const Color(0xFF10B981)),
          _buildHealthItem('خدمة الدفع', 'نشطة', const Color(0xFF10B981)),
          _buildHealthItem('الخرائط', 'نشطة', const Color(0xFF10B981)),
        ],
      ),
    );
  }

  Widget _buildHealthItem(String name, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSmall,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStats() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn('التجار', '2,345'),
          _buildStatColumn('السائقين', '3,456'),
          _buildStatColumn('المسؤولين', '12'),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildUsersList() {
    final users = [
      {'name': 'أحمد محمد', 'role': 'تاجر', 'date': 'اليوم'},
      {'name': 'فاطمة علي', 'role': 'سائق', 'date': 'أمس'},
      {'name': 'محمود حسن', 'role': 'تاجر', 'date': '2 يناير'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: users.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.borderColor,
          height: 1,
          indent: AppDimensions.paddingMedium,
          endIndent: AppDimensions.paddingMedium,
        ),
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user['role'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  user['date'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDriverStats() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn('الموثقين', '2,345'),
          _buildStatColumn('قيد المراجعة', '45'),
          _buildStatColumn('مرفوضين', '12'),
        ],
      ),
    );
  }

  Widget _buildPendingDriversList() {
    final drivers = [
      {
        'name': 'علي محمود',
        'status': 'قيد المراجعة',
        'documents': '3/4',
      },
      {
        'name': 'سارة أحمد',
        'status': 'تحتاج توضيح',
        'documents': '2/4',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: drivers.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.borderColor,
          height: 1,
        ),
        itemBuilder: (context, index) {
          final driver = drivers[index];
          return Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'المستندات: ${driver['documents']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingMedium,
                      vertical: AppDimensions.paddingSmall,
                    ),
                  ),
                  child: const Text(
                    'مراجعة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFinancialOverview() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          _buildFinanceRow('الإيرادات اليومية', '45,230 ر.س', const Color(0xFF10B981)),
          _buildFinanceRow('المدفوعات المعلقة', '12,450 ر.س', const Color(0xFFF59E0B)),
          _buildFinanceRow('العمولات المجمعة', '8,920 ر.س', const Color(0xFF6366F1)),
        ],
      ),
    );
  }

  Widget _buildFinanceRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWithdrawalRequests() {
    final requests = [
      {'name': 'محمد علي', 'amount': '500 ر.س', 'date': 'اليوم'},
      {'name': 'فاطمة حسن', 'amount': '1,200 ر.س', 'date': 'أمس'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: requests.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.borderColor,
          height: 1,
        ),
        itemBuilder: (context, index) {
          final request = requests[index];
          return Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request['name'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        request['amount'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingSmall,
                      vertical: 4,
                    ),
                  ),
                  child: const Text(
                    'موافقة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSupportStats() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn('التذاكر المعلقة', '23'),
          _buildStatColumn('المحلولة', '156'),
          _buildStatColumn('متوسط الوقت', '2.5 ساعة'),
        ],
      ),
    );
  }

  Widget _buildTicketsList() {
    final tickets = [
      {'title': 'مشكلة في الدفع', 'priority': 'عالية', 'time': 'منذ ساعة'},
      {'title': 'سائق لم يصل', 'priority': 'عالية', 'time': 'منذ 30 دقيقة'},
      {'title': 'استفسار عام', 'priority': 'منخفضة', 'time': 'منذ ساعتين'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: tickets.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.borderColor,
          height: 1,
        ),
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          final priorityColor = ticket['priority'] == 'عالية'
              ? AppColors.error
              : const Color(0xFFF59E0B);

          return Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 50,
                  decoration: BoxDecoration(
                    color: priorityColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket['title'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ticket['time'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingSmall,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ticket['priority'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: priorityColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOffersOverview() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn('العروض النشطة', '5'),
          _buildStatColumn('الاستخدام', '2,345'),
          _buildStatColumn('التوفير الإجمالي', '45,230 ر.س'),
        ],
      ),
    );
  }

  Widget _buildActiveOffers() {
    final offers = [
      {
        'title': 'رحلة مجانية بعد 3 رحلات',
        'description': 'للسائقين والتجار',
        'active': true,
      },
      {
        'title': 'خصم 20% على الرحلات الليلية',
        'description': 'من 10 مساءً إلى 6 صباحاً',
        'active': true,
      },
      {
        'title': 'عمولة مخفضة للسائقين الجدد',
        'description': 'أول 10 رحلات',
        'active': false,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: offers.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.borderColor,
          height: 1,
        ),
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer['title'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offer['description'] as String,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingSmall,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (offer['active'] as bool)
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    (offer['active'] as bool) ? 'نشط' : 'معطل',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: (offer['active'] as bool)
                          ? AppColors.success
                          : AppColors.error,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildSettingItem(
            'العمولة الافتراضية',
            '15%',
            onTap: () {},
          ),
          _buildSettingItem(
            'الحد الأدنى للرحلة',
            '10 ر.س',
            onTap: () {},
          ),
          _buildSettingItem(
            'وقت انتظار السائق',
            '5 دقائق',
            onTap: () {},
          ),
          _buildSettingItem(
            'المناطق المتاحة',
            'تحديث',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          onTap: onTap,
        ),
        Divider(
          color: AppColors.borderColor,
          height: 1,
          indent: AppDimensions.paddingMedium,
          endIndent: AppDimensions.paddingMedium,
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      backgroundColor: Colors.white,
      elevation: 10,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: 'لوحة التحكم',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          activeIcon: Icon(Icons.people),
          label: 'المستخدمين',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car_outlined),
          activeIcon: Icon(Icons.directions_car),
          label: 'السائقين',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money_outlined),
          activeIcon: Icon(Icons.attach_money),
          label: 'المالية',
        ),
      ],
    );
  }

  String _getRoleLabel(AdminRole role) {
    switch (role) {
      case AdminRole.superAdmin:
        return 'مسؤول النظام الأساسي';
      case AdminRole.operationsManager:
        return 'مدير العمليات';
      case AdminRole.driverVerificationOfficer:
        return 'مسؤول التحقق من السائقين';
      case AdminRole.financeManager:
        return 'مدير مالي';
      case AdminRole.supportAgent:
        return 'وكيل خدمة العملاء';
    }
  }

  String _getRolePermissionLevel(AdminRole role) {
    switch (role) {
      case AdminRole.superAdmin:
        return 'صلاحيات كاملة';
      case AdminRole.operationsManager:
        return 'صلاحيات عالية';
      case AdminRole.driverVerificationOfficer:
        return 'صلاحيات محدودة';
      case AdminRole.financeManager:
        return 'صلاحيات مالية';
      case AdminRole.supportAgent:
        return 'صلاحيات دعم';
    }
  }
}
