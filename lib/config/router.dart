import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/merchant/merchant_home_screen.dart';
import '../screens/driver/driver_home_screen.dart';
import '../screens/admin/admin_dashboard_screen.dart';

final routerProvider = Provider((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authState.whenData((user) => user != null).value ?? false;
      final isLoading = authState.isLoading;

      if (isLoading) {
        return '/splash';
      }

      if (!isAuthenticated) {
        if (state.matchedLocation == '/register') {
          return '/register';
        }
        return '/login';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/merchant-home',
        name: 'merchant-home',
        builder: (context, state) => const MerchantHomeScreen(),
      ),
      GoRoute(
        path: '/driver-home',
        name: 'driver-home',
        builder: (context, state) => const DriverHomeScreen(),
      ),
      GoRoute(
        path: '/admin-dashboard',
        name: 'admin-dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
    ],
  );
});
