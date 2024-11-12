import 'dart:convert';
import 'package:bee_ai/features/hive/screens/add_hive_screen.dart';
import 'package:bee_ai/features/hive/screens/hive_data_screen.dart';
import 'package:bee_ai/features/hive/screens/hive_home_screen.dart';
import 'package:bee_ai/features/home/screens/home_screen.dart';
import 'package:bee_ai/features/ip/screens/ip_login.dart';
import 'package:bee_ai/features/onboarding/screens/onboarding_screen.dart';
import 'package:bee_ai/features/settings/screens/settings_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String addHive = '/add-hive';
  static const String hiveData = '/hive-data';
  static const String hiveHome = '/hive-home';
  static const String home = '/home';
  static const String ipLogin = '/ip';
  static const String notification = '/notification';
  static const String onboarding = '/onboarding';
  static const String settings = '/settings';

  static String getAddHiveScreen() => addHive;
  static String getHiveDataScreen(String hiveId, String ip) => '$hiveData?hive_id=$hiveId&ip=$ip';
  static String getHiveHomeScreen() => hiveHome;
  static String getIpLoginScreen() => ipLogin;
  static String getHomeScreen(String ip) => '$home?ip=$ip';
  static String getNotificationScreen() => notification;
  static String getOnboardingScreen() => onboarding;
  static String getSettingsScreen() => settings;

  // Registro de rotas [ Adicionar todas as rotas do app aqui ]
  static List<GetPage> routes = [
    GetPage(
        name: addHive,
        page: () => AddHiveScreen()
    ),
    GetPage(
      name: hiveData,
      page: () => HiveDataScreen(
        ipLogin: Get.parameters['ip'] ?? '192.168.1.100',
        hiveId: Get.parameters['hive_id'] ?? '',),
    ),
    GetPage(
        name: hiveHome,
        page: () => HiveHomeScreen()
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(ip: Get.parameters['ip'] ?? ''),
    ),
    GetPage(
        name: ipLogin,
        page: () => IpLoginScreen()
    ),
    //GetPage(name: notification, page: () => NotificationScreen()),
    GetPage(
        name: onboarding,
        page: () => OnboardingScreen()
    ),
    GetPage(
        name: settings,
        page: () => SettingsScreen()
    ),
  ];
}
