import 'package:supabase_flutter/supabase_flutter.dart';
import 'trade.dart';
import 'profile.dart';

class TradeRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Trade> createTrade(Trade trade) async {
    try {
      final response = await _supabase.from('trades').insert(trade.toJson()).select().single();
      return Trade.fromJson(response);
    } catch (e) {
      print('Erro ao criar troca: $e');
      throw Exception('Não foi possível criar a oferta de troca.');
    }
  }

  Future<void> updateTradeStatus(String tradeId, String newStatus) async {
    try {
      await _supabase.from('trades').update({'status': newStatus}).eq('id', tradeId);
    } catch (e) {
      print('Erro ao atualizar status da troca: $e');
      throw Exception('Não foi possível atualizar a troca.');
    }
  }

  Future<List<(Trade, Profile)>> getIncomingTrades(String userId) async {
    try {
      final response = await _supabase.from('trades').select('*, offerer:offerer_id(*)').eq('receiver_id', userId).eq('status', 'pendente');
      return (response as List).map((json) {
        final trade = Trade.fromJson(json);
        final profile = Profile.fromJson(json['offerer']);
        return (trade, profile);
      }).toList();  
    } catch (e) {
      print('Erro ao buscar trocas recebidas: $e');
      throw Exception('Não foi possível buscar as trocas recebidas.');
    }
  }

  Future<List<(Trade, Profile)>> getOutgoingTrades(String userId) async {
    try {
      final response = await _supabase.from('trades').select('*, receiver:receiver_id(*)').eq('offerer_id', userId).eq('status', 'pendente');
      return (response as List).map((json) {
        final trade = Trade.fromJson(json);
        final profile = Profile.fromJson(json['receiver']);
        return (trade, profile);
      }).toList();
    } catch (e) {
      print('Erro ao buscar trocas enviadas: $e');
      throw Exception('Não foi possível buscar as trocas enviadas.');
    }
  }
}
