import 'package:bonfire/bonfire.dart';

class DecorationSpriteSheet {
  static Future<Sprite> get mushroom => Sprite.load(
        'map/forest_decoration.png',
        srcPosition: Vector2(128, 16),
        srcSize: Vector2(16, 16),
      );
}
