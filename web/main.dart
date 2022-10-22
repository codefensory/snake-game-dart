import "dart:html";

import "game_system/main.dart" show GameManager;
import "game/main.dart" show MainNodes;

void main() {
  final canvas = querySelector("#stage") as CanvasElement?;

  if (canvas == null) {
    throw '#stage canvas not found';
  }

  final gameManager = GameManager(canvas: canvas);

  final mainNodes = MainNodes.get();

  for (var node in mainNodes) {
    gameManager.addNode(node);
  }

  gameManager.start();
}
