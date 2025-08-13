import 'package:supabase_flutter/supabase_flutter.dart';
import 'collections.dart';

class CollectionRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Collection>> fetchAllCollections() async {
    try {
      final List<Map<String, dynamic>> response = await _supabase.from('collections').select().order('release_date', ascending: false);
      return response.map((json) => Collection.fromJson(json)).toList();
    } catch (e) {
      print('Erro ao buscar coleções: $e');
      throw Exception('Não foi possível buscar as coleções.');
    }
  }

    Future<void> createCollection(Collection collection) async {
    try {
      await _supabase.from('collections').insert(collection.toJson());
    } catch (e) {
      print('Erro ao criar coleção: $e');
      throw Exception('Não foi possível criar a coleção.');
    }
  }

  Future<void> updateCollection(Collection collection) async {
    try {
      await _supabase.from('collections').update(collection.toJson()).eq('id', collection.id);
    } catch (e) {
      print('Erro ao atualizar coleção: $e');
      throw Exception('Não foi possível atualizar a coleção.');
    }
  }

  Future<void> deleteCollection(String id) async {
    try {
      await _supabase.from('collections').delete().eq('id', id);
    } catch (e) {
      print('Erro ao deletar coleção: $e');
      throw Exception('Não foi possível deletar a coleção.');
    }
  }
}
