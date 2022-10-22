library game_system;

import "dart:html";

part 'node.dart';
part 'components.dart';

class GameManager {
  final CanvasElement canvas;

  late CanvasRenderingContext2D ctx;

  final List<Node> mainNodes = <Node>[];

  num lastTime = 0;

  GameManager({required this.canvas}) {
    final context = canvas.getContext("2d");

    if (context == null) {
      throw "error with context";
    }

    ctx = context as CanvasRenderingContext2D;
  }

  void addNode(Node node) {
    mainNodes.add(node);
  }

  void start() {
    print("Main game started");

    for (Node node in mainNodes) {
      node.preStart();
    }

    window.requestAnimationFrame(loop);
  }

  void loop(num time) {
    final delta = (lastTime == 0 ? 1 : time - lastTime) / 100;

    lastTime = time;

    for (Node node in mainNodes) {
      node.preUpdate(delta);
    }

    // Clear canvas
    ctx.clearRect(0, 0, canvas.width!, canvas.height!);

    for (Node node in mainNodes) {
      node.preRender(ctx, canvas.width!, canvas.height!);
    }

    window.requestAnimationFrame(loop);
  }
}
