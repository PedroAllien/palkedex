class Skill {
  int level;
  String name;
  String type;
  int cooldown;
  int power;
  String description;

  Skill({
    required this.level,
    required this.name,
    required this.type,
    required this.cooldown,
    required this.power,
    required this.description,
  });

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      level: map['level'],
      name: map['name'],
      type: map['type'],
      cooldown: map['cooldown'],
      power: map['power'],
      description: map['description'],
    );
  }
}