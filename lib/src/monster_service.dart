import 'dart:async';

import 'package:angular/angular.dart';

import 'monster.dart';
import 'mock_monsters.dart';

@Injectable()
class MonsterService {
  Future<List<Monster>> getMonsters() async => mockMonsters;

  Future<Monster> getMonster(int id) async =>
      (await getMonsters()).firstWhere((monster) => monster.id == id);
}
