import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.home,
              color: currentIndex == 0
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).iconTheme.color,
            ),
            onPressed: () => onTap(0),
          ),
          IconButton(
            icon: Icon(
              Icons.cloud,
              color: currentIndex == 1
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).iconTheme.color,
            ),
            onPressed: () => onTap(1),
          ),
          Container(width: 48),
          IconButton(
            icon: Icon(
              Icons.map,
              color: currentIndex == 2
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).iconTheme.color,
            ),
            onPressed: () => onTap(2),
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: currentIndex == 3
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).iconTheme.color,
            ),
            onPressed: () => onTap(3),
          ),
        ],
      ),
    );
  }
}
