
import 'package:hive/hive.dart';

class HeroStats{
  final int id;
  final String name;
  final String fullName;
  final String placeOfBirth;
  final String image;
  final int intelligence;
  final int strength;
  final int speed;
  final int durability;
  final int power;
  final int combat;

  HeroStats({
    required this.id,
    required this.name,
    required this.fullName,
    required this.placeOfBirth,
    required this.image,
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
});
}