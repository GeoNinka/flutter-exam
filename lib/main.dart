import 'dart:io';

import 'package:exam/data/heroes_stats_api.dart';
import 'package:exam/data/hero_stats.dart';
import 'package:flutter/material.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main Page',
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Heroes API',
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.white
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final result = await InternetAddress.lookup('google.com');
                  debugPrint(result.toString());
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    List<HeroStats> heroes = await HeroStatsAPI().getHeroStats();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            HeroesListPage(heroes: heroes),
                      ),
                    );
                  }
                } on SocketException catch(_) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ErrorPage(),
                    ),
                  );
                }

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                elevation: 4,
              ),
              child: const Text(
                'Fetch API',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HeroesListPage',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Network Error',
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.red
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeroesListPage extends StatelessWidget {
  @override
  const HeroesListPage({
    Key? key,
   required this.heroes,
}) : super(key: key);
  final List<HeroStats> heroes;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HeroesListPage',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: heroes.length,
        itemBuilder: (context, index) {
          return Center(
            child: Card(
              elevation: 20,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Center (
                      child: Column(
                        children: [
                          Image.network(
                            heroes[index].image,

                            width: 310,
                            height: 200,
                          ),
                          Text('${heroes[index].name}'),
                          Text('${heroes[index].fullName}'),
                          Text('${heroes[index].placeOfBirth}'),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HeroPage(hero: heroes[index]),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              elevation: 4,
                            ),
                            child: const Text(
                              'More info',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}

class HeroPage extends StatelessWidget {
  @override
  const HeroPage({
    Key? key,
    required this.hero,
  }) : super(key: key);
  final HeroStats hero;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          hero.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Card(
      elevation: 20,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Center (
              child: Column(
                children: [
                  Image.network(
                    hero.image,
                    width: 310,
                    height: 300,
                  ),
                  Text('${hero.name}'),
                  Text('${hero.fullName}'),
                  Text('${hero.placeOfBirth}'),
                  Text('Intelligence: ${hero.intelligence}'),
                  Text('Strength: ${hero.strength}'),
                  Text('Speed: ${hero.speed}'),
                  Text('Durability: ${hero.durability}'),
                  Text('Power: ${hero.power}'),
                  Text('Combat: ${hero.combat}'),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}