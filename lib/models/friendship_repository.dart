import 'package:supabase_flutter/supabase_flutter.dart';
import 'friendship.dart';
import 'profile.dart';

class FriendshipRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> sendFriendRequest({
    required String requesterId,
    required String addresseeId,
  }) async {
    try {
      if (requesterId == addresseeId) {
        throw Exception('Você não pode adicioanr a si mesmo.');
      }
      await _supabase.from('friendships').insert({
        'requester_id': requesterId,
        'addressee_id': addresseeId,
        'status': 'pendente',
      });
    } catch (e) {
      print('Erro ao enviar pedido de amizade: $e');
      throw Exception('Não foi possível enviar o pedido de amizade.');
    }
  }

  Future<void> updateFriendshipStatus(String friendshipId, String newStatus) async {
    try {
      await _supabase.from('friendships').update({'status': newStatus}).eq('id', friendshipId);
    } catch (e) {
      print('Erro ao atualizar status de amizade: $e');
      throw Exception('Não foi possível atualizar a amizade.');
    }
  }

  Future<void> removeFriendship(String friendshipId) async {
    try {
      await _supabase.from('friendships').delete().eq('id', friendshipId);
    } catch (e) {
      print('Erro ao remover amizade: $e');
      throw Exception('Não foi possível remover a amizade.');
    }
  }

  Future<List<(Friendship, Profile)>> getFriends(String userId) async {
    try {
      final response = await _supabase.rpc('get_friends_for_user', params: {'user_id_input': userId});
      return (response as List).map((json) {
        final friendship = Friendship.fromJson(json['friendship_data']);
        final profile = Profile.fromJson(json['friend_profile']);
        return (friendship, profile);
      }).toList();
    } catch (e) {
      print('Erro ao buscar amigos: $e');
      throw Exception('Não foi possível buscar a lista de amigos.');
    }
  }

  Future<List<(Friendship, Profile)>> getPendingRequests(String userId) async {
    try {
      final response = await _supabase.from('friendships').select('*, requester:requester_id(*)').eq('addressee_id', userId).eq('status', 'pendente');
      return (response as List).map((json) {
        final friendship = Friendship.fromJson(json);
        final profile = Profile.fromJson(json['requester']);
        return (friendship, profile);
      }).toList();
    } catch (e) {
      print('Erro ao buscar pedidos pendentes: $e');
      throw Exception('Não foi possível buscar os pedidos de amizade.');
    }
  }
}
