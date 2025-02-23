import 'package:clean_arch/home_Screen/controller/home_controller.dart';
import 'package:clean_arch/home_Screen/home_screen_view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, child) {
        return ChangeNotifierProvider<HomeController>(
          create: (_) => HomeController(),
          child: MaterialApp(
            title: 'Drag & Drop Task',
            home: HomeScreen(),
          ),
        );
      },
    );
  }
}
