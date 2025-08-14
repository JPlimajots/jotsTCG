import 'package:supabase_flutter/supabase_flutter.dart';
import 'trade_item.dart';
import 'card.dart';

class TradeItemRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> addItemsToTrade(List<TradeItem> items) async {
    try {
      final itemsJson = items.map((item) => item.toJson()).toList();
      await _supabase.from('trade_items').insert(itemsJson);
    } catch (e) {
      print('Erro ao adicionar itens à troca: $e');
      throw Exception('Não foi possível adicionar os itens à troca.');
    }
  }

  Future<List<(TradeItem, Card)>> getItemsForTrade(String tradeId) async {
    try {
      final response = await _supabase.from('trade_items').select('*, user_cards(*, cards(*, collections(name)))').eq('trade_id', tradeId);
      return (response as List).map((json) {
        final tradeItem = TradeItem.fromJson(json);
        final card = Card.fromJson(json['user_cards']['cards']);
        return (tradeItem, card);
      }).toList();
    } catch (e) {
      print('Erro ao buscar itens de troca: $e');
      throw Exception('Não foi possível buscar os itens da troca.');
    }
  }
}
