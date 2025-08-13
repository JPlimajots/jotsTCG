import 'package:supabase_flutter/supabase_flutter.dart';
import 'card.dart';

class CardRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Card>> fetchCardsByCollection(String collectionId) async {
    try {
      final response = await _supabase.from('cards').select().eq('collection_id', collectionId).order('name', ascending: true);
      return response.map((json) => Card.fromJson(json)).toList();
    } catch (e) {
      print('Erro ao buscar cartas da coleção: $e');
      throw Exception('Não foi possível buscar as cartas.');
    }
  }

  Future<void> createCard(Card card) async {
    try {
      await _supabase.from('cards').insert(card.toJson());
    } catch (e) {
      print('Erro ao criar carta: $e');
      throw Exception('Não foi possível criar a carta.');
    }
  }

  Future<void> updateCard(Card card) async {
    try {
      await _supabase.from('cards').update(card.toJson()).eq('id', card.id);
    } catch (e) {
      print('Erro ao atualizar carta: $e');
      throw Exception('Não foi possível atualizar a carta.');
    }
  }

  Future<void> deleteCard(String id) async {
    try {
      await _supabase.from('cards').delete().eq('id', id);
    } catch (e) {
      print('Erro ao deletar carta: $e');
      throw Exception('Não foi possível deletar a carta.');
    }
  }
}
