import 'package:clean_arch/home_Screen/controller/home_controller.dart';
import 'package:clean_arch/home_Screen/home_screen_view/widgets/dragabble_custom_widget.dart';
import 'package:clean_arch/home_Screen/home_screen_view/widgets/menu_item_widget.dart';
import 'package:clean_arch/home_Screen/model/placed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  // GlobalKey to obtain canvas render box for coordinate conversion
  final GlobalKey canvasKey = GlobalKey();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag & Drop Task'),
      ),
      body: Row(
        children: [
          // Left Menu Panel
          Container(
            width: 150.w,
            color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                const Draggable<WidgetType>(
                  data: WidgetType.push,
                  feedback: Opacity(
                    opacity: 0.7,
                    child: MenuItemWidget(title:"Push Button"),
                  ),
                  child: MenuItemWidget(title:"Push Button"),
                ),
                SizedBox(height: 20.h),
                const Draggable<WidgetType>(
                  data: WidgetType.click,
                  feedback: Opacity(
                    opacity: 0.7,
                    child: MenuItemWidget(title:"Click Button"),
                  ),
                  child: MenuItemWidget(title:"Click Button"),
                ),
                SizedBox(height: 20.h),
                const Draggable<WidgetType>(
                  data: WidgetType.slider,
                  feedback: Opacity(
                    opacity: 0.7,
                    child:  MenuItemWidget(title:"Slider"),
                  ),
                  child: MenuItemWidget(title:"Slider"),
                ),
              ],
            ),
          ),
          // Canvas Area
          Expanded(
            child: Container(
              key: canvasKey,
              color: Colors.white,
              child: DragTarget<WidgetType>(
                onWillAccept: (data) => true,
                onAcceptWithDetails: (details) {
                  // Convert the global offset to a local offset relative to the canvas
                  final RenderBox renderBox = canvasKey.currentContext!.findRenderObject() as RenderBox;
                  final localOffset = renderBox.globalToLocal(details.offset);
                  homeController.addWidget(details.data, localOffset.dx, localOffset.dy);
                },
                builder: (context, candidateData, rejectedData) {
                  return Consumer<HomeController>(
                    builder: (context, controller, child) {
                      return Stack(
                        children: controller.widgets
                            .map((w) => DraggableWidget(placedWidget: w)).toList(),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

