import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'monster.dart';
import 'monster_service.dart';

@Component(
  selector: 'monster-detail',
  templateUrl: 'monster_detail_component.html',
  styleUrls: const ['monster_detail_component.css'],
  directives: const [CORE_DIRECTIVES, formDirectives],
)
class MonsterDetailComponent implements OnInit {
  Monster monster;
  final MonsterService _monsterService;
  final RouteParams _routeParams;
  final Location _location;

  MonsterDetailComponent(this._monsterService, this._routeParams, this._location);

  Future<Null> ngOnInit() async {
    var _id = _routeParams.get('id');
    var id = int.parse(_id ?? '', onError: (_) => null);
    if (id != null) monster = await (_monsterService.getMonster(id));
  }

  void goBack() => _location.back();
}
