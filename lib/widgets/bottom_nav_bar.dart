import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  final Function(int index) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 0,
      selectedItemColor: const Color(0xFF2D2D5E),
      unselectedItemColor: const Color(0xFF6B6681),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 0 ? Icons.home : Icons.home_outlined,
            color: currentIndex == 0
                ? const Color(0xFF2D2D5E)
                : const Color(0xFF6B6681),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 1
                ? Icons.medical_services
                : Icons.medical_services_outlined,
            color: currentIndex == 1
                ? const Color(0xFF2D2D5E)
                : const Color(0xFF6B6681),
          ),
          label: 'Find a Doctor',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 2 ? Icons.assignment : Icons.assignment_outlined,
            color: currentIndex == 2
                ? const Color(0xFF2D2D5E)
                : const Color(0xFF6B6681),
          ),
          label: 'Prescriptions',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 3 ? Icons.menu : Icons.menu,
            color: currentIndex == 3
                ? const Color(0xFF2D2D5E)
                : const Color(0xFF6B6681),
          ),
          label: 'Menu',
        ),
      ],
    );
  }
}
