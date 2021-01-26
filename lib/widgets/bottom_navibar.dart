import 'package:flutter/material.dart';
import 'package:photostok/res/res.dart';

///Нижняя навигационная панель
class BottomNaviBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: AppColors.dodgerBlue,
      unselectedItemColor: AppColors.manatee,
      showSelectedLabels: true,
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(
            AppIcons.home,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
