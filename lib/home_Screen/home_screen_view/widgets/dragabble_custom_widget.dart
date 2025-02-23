import 'dart:math';

import 'package:clean_arch/home_Screen/controller/home_controller.dart';
import 'package:clean_arch/home_Screen/model/placed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DraggableWidget extends StatefulWidget {
  final PlacedWidget placedWidget;

  const DraggableWidget({super.key, required this.placedWidget});

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  late double x, y, width, height;
  double sliderValue = 0.5;

  @override
  void initState() {
    super.initState();
    x = widget.placedWidget.x;
    y = widget.placedWidget.y;
    width = widget.placedWidget.width;
    height = widget.placedWidget.height;
    if (widget.placedWidget.type == WidgetType.slider) {
      sliderValue = 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    return Positioned(
      left: x,
      top: y,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            x += details.delta.dx;
            y += details.delta.dy;
          });
          homeController.updatePosition(widget.placedWidget.id, x, y);
        },
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: buildInnerWidget(widget.placedWidget.type),
            ),
            // Resize handle in the bottom-right corner.
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    width = max(50.w, width + details.delta.dx);
                    height = max(30.h, height + details.delta.dy);
                  });
                  homeController.updateSize(widget.placedWidget.id, width, height);
                },
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white),
                  ),
                  child: Icon(Icons.drag_handle, color: Colors.white, size: 12.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Build the actual widget based on its type.
  Widget buildInnerWidget(WidgetType type) {
    switch (type) {
      case WidgetType.push:
        return ElevatedButton(
          onPressed: () {},
          child: Text("Push", style: TextStyle(fontSize: 14.sp)),
        );
      case WidgetType.click:
        return TextButton(
          onPressed: () {},
          child: Text("Click", style: TextStyle(fontSize: 14.sp)),
        );
      case WidgetType.slider:
        return Slider(
          value: sliderValue,
          onChanged: (val) {
            setState(() {
              sliderValue = val;
            });
          },
        );
      default:
        return const SizedBox();
    }
  }
}
