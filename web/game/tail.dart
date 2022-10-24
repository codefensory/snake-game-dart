part of game;

class Tail extends Square {
  Tail? parent;

  late Point dir;

  late Point posChanged;

  late Point childPos;

  Tail(Tail newParent) {
    parent = newParent;
    position = newParent.position;
    dir = newParent.dir;
    posChanged = position;
    childPos = position;
  }

  Tail.head({required Point startPos, required Point startDirection}) {
    position = startPos;
    dir = startDirection;
    posChanged = position;
    childPos = position;
  }

  @override
  void update(num delta) {
    final tailParent = parent;

    if (tailParent == null) {
      return;
    }

    final double distance = point_math.distance(tailParent.posChanged, tailParent.position);

    if (distance >= width) {
      setDir(tailParent.dir);
    }

    if (dir != tailParent.dir) {
      double xPos = tailParent.childPos.x + clamp(distance, 0, width as double) * dir.x;

      double yPos = tailParent.childPos.y + clamp(distance, 0, width as double) * dir.y;

      position = Point(xPos, yPos);
    } else {
      position =
          Point(tailParent.x - width * tailParent.dir.x, tailParent.y - height * tailParent.dir.y);
    }
  }

  void setDir(Point direction) {
    if (dir != direction) {
      Tail? tailParent = parent;

      if (tailParent == null) {
        posChanged = position;

        childPos = Point(position.x - width * dir.x, position.y - height * dir.y);

        dir = direction;
      } else {
        posChanged = tailParent.posChanged;

        childPos = tailParent.childPos;

        dir = tailParent.dir;
      }
    }
  }
}
