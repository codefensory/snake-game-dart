part of game;

// Snake without grid
class Snake extends Node {
  final head = Tail.head(startPos: Point(0, 0), startDirection: Point(1, 0))
    ..width = 15
    ..height = 15;

  int speed = 26;

  Point lastPosDirChanged = Point(0, 0);

  @override
  void start() {
    addChild(head);

    Tail prevTail = head;

    for (var i = 0; i < 40; i++) {
      final tail = Tail(prevTail)
        ..width = 15
        ..height = 15;

      prevTail = tail;

      addChild(tail);
    }

    window.addEventListener("keydown", onKeyDown);
  }

  @override
  void update(num delta) {
    head.x += head.dir.x * speed * delta;

    head.y += head.dir.y * speed * delta;
  }

  void onKeyDown(event) {
    final String key = event.key.toLowerCase();

    final distanceWithLastChanged = point_math.distance(lastPosDirChanged, Point(head.x, head.y));

    if (distanceWithLastChanged < head.width + 4) {
      return;
    }

    final lastDirection = head.dir;

    switch (key) {
      case "d":
        if (head.dir.x != -1) {
          head.setDir(Point(1, 0));
        }
        break;
      case "a":
        if (head.dir.x != 1) {
          head.setDir(Point(-1, 0));
        }
        break;
      case "w":
        if (head.dir.y != 1) {
          head.setDir(Point(0, -1));
        }
        break;
      case "s":
        if (head.dir.y != -1) {
          head.setDir(Point(0, 1));
        }
        break;
      default:
        return;
    }

    if (lastDirection != head.dir) {
      lastPosDirChanged = Point(head.x, head.y);
    }
  }
}
