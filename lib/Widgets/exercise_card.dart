import 'package:flutter/material.dart';
import '../Models/exercise.dart';
import '../Models/workout_set.dart';
import 'package:numberpicker/numberpicker.dart';

class ExerciseCard extends StatefulWidget {
  final Exercise exercise;

  const ExerciseCard({
    super.key,
    required this.exercise,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // closes keyboard when tapped anywhere on the card
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          width: 0.9 * size.width,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFFD4AF37),
            ),
          ),
          child: Column(
            children: [
              TextField(
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic),
                decoration: const InputDecoration(
                  hintText: "Exercise Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  widget.exercise.name = value;
                },
              ),
              const Divider(
                // divider line between exercise name and sets
                color: Colors.grey,
                height: 16,
              ),
              ListView.builder(
                shrinkWrap:
                    true, // makes the ListView take only the space it needs
                itemCount: widget
                    .exercise.sets.length, // number of sets for the exercise
                itemBuilder: (context, index) {
                  WorkoutSet set = widget.exercise.sets[index];
                  physics:
                  NeverScrollableScrollPhysics(); // disables scrolling for the inner ListView

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical:
                            3), //wraped inside a padding for spaces between sets
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            "${index + 1}",
                            // textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        // const SizedBox(width: 30),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            // textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction
                                .done, // adds "done" button to keyboard
                            onSubmitted: (_) {
                              FocusScope.of(context).unfocus();
                            },
                            style: const TextStyle(
                                color: Color(0xFFD4AF37),
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              hintText: "Reps",
                              // suffixText: 'Reps',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              set.reps = int.tryParse(value) ?? 0;
                            },
                          ),
                        ),
                        // const SizedBox(width: 30),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: TextField(
                              // textAlign: TextAlign.center,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) {
                                FocusScope.of(context).unfocus();
                              },
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 6),
                                filled: true,
                                fillColor: Colors.grey,
                                labelText: "Weight",
                                labelStyle: const TextStyle(
                                  color: Color(
                                      0xFFD4AF37), // label color when idle
                                ),
                                suffixText: 'KG',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(
                                        0xFFD4AF37), // border when not selected
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // border when user taps field for the field text
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFD4AF37),
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                set.weight = double.tryParse(value) ?? 0;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          // delete button for the set, only shows for the last set and if there are more than 2 sets
                          flex: 1,
                          child: index == widget.exercise.sets.length - 1 &&
                                  widget.exercise.sets.length > 2
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Color(0xFFD4AF37),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.exercise.sets.removeLast();
                                    });
                                  },
                                )
                              : const SizedBox(),
                        )
                      ],
                    ),
                  );
                },
              ), // ListView.builder for sets
              Container(
                margin: const EdgeInsets.only(top: 0),
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      widget.exercise.sets.add(WorkoutSet());
                    });
                  },
                  icon: const Icon(Icons.add, color: Color(0xFFD4AF37)),
                  label: const Text(
                    "Add Set",
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
