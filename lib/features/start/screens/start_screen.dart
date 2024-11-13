import 'package:bee_ai/helper/route_helper.dart';
import 'package:bee_ai/theme/custom_theme.dart';
import 'package:bee_ai/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * @author Giovane Neves
 */
class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.hive,
              height: 150,
              color: CustomTheme.textColor,
            ),
            const SizedBox(height: 20),
            Text(
              'BEE.AI',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),

            ),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RouteHelper.getOnboardingScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomTheme.textColor,
                foregroundColor: CustomTheme.primaryColor,
              ),
              child: Text(
                  'ENTRAR',
                   style: TextStyle(color: CustomTheme.primaryColor, fontSize: 20),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
