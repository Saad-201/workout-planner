import 'package:flutter/material.dart';
import '../Models/workout.dart';

class WorkoutProvider extends ChangeNotifier {
  // 🔒 Private list (cannot be modified directly outside)
  final List<Workout> _workouts = [];

  // 👀 Public getter (read-only access)
  List<Workout> get workouts => _workouts;

  // ➕ Add workout
  void addWorkout(Workout workout) {
    _workouts.add(workout);

    notifyListeners();
  }

  // ❌ Delete workout
  void deleteWorkout(int index) {
    _workouts.removeAt(index);
    notifyListeners();
  }

  // ✏️ Update workout
  void updateWorkout(int index, Workout updatedWorkout) {
    _workouts[index] = updatedWorkout;
    notifyListeners();
  }
}
