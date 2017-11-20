import 'dart:async';
import 'dart:html';
import 'dart:collection';


import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'hero.dart';
import 'hero_service.dart';
import 'monster.dart';
import 'monster_service.dart';
import 'ability.dart';
import 'ability_service.dart';


@Component(
  selector: 'my-dashboard',
  templateUrl: 'dashboard_component.html',
  styleUrls: const ['dashboard_component.css'],
  directives: const [CORE_DIRECTIVES, ROUTER_DIRECTIVES],
)

class DashboardComponent implements OnInit {
  List<Hero> heroes;
  List<Monster> monsters;
  List<Ability> abilities;
  List<Ability> myHeroAbilities; // va contenir et permettre d'afficher les abilities du seletedHero.

  var monsterMap = new Map<String, int>();
  var heroManaMap = new Map<String, int>();
  var heroXpMap = new Map<String, int>();
  var heroLevelMap = new Map<String, int>();

  final HeroService _heroService;
  final MonsterService _monsterService;
  final AbilityService _abilityService;

  Hero myHeroSelected;
  Monster myMonsterSelected;
  Ability myAbilitySelected;
  bool heroSelectedBool = false;
  bool monsterSelectedBool = false;
  bool abilitySelectedBool = false;
  bool fightBool = false;
  HtmlElement selectedElement = null ;

  DashboardComponent(this._heroService, this._monsterService, this._abilityService);


  Future<Null> ngOnInit() async {
    heroes = (await _heroService.getHeroes()).skip(1).take(4).toList();
    monsters = (await _monsterService.getMonsters()).toList();
    abilities = (await _abilityService.getAbilities());

    // initialisation des maps monstres et héros
    for(var monster in monsters) {
      monsterMap[monster.name] = monster.health;
    }

    for(var hero in heroes) {
      heroManaMap[hero.name] = hero.mana;
      heroXpMap[hero.name] = hero.gainedExperience;
      heroLevelMap[hero.name] = hero.level;
    }
  }

  void selectMyHero(Hero myHero, MouseEvent event) {

    //if (this.selectedElement != null) {
      //if ((this.selectedElement).querySelector(".hero").style.background == "#607D8B") {
        //(this.selectedElement).querySelector(".hero").style.background = "pink";
      //} else {
        //(this.selectedElement).querySelector(".hero").className = "module hero";
      //}
    //}

    //(event.target as HtmlElement)

    print(myHero.name);
    this.myHeroSelected = myHero;
    this.heroSelectedBool = true;

    this.selectedElement = (event.target as HtmlElement);
    //this.selectedElement.classes.add("has-error");

  }


  void getMyHeroAbilities(Hero myHero) {
    //print(myHero.abilities.runtimeType);
    myHeroAbilities = myHero.abilities;
    //print(myHeroAbilities);
  }

  void selectMyHeroAbility(Ability myAbility) {

    for (var ability in abilities) {
      if (myAbility == ability.name) {

        if(ability.manaRequired > myHeroSelected.mana) {
          window.alert('Your hero doesnt have enough mana, choose another ability !');
        }
        print("ability chosen = ");
        print(ability.description);
        this.myAbilitySelected = ability;
        this.abilitySelectedBool = true;
      }
    }
  }

  void selectMyMonster(Monster myMonster) {
    this.myMonsterSelected = myMonster;
    this.monsterSelectedBool = true;
  }

  void initFight(Hero myHeroSelected, Monster myMonsterSelected, Ability myAbilitySelected) {
    this.fightBool = true;
    myHeroSelected = this.myHeroSelected;
    myMonsterSelected = this.myMonsterSelected;
    myAbilitySelected = this.myAbilitySelected;

    if (myMonsterSelected == null) {
      return;
    }

    // enlever les PV au monstre
    monsterMap[myMonsterSelected.name] = (monsterMap[myMonsterSelected.name] - myAbilitySelected.damage);

    // gerer la mort du monstre et le gain d'XP
    if (monsterMap[myMonsterSelected.name] <= 0) {
      window.alert("Your hero " + myHeroSelected.name + " has defeated Monster " + myMonsterSelected.name + "!!" + myHeroSelected.name + " earns " + myMonsterSelected.experienceGivenWhenDefeated.toString() + " XP ! \n Choose another monster !");
      heroXpMap[myHeroSelected.name] = heroXpMap[myHeroSelected.name] + myMonsterSelected.experienceGivenWhenDefeated;
      this.myMonsterSelected = null;

      //gestion du level up
      if (heroXpMap[myHeroSelected.name] >= 100) {
        window.alert("LEVEL UPPPP !!!! ");
        heroLevelMap[myHeroSelected.name] = heroLevelMap[myHeroSelected.name] + 1;
        heroXpMap[myHeroSelected.name] = 0;
      }

      // gestion level Max
      if (heroLevelMap[myHeroSelected.name] >= 3) {
        window.alert("Your hero " + myHeroSelected.name + "has reached MAX level (5) !!! Congrats !!");
      }

      if (monsterMap.length==0) {
        window.alert("You killed all Monsters, CONGRATULATIONS !!!");
        this.myMonsterSelected = null;
      }

      monsterMap.remove(myMonsterSelected);
      monsters.remove(myMonsterSelected);
      heroManaMap[myHeroSelected.name] = myHeroSelected.mana;
    }
    else {
      window.alert("You have taken the monster " + myMonsterSelected.name + " " + myAbilitySelected.damage.toString() + " health points." + " It still has " + monsterMap[myMonsterSelected.name].toString() + " of life.");

      //gestion du level up
      if (heroXpMap[myHeroSelected.name] >= 100) {
        window.alert("LEVEL UPPPP !!!! ");
        heroLevelMap[myHeroSelected.name] = heroLevelMap[myHeroSelected.name] + 1;
        heroXpMap[myHeroSelected.name] = 0;


      }

      // gestion level Max
      if (heroLevelMap[myHeroSelected.name] >= 3) {
        window.alert("Your hero " + myHeroSelected.name + "has reached MAX level (5) !!! Congrats !!");
      }

      if (monsterMap.length==0) {
        window.alert("You killed all Monsters, CONGRATULATIONS !!!");
        this.myMonsterSelected = null;
      }
    }
    // Retirer la mana au héros
    heroManaMap[myHeroSelected.name] = heroManaMap[myHeroSelected.name] - myAbilitySelected.manaRequired;
    //window.alert("Your hero " + myHeroSelected.name + " has used " + myAbilitySelected.manaRequired.toString() + " mana points." + " He/she still has " + heroManaMap[myHeroSelected.name].toString() + " of mana.");
  }

  void toggleColorHero(Hero hero) {
    var mySelectedDivHero = document.getElementById('selectedElementHero' + hero.name);
    if (mySelectedDivHero.style.background == "pink") {
      mySelectedDivHero.style.background = "#607D8B";
    } else {
      mySelectedDivHero.style.background = "pink";
    }
  }

    void toggleColorAbility(Ability ability) {
      var mySelectedDivAbility = document.getElementById('selectedElementAbility' + ability.name);
      if (mySelectedDivAbility.style.background == "cyan") {
        mySelectedDivAbility.style.background = "#607D8B";
      } else {
        mySelectedDivAbility.style.background = "cyan";
      }
    }

  void toggleColorMonster(Monster monster) {
    var mySelectedDivMonster = document.getElementById('selectedElementMonster' + monster.name);
    if (mySelectedDivMonster.style.background == "green") {
      mySelectedDivMonster.style.background = "#607D8B";
    } else {
      mySelectedDivMonster.style.background = "green";
    }
  }

}
