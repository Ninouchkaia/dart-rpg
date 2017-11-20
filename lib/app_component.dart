import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'src/dashboard_component.dart';
import 'src/hero_detail_component.dart';
import 'src/hero_service.dart';
import 'src/heroes_component.dart';

import 'src/monster_detail_component.dart';
import 'src/monster_service.dart';
import 'src/monsters_component.dart';

import 'src/ability_detail_component.dart';
import 'src/ability_service.dart';
import 'src/abilities_component.dart';


@Component(
  selector: 'my-app',
  template: '''
    <h1>{{title}}</h1>
    <nav>
      <a [routerLink]="['Dashboard']">Dashboard</a>
      <a [routerLink]="['Heroes']">Heroes</a>
      <a [routerLink]="['Monsters']">Monsters</a>
      <a [routerLink]="['Abilities']">Abilities</a>
    </nav>
    <router-outlet></router-outlet>
  ''',
  styleUrls: const ['app_component.css'],
  directives: const [ROUTER_DIRECTIVES],
  providers: const [HeroService, MonsterService, AbilityService],
)
@RouteConfig(const [
  const Redirect(path: '/', redirectTo: const ['Dashboard']),
  const Route(
    path: '/dashboard',
    name: 'Dashboard',
    component: DashboardComponent,
  ),
  const Route(
    path: '/detailHero/:id',
    name: 'HeroDetail',
    component: HeroDetailComponent,
  ),
  const Route(
    path: '/detailAbility/:id',
    name: 'AbilityDetail',
    component: AbilityDetailComponent,
  ),
  const Route(
    path: '/detailMonster/:id',
    name: 'MonsterDetail',
    component: MonsterDetailComponent,
  ),
  const Route(path: '/heroes', name: 'Heroes', component: HeroesComponent),
  const Route(path: '/abilities', name: 'Abilities', component: AbilitiesComponent),
  const Route(path: '/monsters', name: 'Monsters', component: MonstersComponent)
])
class AppComponent {
  final title = 'Tour of Heroes and Monsters';
}
