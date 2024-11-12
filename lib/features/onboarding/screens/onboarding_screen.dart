import 'package:flutter/material.dart';
import 'package:bee_ai/features/onboarding/screens/onboarding_screen1.dart';
import 'package:bee_ai/features/onboarding/screens/onboarding_screen2.dart';

/**
 * @author Giovane Neves
 */
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {

    _pageController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                OnboardingPage1(controller: _pageController),
                OnboardingPage2(controller: _pageController),
              ],
            ),
          ),
          _buildIndicator(context),
        ],
      ),
    );
  }

  Widget _buildIndicator(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentIndex == index
                  ? theme.textTheme.bodyLarge!.color
                  : theme.textTheme.bodyLarge!.color!.withOpacity(0.4),
            ),
          );
        }),
      ),
    );
  }


}
