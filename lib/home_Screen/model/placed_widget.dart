enum WidgetType { push, click, slider }

class PlacedWidget {
  final String id;
  final WidgetType type;
  double x;
  double y;
  double width;
  double height;

  PlacedWidget({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
}