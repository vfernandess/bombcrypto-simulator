
class Hero {

  final int power;
  final int speed;
  final int stamina;
  final int bombs;
  final int bombRange;

  final bool hasEnergyRegenSkill;
  final bool hasManaSkill;

  Hero(this.power, this.speed, this.stamina, this.bombs, this.bombRange, this.hasEnergyRegenSkill, this.hasManaSkill);

}

enum HeroType {
  legend, rare, superRare, common
}