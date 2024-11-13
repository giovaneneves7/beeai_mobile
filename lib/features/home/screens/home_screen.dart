import 'package:bee_ai/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:bee_ai/features/hive/screens/add_hive_screen.dart';
import 'package:bee_ai/features/hive/screens/hive_data_screen.dart';
import 'package:bee_ai/features/hive/screens/hive_home_screen.dart';
import 'package:bee_ai/features/map/screens/map_screen.dart';
import 'package:bee_ai/features/settings/screens/settings_screen.dart';
import 'package:bee_ai/helper/route_helper.dart';
import 'package:bee_ai/theme/custom_theme.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  final String ip;

  HomeScreen({required this.ip});

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      //HiveDataScreen(ipLogin: widget.ip),
      HiveHomeScreen(),
      AddHiveScreen(),
      MapScreen(),
      SettingsScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.primaryColor,
      body: _screens[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(RouteHelper.getAddHiveScreen());
        },
        child: const Icon(Icons.search, color: CustomTheme.primaryColor,),
        backgroundColor: CustomTheme.textColor,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
