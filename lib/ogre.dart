import 'package:bonfire/bonfire.dart';
import 'package:flutter/cupertino.dart';
import 'package:jogo2/main.dart';
import 'package:jogo2/ogre_sprite_sheet.dart';
import 'package:jogo2/player_sprite_sheet.dart';

class Ogre extends SimpleEnemy with ObjectCollision {
  Ogre(Vector2 position)
      : super(
          position: position,
          size: Vector2(tileSize, tileSize),
          animation: SimpleDirectionAnimation(
              idleLeft: OgreSpriteSheet.idleLeft,
              idleRight: OgreSpriteSheet.idleRight,
              runRight: OgreSpriteSheet.runRight,
              runLeft: OgreSpriteSheet.runLeft),
          speed: 25,
          life: 100,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(size: Vector2(8, 10), align: Vector2(4, 7)),
        ],
      ),
    );
  }

  @override
  void update(double dt) {
    seeAndMoveToPlayer(
      closePlayer: (player) {
        _executeAttack();
      },
      radiusVision: tileSize * 4,
      margin: 4,
    );
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    drawDefaultLifeBar(
      canvas,
      borderWidth: 1,
      height: 2,
      align: const Offset(0, -5),
    );
    super.render(canvas);
  }

  @override
  void die() {
    if (lastDirectionHorizontal == Direction.left) {
      animation?.playOnce(
        OgreSpriteSheet.DieLeft,
        runToTheEnd: true,
        onFinish: () {
          removeFromParent();
        },
      );
    } else {
      animation?.playOnce(
        OgreSpriteSheet.DieRight,
        runToTheEnd: true,
        onFinish: () {
          removeFromParent();
        },
      );
    }

    super.die();
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, from) {
    if (lastDirectionHorizontal == Direction.left) {
      animation?.playOnce(
        OgreSpriteSheet.ReciveDamageLeft,
        runToTheEnd: true,
      );
    } else {
      animation?.playOnce(
        OgreSpriteSheet.ReciveDamageRight,
        runToTheEnd: true,
      );
    }
    super.receiveDamage(attacker, damage, from);
  }

  void _executeAttack() {
    simpleAttackMelee(
      damage: 25,
      size: Vector2(tileSize, tileSize),
      sizePush: tileSize * 0.5,
      animationDown: PlayerSpriteSheet.AttackDown,
      animationLeft: PlayerSpriteSheet.AttackLeft,
      animationRight: PlayerSpriteSheet.AttackRight,
      animationUp: PlayerSpriteSheet.AttackTop,
      withPush: false,
    );
  }
}
