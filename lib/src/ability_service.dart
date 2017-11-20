import 'dart:async';

import 'package:angular/angular.dart';

import 'ability.dart';
import 'mock_abilities.dart';

@Injectable()
class AbilityService {
  Future<List<Ability>> getAbilities() async => mockAbilities;

  Future<Ability> getAbility(int id) async =>
      (await getAbilities()).firstWhere((ability) => ability.id == id);
}
