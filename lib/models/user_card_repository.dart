import 'package:supabase_flutter/supabase_flutter.dart';
import 'user_card.dart';
import 'card.dart';

class UserCardRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<(UserCard, Card)>> fetchUserInventory(String userId) async {
    try {
      final response = await _supabase.from('user_cards').select('*, cards(*, collections(name))').eq('user_id', userId).order('created_at', ascending: false);
      return response.map((json) {
        final userCard = UserCard.fromJson(json);
        final card = Card.fromJson(json['cards']);
        return (userCard, card);
      }).toList();
    } catch (e) {
      print('Erro ao buscar inventário do usuário: $e');
      throw Exception('Não foi possível buscar o inventário.');
    }
  }

  Future<void> addCardToInventory(String userId, String cardId, {int quantity = 1}) async {
    try {
      final existingEntry = await _supabase.from('user_cards').select('id, quantity').eq('user_id', userId).eq('cardId', cardId).maybeSingle();
      if (existingEntry != null) {
        final int currentQuantity = existingEntry['quantity'] as int;
        await _supabase.from('user_cards').update({'quantity': currentQuantity + quantity}).eq('id', existingEntry['id'] as String);
      } else {
        await _supabase.from('user_cards').insert({'user_id': userId, 'card_id': cardId, 'quantity': quantity});
      }
    } catch (e) {
      print('Erro ao adicionar carta ao inventário: $e');
      throw Exception('Não foi possível adicionar a carta.');
    }
  }

  Future<void> removeCardFromInventory(String userId, String cardId, {int quantity = 1}) async {
    try {
      final existingEntry = await _supabase
          .from('user_cards')
          .select('id, quantity')
          .eq('user_id', userId)
          .eq('card_id', cardId)
          .maybeSingle();

      if (existingEntry == null) {
        print('Tentativa de remover uma carta que o usuário não possui.');
        return; 
      }

      final int currentQuantity = existingEntry['quantity'] as int;

      if (currentQuantity > quantity) {
        await _supabase
            .from('user_cards')
            .update({'quantity': currentQuantity - quantity})
            .eq('id', existingEntry['id'] as String);
      } else {
        await _supabase
            .from('user_cards')
            .delete()
            .eq('id', existingEntry['id'] as String);
      }
    } catch (e) {
      print('Erro ao remover carta do inventário: $e');
      throw Exception('Não foi possível remover a carta.');
    }
  }
}
