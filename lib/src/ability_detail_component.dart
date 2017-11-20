import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'ability.dart';
import 'ability_service.dart';

@Component(
  selector: 'ability-detail',
  templateUrl: 'ability_detail_component.html',
  styleUrls: const ['ability_detail_component.css'],
  directives: const [CORE_DIRECTIVES, formDirectives],
)
class AbilityDetailComponent implements OnInit {
  Ability ability;
  final AbilityService _abilityService;
  final RouteParams _routeParams;
  final Location _location;

  AbilityDetailComponent(this._abilityService, this._routeParams, this._location);

  Future<Null> ngOnInit() async {
    var _id = _routeParams.get('id');
    var id = int.parse(_id ?? '', onError: (_) => null);
    if (id != null) ability = await (_abilityService.getAbility(id));
  }

  void goBack() => _location.back();
}
