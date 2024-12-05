import 'package:bee_ai/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: CustomTheme.textColor,
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: currentIndex == 0
                  ? CustomTheme.backgroundColor
                  : Theme.of(context).iconTheme.color,
            ),
            onPressed: () => onTap(0),
          ),
          IconButton(
            icon: Icon(
              Icons.stacked_bar_chart,
              color: currentIndex == 1
                  ? CustomTheme.backgroundColor
                  : Theme.of(context).iconTheme.color,
            ),
            onPressed: () => onTap(1),
          ),
          Container(width: 48),
          IconButton(
            icon: Icon(
              Icons.map,
              color: currentIndex == 2
                  ? CustomTheme.backgroundColor
                  : Theme.of(context).iconTheme.color,
            ),
            onPressed: () => onTap(2),
          ),
          /*IconButton(
            icon: Icon(
              Icons.settings,
              color: currentIndex == 3
                  ? CustomTheme.backgroundColor
                  : Theme.of(context).iconTheme.color,
            ),
            onPressed: () => onTap(3),
          ),*/
        ],
      ),
    );
  }
}
