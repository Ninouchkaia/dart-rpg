import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'monster.dart';
import 'monster_service.dart';

@Component(
  selector: 'my-monsters',
  templateUrl: 'monsters_component.html',
  styleUrls: const ['monsters_component.css'],
  directives: const [CORE_DIRECTIVES],
  pipes: const [COMMON_PIPES],
)
class MonstersComponent implements OnInit {
  final MonsterService _monsterService;
  final Router _router;
  List<Monster> monsters;
  Monster selectedMonster;

  MonstersComponent(this._monsterService, this._router);

  Future<Null> getMonsters() async {
    monsters = await _monsterService.getMonsters();
  }

  void ngOnInit() => getMonsters();

  void onSelect(Monster monster) => selectedMonster = monster;

  Future<Null> gotoDetail() => _router.navigate([
    'MonsterDetail',
    {'id': selectedMonster.id.toString()}
  ]);
}
