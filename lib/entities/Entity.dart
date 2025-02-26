import 'package:flame/components.dart';

enum Direction {
  left,
  right,
  up,
  down,
  none
}

class Entity extends SpriteAnimationComponent with HasGameRef {

  Entity({
    required super.position,
    required super.size,
    this.speed = 100,
  }) : super(
    anchor: Anchor.topLeft,
  );

  Direction requestedDirection = Direction.none;
  Direction _direction = Direction.none;
  Direction get direction => _direction;
  int speed;

  @override
  void update(double dt) {
    super.update(dt);

    if (_direction != requestedDirection) {
      _direction = requestedDirection;
      onDirectionChanged(_direction);
    }

    double speedWithDt = speed * dt;
    switch (_direction) {
      case Direction.left:
        position.x = (position.x - speedWithDt).clamp(0, game.size.x - size.x);
        break;
      case Direction.right:
        position.x = (position.x + speedWithDt).clamp(0, game.size.x - size.x);
        break;
      case Direction.up:
        position.y = (position.y - speedWithDt).clamp(0, game.size.y - size.y);
        break;
      case Direction.down:
        position.y = (position.y + speedWithDt).clamp(0, game.size.y - size.y);
        break;
      case Direction.none:
        break;
    }
  }

  void onDirectionChanged(Direction newDirection) {}
}