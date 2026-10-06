import 'package:flutter/material.dart';

// import '../Models/workout.dart';
import '../Widgets/floating_navbar.dart';
import 'Home/home_screen.dart';
// import 'login_screen.dart';
import 'my_wokouts.dart';
import 'progress_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(),
      MyWorkoutScreen(),
      ProgressScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(
            index: currentIndex,
            children: pages,
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: FloatingNavBar(
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
