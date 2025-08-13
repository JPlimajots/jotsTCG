import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile.dart';

class ProfileRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Profile?> getProfile(String userId) async {
    try {
      final response = await _supabase.from('profiles').select().eq('id', userId).single();
      return Profile.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        return null;
      }
      print('Erro ao buscar perfil: $e');
      throw Exception('Não foi possível buscar o perfil.');
    } catch (e) {
      print('Erro inesperado ao buscar perfil: $e');
      throw Exception('Ocorreu um erro inesperado.');
    }
  }

  Future<void> createProfile(Profile profile) async {
    try {
      await _supabase.from('profiles').insert(profile.toJson());
    } catch (e) {
      print('Erro ao criar o perfil: $e');
      throw Exception('Não foi possível criar o perfil.');
    }
  }

  Future<void> updateProfile(Profile profile) async {
    try {
      await _supabase.from('profiles').update(profile.toJson()).eq('id', profile.id);
    } catch (e) {
      print('Erro ao atualizar perfil: $e');
      throw Exception('Não foi possível atualizar o perfil.');
    }
  }
}
