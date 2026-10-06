import 'package:flutter/material.dart';
import '../Models/workout.dart';
import '../Models/workout_set.dart';
import '../Models/exercise.dart';
import '../Widgets/add_exercise_button.dart';
import '../Widgets/exercise_card.dart';
import '../Widgets/floating_navbar.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';

class CreateWorkoutScreen extends StatefulWidget {
  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final TextEditingController controller = TextEditingController();
  List<Exercise> exercises = [];

  void addExercise() {
    setState(() {
      exercises.add(
        Exercise(
          name: "",
          sets: [
            WorkoutSet(reps: 0, weight: 0),
            WorkoutSet(reps: 0, weight: 0),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // String? label = "Workout Name";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Color(0xFFD4AF37),
        title: const Text(
          'Create Workout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
            letterSpacing: -.8,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 0.8 * size.width,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Workout Name",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    // border: OutlineInputBorder(),
                  ),
                ),
              ),
              // addExerciseButton(onpressed: addExercise),

              Column(
                children: [
                  ...exercises.map((exercise) {
                    return ExerciseCard(
                      exercise: exercise,
                    );
                  }).toList(),
                  addExerciseButton(onpressed: addExercise),
                ],
              ),
              Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    final workoutName = controller.text;

                    final workout = Workout(
                      name: workoutName,
                      exercises: exercises,
                    );

                    final provider =
                        Provider.of<WorkoutProvider>(context, listen: false);

                    provider.addWorkout(workout);

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Save Workout",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Add FloatingNavBar to the bottomNavigationBar property of Scaffold
