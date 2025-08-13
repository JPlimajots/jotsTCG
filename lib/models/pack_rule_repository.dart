import 'package:supabase_flutter/supabase_flutter.dart';
import 'pack_rule.dart';

class PackRuleRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<PackRule>> fetchRulesForPacks(String packId) async {
    try {
      final response = await _supabase.from('pack_rules').select().eq('pack_id', packId);
      if (response.isEmpty) {
        throw Exception('Nenhuma regra encontrada para este pacote.');
      }
      return response.map((json) => PackRule.fromJson(json)).toList();
    } catch (e) {
      print('Erro ao buscar regras do pacote: $e');
      throw Exception('Não foi possível buscar as regras do pacote.');
    }
  }
}
