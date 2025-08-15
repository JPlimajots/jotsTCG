import 'dart:math';
import '../models/card.dart';
import '../models/pack.dart';
import '../models/pack_rule.dart';
import '../models/profile.dart';
import '../models/card_repository.dart';
import '../models/pack_repository.dart';
import '../models/pack_rule_repository.dart';
import '../models/profile_repository.dart';
import '../models/user_card_repository.dart';

class PackController {
  final PackRepository _packRepo;
  final PackRuleRepository _ruleRepo;
  final CardRepository _cardRepo;
  final UserCardRepository _userCardRepo;
  final ProfileRepository _profileRepo;

  PackController({
    required PackRepository packRepository,
    required PackRuleRepository packRuleRepository,
    required CardRepository cardRepository,
    required UserCardRepository userCardRepository,
    required ProfileRepository profileRepository,
  })  : _packRepo = packRepository,
        _ruleRepo = packRuleRepository,
        _cardRepo = cardRepository,
        _userCardRepo = userCardRepository,
        _profileRepo = profileRepository;

  Future<List<Card>> openPack(String packId, String userId) async {
    final Pack? pack = await _packRepo.getPackById(packId);
    final Profile? profile = await _profileRepo.getProfile(userId);
    
    if (pack == null) throw Exception("Pacote não encontrado.");
    if (profile == null) throw Exception("Perfil do usuário não encontrado.");
    if (profile.coins < pack.costInCoins) {
      throw Exception("Moedas insuficientes para comprar este pacote.");
    }

    final List<PackRule> rules = await _ruleRepo.fetchRulesForPacks(packId);
    final List<Card> wonCards = [];
    final random = Random();

    for (int i = 0; i < 5; i++) {
      final String sortedRarity = _getRandomRarity(rules, random);
      final List<Card> cardsInRarity = await _cardRepo.fetchCardsByRarity(sortedRarity);
      if (cardsInRarity.isEmpty) {
        final commonCards = await _cardRepo.fetchCardsByRarity('Comum');
        if(commonCards.isNotEmpty) wonCards.add(commonCards[random.nextInt(commonCards.length)]);
      } else {
        wonCards.add(cardsInRarity[random.nextInt(cardsInRarity.length)]);
      }
    }

    final updatedProfile = Profile(
      id: profile.id,
      username: profile.username,
      avatarUrl: profile.avatarUrl,
      coins: profile.coins - pack.costInCoins,
    );
    await _profileRepo.updateProfile(updatedProfile);

    for (final card in wonCards) {
      await _userCardRepo.addCardToInventory(userId, card.id);
    }

    return wonCards;
  }

  String _getRandomRarity(List<PackRule> rules, Random random) {
    double cumulative = 0.0;
    double randomNumber = random.nextDouble();
    for (final rule in rules) {
      cumulative += rule.probability;
      if (randomNumber < cumulative) {
        return rule.rarity;
      }
    }
    return rules.last.rarity;
  }
}
