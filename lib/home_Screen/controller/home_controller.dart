import 'dart:math';

import 'package:clean_arch/home_Screen/model/placed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

class HomeController extends ChangeNotifier {
  List<PlacedWidget> widgets = [];

  void addWidget(WidgetType type, double x, double y) {
    // Create a unique id based on timestamp and random number
    String id = DateTime.now().millisecondsSinceEpoch.toString() +
        Random().nextInt(1000).toString();
    // Use ScreenUtil to set responsive default sizes
    widgets.add(PlacedWidget(
      id: id,
      type: type,
      x: x,
      y: y,
      width: 120.w,
      height: 60.h,
    ));
    notifyListeners();
  }

  void updatePosition(String id, double newX, double newY) {
    final placedWidget = widgets.firstWhereOrNull((w) => w.id == id);
    if (placedWidget != null) {
      placedWidget.x = newX;
      placedWidget.y = newY;
      notifyListeners();
    }
  }

  void updateSize(String id, double newWidth, double newHeight) {
    final placedWidget = widgets.firstWhereOrNull((w) => w.id == id);
    if (placedWidget != null) {
      placedWidget.width = newWidth;
      placedWidget.height = newHeight;
      notifyListeners();
    }
  }
}
