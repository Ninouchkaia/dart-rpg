import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'ability.dart';
import 'ability_service.dart';

@Component(
  selector: 'my-abilities',
  templateUrl: 'abilities_component.html',
  styleUrls: const ['abilities_component.css'],
  directives: const [CORE_DIRECTIVES],
  pipes: const [COMMON_PIPES],
)
class AbilitiesComponent implements OnInit {
  final AbilityService _abilityService;
  final Router _router;
  List<Ability> abilities;
  Ability selectedAbility;

  AbilitiesComponent(this._abilityService, this._router);

  Future<Null> getAbilities() async {
    abilities = await _abilityService.getAbilities();
  }

  void ngOnInit() => getAbilities();

  void onSelect(Ability ability) => selectedAbility = ability;

  Future<Null> gotoDetail() => _router.navigate([
    'AbilityDetail',
    {'id': selectedAbility.id.toString()}
  ]);
}
