import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:exam/data/hero_stats.dart';

class HeroStatsAPI {
  static const host = 'https://www.superheroapi.com/api.php/3606098046375685/';

  final dio = Dio();

  Future <List<HeroStats>> getHeroStats() async {
    List<HeroStats> heroes = [];

    for (var i = 1; i<=10; i++) {
      final response = await dio.get('$host/$i');
      HeroStats hero = HeroStats(
          id: int.parse(response.data['id']),
          name: response.data['name'],
          fullName: response.data['biography']['full-name'],
          image: response.data['image']['url'],
          placeOfBirth: response.data['biography']['place-of-birth'],
          intelligence: response.data['powerstats']['intelligence'] != "null" ? int.parse(response.data['powerstats']['intelligence']) : 0,
          strength: response.data['powerstats']['strength'] != "null" ? int.parse(response.data['powerstats']['strength']) : 0,
          speed: response.data['powerstats']['speed'] != "null" ? int.parse(response.data['powerstats']['speed']) : 0,
          durability: response.data['powerstats']['durability'] != "null" ? int.parse(response.data['powerstats']['durability']): 0,
          power: response.data['powerstats']['power'] != "null" ? int.parse(response.data['powerstats']['power']) : 0,
          combat: response.data['powerstats']['combat'] != "null" ? int.parse(response.data['powerstats']['combat']) : 0,
      );
      heroes.add(hero);
    }
    return heroes;
  }
}