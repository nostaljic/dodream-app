import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dodream/app_pages.dart';
import 'package:dodream/controller/controller.dart';
import 'package:dodream/ui/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    initialRoute: "/",
  ));
}