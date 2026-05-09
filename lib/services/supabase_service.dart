import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';
import '../config/constants.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  late SupabaseClient _client;
  final Logger _logger = Logger();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  SupabaseClient get client => _client;

  Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: AppConstants.supabaseUrl,
        anonKey: AppConstants.supabaseAnonKey,
      );
      _client = Supabase.instance.client;
      _logger.i('✅ تم تهيئة Supabase بنجاح');
    } catch (e) {
      _logger.e('❌ خطأ في تهيئة Supabase: $e');
      rethrow;
    }
  }

  // ============================================
  // Generic CRUD Operations (Fixes Provider Mismatches)
  // ============================================

  Future<List<Map<String, dynamic>>> query(String table, {Map<String, dynamic>? filters}) async {
    try {
      var query = _client.from(table).select();
      if (filters != null) {
        filters.forEach((key, value) {
          query = query.eq(key, value);
        });
      }
      final response = await query;
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      _logger.e('❌ خطأ في الاستعلام من جدول $table: $e');
      return [];
    }
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    try {
      await _client.from(table).insert(data);
      _logger.i('✅ تم الإدخال في جدول $table');
    } catch (e) {
      _logger.e('❌ خطأ في الإدخال في جدول $table: $e');
      rethrow;
    }
  }

  Future<void> update(String table, Map<String, dynamic> data, String id) async {
    try {
      await _client.from(table).update(data).eq('id', id);
      _logger.i('✅ تم التحديث في جدول $table');
    } catch (e) {
      // Try 'uid' if 'id' fails (fallback for schema inconsistencies)
      try {
        await _client.from(table).update(data).eq('uid', id);
        _logger.i('✅ تم التحديث في جدول $table باستخدام uid');
      } catch (e2) {
        _logger.e('❌ خطأ في التحديث في جدول $table: $e2');
        rethrow;
      }
    }
  }

  // ============================================
  // المصادقة (Authentication)
  // ============================================

  Future<AuthResponse> signUpWithPhone(String phone, String password) async {
    try {
      final response = await _client.auth.signUp(
        email: '$phone@rihlaty.local',
        password: password,
      );
      _logger.i('✅ تم التسجيل: ${response.user?.id}');
      return response;
    } catch (e) {
      _logger.e('❌ خطأ في التسجيل: $e');
      rethrow;
    }
  }

  Future<AuthResponse> signInWithPhone(String phone, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: '$phone@rihlaty.local',
        password: password,
      );
      _logger.i('✅ تم تسجيل الدخول: ${response.user?.id}');
      return response;
    } catch (e) {
      _logger.e('❌ خطأ في تسجيل الدخول: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
      _logger.i('✅ تم تسجيل الخروج');
    } catch (e) {
      _logger.e('❌ خطأ في تسجيل الخروج: $e');
      rethrow;
    }
  }

  User? getCurrentUser() {
    return _client.auth.currentUser;
  }

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  // Existing specific methods can remain for backward compatibility if needed, 
  // but generic ones now support the providers.
}
