
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

class HeroType {
  final String icon;
  final String name;

  const HeroType._(this.icon, this.name);

  static const legend = HeroType._("assets/images/char1.png", "Legend");
  static const rare = HeroType._("assets/images/speed.png", "Rare");
  static const superRare = HeroType._("assets/images/stamina.png", "Super rare");
  static const common = HeroType._("assets/images/bomb_count.png", "Common");
  static const uncommon = HeroType._("assets/images/bomb_range.png", "Uncommon");
}