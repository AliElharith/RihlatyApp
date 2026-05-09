import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/supabase_service.dart';

final supabaseServiceProvider = Provider((ref) => SupabaseService());

final authStateProvider = StreamProvider((ref) {
  final supabase = ref.watch(supabaseServiceProvider);
  return supabase.authStateChanges;
});

final currentUserProvider = FutureProvider<User?>((ref) async {
  final supabase = ref.watch(supabaseServiceProvider);
  final user = supabase.getCurrentUser();
  
  if (user == null) return null;
  
  try {
    final userData = await supabase.query(
      'users',
      filters: {'id': user.id},
    );
    
    if (userData.isEmpty) {
      // Try 'uid' fallback
      final userDataFallback = await supabase.query(
        'users',
        filters: {'uid': user.id},
      );
      if (userDataFallback.isEmpty) return null;
      return User.fromJson(userDataFallback.first);
    }
    
    return User.fromJson(userData.first);
  } catch (e) {
    return null;
  }
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final SupabaseService _supabase;

  AuthNotifier(this._supabase) : super(const AsyncValue.loading()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final user = _supabase.getCurrentUser();
      if (user != null) {
        final userData = await _supabase.query(
          'users',
          filters: {'id': user.id},
        );
        if (userData.isNotEmpty) {
          state = AsyncValue.data(User.fromJson(userData.first));
        } else {
          state = const AsyncValue.data(null);
        }
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signUp(String phone, String password, UserRole role, String name) async {
    try {
      state = const AsyncValue.loading();
      
      final authResponse = await _supabase.signUpWithPhone(phone, password);
      
      if (authResponse.user != null) {
        final user = User(
          uid: authResponse.user!.id,
          phone: phone,
          role: role,
          name: name,
          createdAt: DateTime.now(),
        );
        
        await _supabase.insert('users', {
          'id': user.uid,
          'phone': user.phone,
          'role': user.role.toString().split('.').last,
          'name': user.name,
          'created_at': user.createdAt.toIso8601String(),
        });
        state = AsyncValue.data(user);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  Future<void> signIn(String phone, String password) async {
    try {
      state = const AsyncValue.loading();
      
      final authResponse = await _supabase.signInWithPhone(phone, password);
      
      if (authResponse.user != null) {
        final userData = await _supabase.query(
          'users',
          filters: {'id': authResponse.user!.id},
        );
        
        if (userData.isNotEmpty) {
          state = AsyncValue.data(User.fromJson(userData.first));
        }
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.signOut();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      rethrow;
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  final supabase = ref.watch(supabaseServiceProvider);
  return AuthNotifier(supabase);
});
