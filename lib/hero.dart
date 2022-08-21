import 'package:bonfire/bonfire.dart';
import 'package:jogo2/player_sprite_sheet.dart';
import 'package:jogo2/main.dart';
import 'package:flutter/material.dart';

class GameHero extends SimplePlayer with ObjectCollision, Lighting {
  GameHero(Vector2 position)
      : super(
          size: Vector2(tileSize, tileSize),
          position: position,
          animation: SimpleDirectionAnimation(
            idleRight: PlayerSpriteSheet.heroIdleRight,
            idleLeft: PlayerSpriteSheet.heroIdleLeft,
            runRight: PlayerSpriteSheet.heroRunRight,
            runLeft: PlayerSpriteSheet.heroRunLeft,
          ),
          speed: 55,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(size: Vector2(8, 10), align: Vector2(4, 7)),
        ],
      ),
    );
    setupLighting(
      LightingConfig(radius: tileSize * 2, color: Colors.transparent),
    );
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN && event.id == 1) {
      _executeAttack();
    }
    super.joystickAction(event);
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
    );
  }

  @override
  void die() {
    if (lastDirectionHorizontal == Direction.left) {
      animation?.playOnce(
        PlayerSpriteSheet.DieLeft,
        runToTheEnd: true,
        onFinish: () {
          removeFromParent();
        },
      );
    } else {
      animation?.playOnce(
        PlayerSpriteSheet.DieRight,
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
        PlayerSpriteSheet.ReciveDamageLeft,
        runToTheEnd: true,
      );
    } else {
      animation?.playOnce(
        PlayerSpriteSheet.ReciveDamageRight,
        runToTheEnd: true,
      );
    }
    super.receiveDamage(attacker, damage, from);
  }
}
