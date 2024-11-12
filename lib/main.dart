import 'dart:convert';
import 'dart:io';
import 'package:bee_ai/features/start/screens/start_screen.dart';
import 'package:bee_ai/helper/route_helper.dart';
import 'package:bee_ai/theme/custom_theme.dart';
import 'package:bee_ai/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
//import 'helper/get_di.dart' as di;

void main() {
  runApp(const App());
}

/**
 * @author Giovane Neves
 */
class App extends StatelessWidget {
  const App({super.key});

  Future<void> main() async {


  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: RouteHelper.routes,
      home: StartScreen(),
      title: AppConstants.appName,
      theme: CustomTheme.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}

