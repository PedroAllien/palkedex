import 'package:palkedex/app/data/models/aura_model.dart';
import 'package:palkedex/app/data/models/skill_model.dart';

class PalModel {
  int id;
  String key;
  String image;
  String name;
  String wiki;
  List<String> types;
  String imageWiki;
  List<Map<String, dynamic>> suitability;
  List<String> drops;
  Aura aura;
  String description;
  List<Skill> skills;

  PalModel({
    required this.id,
    required this.key,
    required this.image,
    required this.name,
    required this.wiki,
    required this.types,
    required this.imageWiki,
    required this.suitability,
    required this.drops,
    required this.aura,
    required this.description,
    required this.skills,
  });

  factory PalModel.fromMap(Map<String, dynamic> map) {
    return PalModel(
      id: map['id'],
      key: map['key'],
      image: map['image'],
      name: map['name'],
      wiki: map['wiki'],
      types: List<String>.from(map['types']),
      imageWiki: map['imageWiki'],
      suitability: List<Map<String, dynamic>>.from(map['suitability']),
      drops: List<String>.from(map['drops']),
      aura: Aura.fromMap(map['aura']),
      description: map['description'],
      skills: List<Skill>.from(
        map['skills'].map((x) => Skill.fromMap(x)),
      ),
    );
  }
}
