class Aura {
  String name;
  String description;

  Aura({
    required this.name,
    required this.description,
  });

  factory Aura.fromMap(Map<String, dynamic> map) {
    return Aura(
      name: map['name'],
      description: map['description'],
    );
  }
}