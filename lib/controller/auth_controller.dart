import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile.dart';
import '../models/profile_repository.dart';

class AuthController with ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  final ProfileRepository _profileRepo = ProfileRepository();

  User? get currentUser => _supabase.auth.currentUser;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
  
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await _supabase.auth.signUp(email: email, password: password);
      if (response.user != null) {
        final newProfile = Profile(
          id: response.user!.id,
          username: username,
          coins: 100,
        );
        await _profileRepo.createProfile(newProfile);
      }
    } catch (e) {
      throw Exception('Erro no registro: $e');
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      throw Exception('Erro no login: $e');
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      print('Erro ao enviar e-mail de redefinição: $e');
      throw Exception('Não foi possível enviar o e-mail de redefinição.');
    }
  }
}
