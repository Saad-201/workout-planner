import 'package:flutter/material.dart';
import 'package:ios_test_fresh_37/Screens/start_workout_screen.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';
import '../Models/workout.dart';

class MyWorkoutScreen extends StatefulWidget {
  MyWorkoutScreen({super.key});

  @override
  State<MyWorkoutScreen> createState() => _MyWorkoutScreenState();
}

class _MyWorkoutScreenState extends State<MyWorkoutScreen> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WorkoutProvider>(context);
    final workouts = provider.workouts;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: const Color(0xFFD4AF37),
        title: const Text(
          'My Workouts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
            letterSpacing: -.8,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isEditing
                  ? Icons.check
                  : Icons
                      .edit, // (ternary operator - if else substitute)if isEditing is true, show check icon, else show edit icon
            ),
            onPressed: () {
              setState(
                () {
                  isEditing =
                      !isEditing; // change the state of isEditing(true to false, false to true)
                },
              );
            },
          )
        ],
      ),
      body: isEditing
          ? _buildEditView(workouts)
          : _buildNormalView(workouts), //Ternary operator
    );
  }

// the normal view as the default view of the workout screen,
  Widget _buildNormalView(List<Workout> workouts) {
    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];

          return buildWorkoutTile(workout, index);
        },
      ),
    );
  }

// what the user sees in the screen addded in both normal and edit view
  Widget buildWorkoutTile(Workout workout, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD4AF37), // gold border
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Top Row (Title + Menu)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  workout.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!isEditing)
                IconButton(
                  icon: const Icon(Icons.start_sharp, color: Color(0xFFD4AF37)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StartWorkoutScreen(
                          workout: workout,
                          index: index,
                        ),
                      ),
                    );
                  },
                ),
              if (isEditing)
                IconButton(
                  icon: const Icon(Icons.delete, color: Color(0xFFD4AF37)),
                  onPressed: () {
                    final provider =
                        Provider.of<WorkoutProvider>(context, listen: false);
                    provider.deleteWorkout(index);
                  },
                )
            ],
          ),

          const SizedBox(height: 8),

          // 🔹 Exercise count
          Text(
            "${workout.exercises.length} exercises",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 12),

          // 🔹 Divider
          Container(
            height: 1,
            color: Colors.grey[800],
          ),

          const SizedBox(height: 10),

          // 🔹 Preview of exercises
          Text(
            _getExercisePreview(workout),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditView(List<Workout> workouts) {
    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];

          return buildWorkoutTile(workout, index);
        },
      ),
    );
  }
}

String _getExercisePreview(Workout workout) {
  if (workout.exercises.isEmpty) return "No exercises added";

  return workout.exercises
      .take(3)
      .map((e) => e.name.isEmpty ? "Unnamed" : e.name)
      .join(" • ");
}
