import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:jogo2/decorations/mushroom.dart';
import 'package:jogo2/hero.dart';
import 'package:jogo2/interface/player_interface.dart';
import 'package:jogo2/my_game_controller.dart';
import 'package:jogo2/ogre.dart';
import 'package:jogo2/decorations/lamp.dart';
import 'package:jogo2/interface/player_interface.dart';

final double tileSize = 16;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BonfireTiledWidget(
      joystick: Joystick(
          directional: JoystickDirectional(
            color: Colors.black,
          ),
          actions: [
            JoystickAction(
              actionId: 1,
              color: Colors.black,
              margin: EdgeInsets.all(40),
              size: 30,
            ),
          ]),
      map: TiledWorldMap('map/map.json', objectsBuilder: {
        'ogre': (proprieties) => Ogre(proprieties.position),
        'lamp': (properties) => Lamp(properties.position),
        'mushroom': (properties) => Mushroom(properties.position),
      }),
      player: GameHero(
        Vector2(6 * tileSize, 5 * tileSize),
      ),
      overlayBuilderMap: {
        'playerInterface': (context, game) => PlayerInterface(game: game)
      },
      initialActiveOverlays: const [
        PlayerInterface.overlayKey,
      ],
      components: [MyGameController()],
      cameraConfig: CameraConfig(
        moveOnlyMapArea: true,
        zoom: 2.5,
        smoothCameraEnabled: true,
      ),
      lightingColorGame: Colors.black.withOpacity(0.5),
    );
  }
}
