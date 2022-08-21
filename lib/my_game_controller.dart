import 'package:bonfire/base/game_component.dart';
import 'package:flutter/material.dart';
import 'package:jogo2/main.dart';

class MyGameController extends GameComponent {
  bool endGame = false;
  @override
  void update(double dt) {
    if (checkInterval('end game', 500, dt)) {
      if (gameRef.livingEnemies() == 0 && !endGame) {
        endGame = true;
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Parabéns você ganhou'),
            );
          },
        );
      }
    }

    super.update(dt);
  }
}
