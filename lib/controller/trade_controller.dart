import '../models/card.dart';
import '../models/trade.dart';
import '../models/trade_item.dart';
import '../models/trade_repository.dart';
import '../models/trade_item_repository.dart';
import '../models/user_card_repository.dart';

class TradeController {
  final TradeRepository _tradeRepo;
  final TradeItemRepository _tradeItemRepo;
  final UserCardRepository _userCardRepo;

  TradeController({
    required TradeRepository tradeRepository,
    required TradeItemRepository tradeItemRepository,
    required UserCardRepository userCardRepository,
  })  : _tradeRepo = tradeRepository,
        _tradeItemRepo = tradeItemRepository,
        _userCardRepo = userCardRepository;

  Future<void> createTradeOffer({
    required String offererId,
    required String receiverId,
    required List<String> offeredUserCardId,
    required List<String> requestedUserCardId,
  }) async {
    if (offeredUserCardId.isEmpty || requestedUserCardId.isEmpty) {
      throw Exception('A troca deve conter cartas oferecidas e requisitadas.');
    }
    try {
      final newTrade = Trade(
        id: '',
        offererId: offererId,
        receiverId: receiverId,
        status: 'pendente',
        createdAt: DateTime.now(),
      );
      final createdTrade = await _tradeRepo.createTrade(newTrade);

      final List<TradeItem> items = [];
      for (final userCardId in offeredUserCardId) {
        items.add(TradeItem(id: '', tradeId: createdTrade.id, userCardId: userCardId, type: 'oferecida',));
      }
      for (final userCardId in requestedUserCardId) {
        items.add(TradeItem(id: '', tradeId: createdTrade.id, userCardId: userCardId, type: 'requisitada',));
      }
      await _tradeItemRepo.addItemsToTrade(items);
    } catch (e) {
      print('Erro no controller ao criar troca: $e');
      rethrow;
    }
  }

  Future<void> acceptTrade(Trade trade) async {
    try {
      final List<(TradeItem, Card)> itemsAndCards = await _tradeItemRepo.getItemsForTrade(trade.id);
      final offeredItems = itemsAndCards.where((item) => item.$1.type == 'oferecida');
      final requestedItems = itemsAndCards.where((item) => item.$1.type == 'requisitada');
      
      for (final itemTuple in offeredItems) {
        await _userCardRepo.removeCardFromInventory(trade.offererId, itemTuple.$2.id);
        await _userCardRepo.addCardToInventory(trade.receiverId, itemTuple.$2.id);
      }

      for (final itemTuple in requestedItems) {
        await _userCardRepo.removeCardFromInventory(trade.receiverId, itemTuple.$2.id);
        await _userCardRepo.addCardToInventory(trade.offererId, itemTuple.$2.id);
      }

      await _tradeRepo.updateTradeStatus(trade.id, 'aceita');
    } catch (e) {
      print('Erro no controller ao aceitar troca: $e');
      rethrow;
    }
  }

    Future<void> declineOrCancelTrade(String tradeId, {bool byOfferer = false}) async {
    try {
      final String newStatus = byOfferer ? 'cancelada' : 'recusada';
      await _tradeRepo.updateTradeStatus(tradeId, newStatus);
    } catch (e) {
      print('Erro no controller ao recusar/cancelar troca: $e');
      rethrow;
    }
  }
}
