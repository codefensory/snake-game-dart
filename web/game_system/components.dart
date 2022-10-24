part of game_system;

class Square extends Node with Position, Figure, RectGeometry, Fill {}

class Circle extends Node with Position, Figure, CircleGeometry, Fill {}

mixin Position on Node {
  num x = 0;

  num y = 0;

  Point get position => Point(x, y);

  set position(Point newPoint) {
    x = newPoint.x;
    y = newPoint.y;
  }
}

mixin Figure on Position {
  @override
  void render(CanvasRenderingContext2D ctx, int width, int height) {
    drawGeometry(ctx);
    drawFill(ctx);
    drawStroke(ctx);
  }

  drawGeometry(CanvasRenderingContext2D ctx);

  drawFill(CanvasRenderingContext2D ctx) {}

  drawStroke(CanvasRenderingContext2D ctx) {}
}

mixin RectGeometry on Figure {
  num width = 10;

  num height = 10;

  @override
  void drawGeometry(CanvasRenderingContext2D ctx) {
    ctx.beginPath();
    ctx.rect(x, y, width, height);
  }
}

mixin CircleGeometry on Figure {
  num radius = 10;

  @override
  void drawGeometry(CanvasRenderingContext2D ctx) {
    ctx.beginPath();
    ctx.arc(x, y, radius, 0, 360);
  }
}

mixin Fill on Figure {
  String fillStyle = "red";

  @override
  void drawFill(CanvasRenderingContext2D ctx) {
    ctx.fillStyle = fillStyle;
    ctx.fill();
  }
}

mixin Stroke on Figure {
  String strokeStyle = "red";

  @override
  void drawStroke(CanvasRenderingContext2D ctx) {
    ctx.strokeStyle = strokeStyle;
    ctx.stroke();
  }
}
