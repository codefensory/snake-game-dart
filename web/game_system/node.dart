part of game_system;

abstract class Node {
  List<Node> children = [];

  void preStart() {
    start();

    for (var child in children) {
      child.preStart();
    }
  }

  void start() {}

  void preUpdate(num delta) {
    update(delta);

    for (var child in children) {
      child.preUpdate(delta);
    }
  }

  void update(num delta) {}

  void preRender(CanvasRenderingContext2D ctx, int width, int height) {
    render(ctx, width, height);

    for (var child in children) {
      child.preRender(ctx, width, height);
    }
  }

  void render(CanvasRenderingContext2D ctx, int width, int height) {}

  void addChild(Node child) {
    children.add(child);

    child.start();
  }
}
