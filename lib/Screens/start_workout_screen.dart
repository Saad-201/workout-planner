import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/workout.dart';
import '../providers/workout_provider.dart';

class StartWorkoutScreen extends StatefulWidget {
  final Workout workout;
  final int index;

  const StartWorkoutScreen({
    super.key,
    required this.workout,
    required this.index,
  });

  @override
  State<StartWorkoutScreen> createState() => _StartWorkoutScreenState();
}

class _StartWorkoutScreenState extends State<StartWorkoutScreen> {
  final TextEditingController controller = TextEditingController();
  late Workout activeWorkout;

  late Timer timer;
  int seconds = 0;

  @override
  void initState() {
    super.initState();

    //  Use the actual workout (you want updates)
    activeWorkout = widget.workout;

    //  Start timer
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        seconds++;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: const Color(0xFFD4AF37),
        title: Text(
          activeWorkout.name,
          style: const TextStyle(color: Color(0xFFD4AF37)),
        ),
      ),

      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // closes keyboard when tapped anywhere on the card
        },
        child: ListView.builder(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.15,
          ),
          itemCount: activeWorkout.exercises
              .length, // this creates the containers for each exercise
          itemBuilder: (context, i) {
            // this is the builder for each exercise container
            final exercise = activeWorkout
                .exercises[i]; // this is the exercise object for each container

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD4AF37)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  Exercise Name
                  Text(
                    exercise.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  //  Sets
                  ...exercise.sets.asMap().entries.map((entry) {
                    int setIndex = entry.key;
                    var set = entry.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          // SET NUMBER
                          Text(
                            "Set ${setIndex + 1}",
                            style: const TextStyle(color: Colors.white70),
                          ),

                          const SizedBox(width: 10),

                          // REPS FIELD
                          Expanded(
                            child: TextFormField(
                              initialValue: set.reps.toString(),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelText: "Reps",
                                labelStyle: TextStyle(color: Colors.grey),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  set.reps = int.tryParse(value) ?? 0;
                                });
                              },
                            ),
                          ),

                          const SizedBox(width: 10),

                          // WEIGHT FIELD
                          Expanded(
                            child: TextFormField(
                              initialValue: set.weight.toString(),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelText: "Weight",
                                labelStyle: TextStyle(color: Colors.grey),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  set.weight = double.tryParse(value) ?? 0;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
        ),
      ),

      //  SAVE BUTTON
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFD4AF37),
        onPressed: () {
          Provider.of<WorkoutProvider>(context, listen: false)
              .updateWorkout(widget.index, activeWorkout);

          Navigator.pop(context);
        },
        label: const Text(
          "Save Workout",
          style: TextStyle(color: Colors.black),
        ),
        icon: const Icon(Icons.save, color: Colors.black),
      ),

      //  TIMER BAR
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black,
        child: Text(
          formatTime(seconds),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFD4AF37),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
