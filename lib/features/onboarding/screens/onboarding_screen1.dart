import 'package:flutter/material.dart';
import 'package:bee_ai/theme/custom_theme.dart';

class OnboardingPage1 extends StatelessWidget {
  final PageController controller;

  OnboardingPage1({required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hive_outlined,
            size: 100,
            color: CustomTheme.textColor,
          ),
          SizedBox(height: 20),
          Text(
            "Bem-Vindo Ao Sistema De Monitoramento De Colmeias",
            style: theme.textTheme.bodyLarge!.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
                "Próximo >",
                style: TextStyle(color: CustomTheme.textColor),
            ),
          ),
        ],
      ),
    );
  }
}
