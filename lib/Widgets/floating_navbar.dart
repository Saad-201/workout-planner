import 'package:flutter/material.dart';

class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Color(0xFFD4AF37),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 15,
            spreadRadius: 2,
          )
        ],
      ),
      child: Stack(
        children: [
          /// GOLD INDICATOR
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linearToEaseOut,
            alignment: currentIndex ==
                    0 //acts like an if statement, if currentIndex is 0, align left, else align right
                ? Alignment.centerLeft
                : currentIndex == 1
                    ? Alignment.center
                    : Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width / 3 - 13,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37),
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ),

          /// ICON ROW
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: currentIndex == 0 ? Colors.black : Colors.grey,
                  ),
                  onPressed: () => onTap(0),
                ),
                IconButton(
                  icon: Icon(
                    Icons.fitness_center,
                    color: currentIndex == 1 ? Colors.black : Colors.grey,
                  ),
                  onPressed: () => onTap(1),
                ),
                IconButton(
                  icon: Icon(
                    Icons.show_chart,
                    color: currentIndex == 2 ? Colors.black : Colors.grey,
                  ),
                  onPressed: () => onTap(2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
