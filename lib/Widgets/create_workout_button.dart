import 'package:flutter/material.dart';

import '../Models/workout.dart';
import '../Screens/create_workout_screen.dart';

LayoutBuilder premiumButton() {
  return LayoutBuilder(
    //layout bilder is good for responsive screen which width and height can be implemnted manully
    builder: (context, constraints) {
      double buttonWidth = constraints.maxWidth * 0.85;
      double buttonHeight = buttonWidth * 0.3;

      return Center(
        child: SizedBox(
          width: buttonWidth,
          height: buttonHeight,
          child: CustomPaint(
            painter: DottedBorderPainter(),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  // backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final newWorkout = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateWorkoutScreen(),
                    ),
                  );
                }, // when pressed features
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(mainAxisSize: MainAxisSize.min, children: const [
                        Icon(
                          Icons.add,
                          color: Color(0xFFD4AF37),
                          size: 24,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'New Workout',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD4AF37),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 5),
                      const Text(
                        "Create your own custom workout plan",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 101, 101, 99),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 13;
    const dashSpace = 4;

    final paint = Paint() //the button's paint
      ..color = const Color(0xFFD4AF37) // gold
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path() //the button's shape
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
        const Radius.circular(12),
      ));

    final metrics = path.computeMetrics();

    for (var metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        final segment = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
