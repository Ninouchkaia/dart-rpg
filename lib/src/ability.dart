class Ability {
  final int id;
  String name;
  String description;
  SpellType Type;// Type as a spell type
  int manaRequired;
  int damage; //Health points to remove when it hits an enemy.

  Ability(this.id, this.name, this.description, this.Type, this.manaRequired, this.damage);
}

enum SpellType {Physical, Magical, Neutral}