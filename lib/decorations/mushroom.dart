import 'dart:ffi';

import 'package:bonfire/bonfire.dart';
import 'package:jogo2/decoration_sprite_sheet.dart';
import 'package:jogo2/hero.dart';

class Mushroom extends GameDecoration with Sensor {
  Mushroom(Vector2 position)
      : super.withSprite(
            sprite: DecorationSpriteSheet.mushroom,
            position: position,
            size: Vector2(16, 16));

  @override
  void onContact(GameComponent component) {
    if (component is GameHero) {
      (component).addLife(25);
      removeFromParent();
    }
  }
}
