library game;

import "dart:html";

import "../game_system/main.dart";
import "utils/point_math.dart" as point_math;

part "snake.dart";

class MainNodes {
  static get() {
    return [Snake()];
  }
}
