library game;

import "dart:html";

import "../game_system/main.dart";
import "utils/point_math.dart" as point_math;
import "utils/extra_math.dart";

part "snake.dart";
part "tail.dart";

class MainNodes {
  static get() {
    return [Snake()];
  }
}
