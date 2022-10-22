part of game;

class Snake extends Node {
  final head = Square()
    ..width = 15
    ..height = 15;

  int speed = 26;

  Point direction = Point(1, 0);

  Point lastPosDirChanged = Point(0, 0);

  @override
  void start() {
    addChild(head);

    Square prevTail = head;

    for (var i = 0; i < 20; i++) {
      final tail = createTail(prevTail);

      prevTail = tail;

      addChild(tail);
    }

    window.addEventListener("keydown", onKeyDown);
  }

  Tail createTail(Square parent) {
    return Tail(parent)
      ..width = 15
      ..height = 15;
  }

  @override
  void update(num delta) {
    head.x += direction.x * speed * delta;

    head.y += direction.y * speed * delta;
  }

  void onKeyDown(event) {
    final String key = event.key.toLowerCase();

    final distanceWithLastChanged = point_math.distance(lastPosDirChanged, Point(head.x, head.y));

    if (distanceWithLastChanged < head.width) {
      return;
    }

    final lastDirection = direction;

    switch (key) {
      case "d":
        if (direction.x != -1) {
          direction = Point(1, 0);
        }
        break;
      case "a":
        if (direction.x != 1) {
          direction = Point(-1, 0);
        }
        break;
      case "w":
        if (direction.y != 1) {
          direction = Point(0, -1);
        }
        break;
      case "s":
        if (direction.y != -1) {
          direction = Point(0, 1);
        }
        break;
      default:
        return;
    }

    if (lastDirection != direction) {
      lastPosDirChanged = Point(head.x, head.y);
    }
  }
}

class Tail extends Square {
  final Square parent;

  late Point prevParentPosition;

  Tail(this.parent);

  Point prevParentDirection = Point(0, 0);

  Point prevParentChangedPosition = Point(0, 0);

  Point prevPosition = Point(0, 0);

  Point prevDir = Point(0, 0);

  @override
  void start() {
    prevParentPosition = Point(parent.x, parent.y);

    prevParentChangedPosition = Point(parent.x, parent.y);

    prevPosition = Point(parent.x, parent.y);

    x = parent.x;

    y = parent.y;
  }

  @override
  void update(num delta) {
    final parentDir = point_math.direction(prevParentPosition, Point(parent.x, parent.y));

    final goPosition = Point(parent.x - width * parentDir.x, parent.y - height * parentDir.y);

    if (parentDir != prevParentDirection) {
      prevParentDirection = parentDir;

      prevParentChangedPosition = prevParentPosition;

      prevDir = point_math.direction(Point(x, y), prevParentChangedPosition);

      prevPosition = Point(x, y);
    }

    final changeDistance =
        point_math.distance(prevParentChangedPosition, Point(parent.x, parent.y));

    final isCompensing = changeDistance < width;

    if (parentDir.y != 0 && isCompensing) {
      prevParentChangedPosition = Point(parent.x, prevPosition.y);

      x = prevParentChangedPosition.x +
          (goPosition.y - prevParentChangedPosition.y) * prevDir.x * parentDir.y;

      y = prevParentChangedPosition.y;
    } else if (parentDir.x != 0 && isCompensing) {
      prevParentChangedPosition = Point(prevPosition.x, parent.y);

      y = prevParentChangedPosition.y +
          (goPosition.x - prevParentChangedPosition.x) * prevDir.y * parentDir.x;

      x = prevParentChangedPosition.x;
    } else {
      x = parent.x - width * parentDir.x;

      y = parent.y - height * parentDir.y;
    }

    prevParentPosition = Point(parent.x, parent.y);
  }
}
