import 'package:supabase_flutter/supabase_flutter.dart';
import 'pack.dart';

class PackRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Pack>> fetchAllPacks() async {
    try {
      final response = await _supabase.from('packs').select().order('cost_in_coins', ascending: true);
      return response.map((json) => Pack.fromJson(json)).toList();
    } catch (e) {
      print('Erro ao buscar pacotes: $e');
      throw Exception('Não foi possível buscar os pacotes.');
    }
  }

  Future<Pack?> getPackById(String id) async {
    try {
      final response = await _supabase.from('packs').select().eq('id', id).single();
      return Pack.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') return null;
      rethrow;
    } catch (e) {
      print('Erro ao buscar pacote por ID: $e');
      throw Exception('Não foi possível buscar o pacote.');
    }
  }

  Future<void> createPack(Pack pack) async {
    try {
      await _supabase.from('packs').insert(pack.toJson());
    } catch (e) {
      print('Erro ao criar pacote: $e');
      throw Exception('Não foi possível criar o pacote.');
    }
  }

  Future<void> updatePack(Pack pack) async {
    try {
      await _supabase.from('packs').update(pack.toJson()).eq('id', pack.id);
    }catch (e) {
      print('Erro ao atualizar pacote: $e');
      throw Exception('Não foi possível atualizar o pacote.');
    }
  }
}
