import '../models/friendship.dart';
import '../models/profile.dart';
import '../models/friendship_repository.dart';

class FriendshipController {
  final FriendshipRepository _friendshipRepo;

  FriendshipController({
    required FriendshipRepository friendshipRepository,
  })  : _friendshipRepo = friendshipRepository;

  Future<List<Profile>> getFriends(String userId) async {
    try {
      final List<(Friendship, Profile)> results = await _friendshipRepo.getFriends(userId);
      return results.map((result) => result.$2).toList();
    } catch (e) {
      print('Erro no controller ao buscar amigos: $e');
      rethrow;
    }
  }

  Future<List<(Friendship, Profile)>> getPendingRequests(String userId) async {
    try {
      return await _friendshipRepo.getPendingRequests(userId);
    } catch (e) {
      print('Erro no controller ao buscar pedidos pendentes: $e');
      rethrow;
    }
  }

  Future<void> sendFriendRequest({
    required String fromUserId,
    required String toUserId,
  }) async {
    try {
      await _friendshipRepo.sendFriendRequest(requesterId: fromUserId, addresseeId: toUserId);
    } catch (e) {
      print('Erro no controller ao enviar pedido: $e');
      rethrow;
    }
  }

  Future<void> acceptFriendRequest(String friendshipId) async {
    try {
      await _friendshipRepo.updateFriendshipStatus(friendshipId, 'aceita');
    } catch (e) {
      print('Erro no controller ao aceitar pedido: $e');
      rethrow;
    }
  }

  Future<void> declineOrRemoveFriend(String friendshipId) async {
    try {
      await _friendshipRepo.removeFriendship(friendshipId);
    } catch (e) {
      print('Erro no controller ao recusar/remover amigo: $e');
      rethrow;
    }
  }
}
