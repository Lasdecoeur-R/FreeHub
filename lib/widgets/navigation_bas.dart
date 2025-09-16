import 'package:flutter/material.dart';
import 'element_navigation_bas.dart';

class NavigationBas extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const NavigationBas({super.key, this.selectedIndex = 1, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => onTap(0),
            child: ElementNavigationBas(
              Icons.home,
              estSelectionnee: selectedIndex == 0,
            ),
          ),
          GestureDetector(
            onTap: () => onTap(1),
            child: ElementNavigationBas(
              Icons.favorite,
              estSelectionnee: selectedIndex == 1,
            ),
          ),
          GestureDetector(
            onTap: () => onTap(2),
            child: ElementNavigationBas(
              Icons.person,
              estSelectionnee: selectedIndex == 2,
            ),
          ),
        ],
      ),
    );
  }
}