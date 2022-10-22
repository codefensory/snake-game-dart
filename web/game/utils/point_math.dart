library point_math;

import "dart:math";

double distance(Point a, Point b) {
  return sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2));
}

Point direction(Point last, Point curr) {
  final dir = Point(curr.x - last.x, curr.y - last.y);

  final dirAbs = Point(abs(dir.x), abs(dir.y));

  if (dirAbs.x > dirAbs.y) {
    return Point(
        dir.x > 0
            ? 1
            : dir.x == 0
                ? 0
                : -1,
        0);
  } else {
    return Point(
        0,
        dir.y > 0
            ? 1
            : dir.y == 0
                ? 0
                : -1);
  }
}

num abs(num point) {
  return point > 0 ? point : point * -1;
}
