import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/exercise.dart';
import '../../providers/workout_provider.dart';
import '../../Models/workout.dart';
import '../create_workout_screen.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  static const Color gold = Color(0xFFD4AF37);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color background = Color(0xFF050505);
  static const Color card = Color(0xFF111111);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WorkoutProvider>();
    final workouts = provider.workouts;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),
          SliverToBoxAdapter(
            child: _buildHeroCard(workouts.length),
          ),
          SliverToBoxAdapter(
            child: _buildSectionHeader(
              'QUICK ACTIONS',
              'Get straight into your training',
            ),
          ),
          SliverToBoxAdapter(
            child: _buildQuickActions(context),
          ),
          SliverToBoxAdapter(
            child: _buildSectionHeader(
              'YOUR PROGRAMS',
              'Your saved workout plans',
            ),
          ),
          SliverToBoxAdapter(
            child: _buildPrograms(context, workouts),
          ),
          SliverToBoxAdapter(
            child: _buildSectionHeader(
              'TRAINING SNAPSHOT',
              'A look at your current programs',
            ),
          ),
          SliverToBoxAdapter(
            child: _buildSnapshot(workouts),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 110),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    final hour = DateTime.now().hour;

    String greeting;

    if (hour < 12) {
      greeting = 'GOOD MORNING';
    } else if (hour < 18) {
      greeting = 'GOOD AFTERNOON';
    } else {
      greeting = 'GOOD EVENING';
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: TextStyle(
                    color: gold.withOpacity(.8),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Ready to train?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Build strength. Stay consistent.',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  gold.withOpacity(.25),
                  gold.withOpacity(.05),
                ],
              ),
              border: Border.all(
                color: gold.withOpacity(.35),
              ),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: gold,
              size: 21,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // HERO
  // =========================================================

  Widget _buildHeroCard(int workoutCount) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF242017),
            Color(0xFF101010),
            Color(0xFF080808),
          ],
        ),
        border: Border.all(
          color: gold.withOpacity(.22),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.7),
            blurRadius: 25,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -50,
            top: -65,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: gold.withOpacity(.06),
                  width: 25,
                ),
              ),
            ),
          ),

          Positioned(
            right: 20,
            bottom: -90,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: gold.withOpacity(.035),
                  width: 18,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: gold,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'YOUR TRAINING',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.5),
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.7,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$workoutCount',
                      style: const TextStyle(
                        color: gold,
                        fontSize: 54,
                        height: .9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -2,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text(
                        'WORKOUTS\nCREATED',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 9,
                          height: 1.35,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    _heroTag(
                      Icons.fitness_center_rounded,
                      'TRAIN',
                    ),
                    const SizedBox(width: 8),
                    _heroTag(
                      Icons.trending_up_rounded,
                      'PROGRESS',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroTag(
    IconData icon,
    String text,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: gold,
            size: 12,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 8,
              fontWeight: FontWeight.w700,
              letterSpacing: .8,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SECTION HEADER
  // =========================================================

  Widget _buildSectionHeader(
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // QUICK ACTIONS
  // =========================================================

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      child: Row(
        children: [
          Expanded(
            child: _actionCard(
              context: context,
              icon: Icons.add_rounded,
              title: 'New Workout',
              subtitle: 'Create program',
              primary: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateWorkoutScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _actionCard(
              context: context,
              icon: Icons.play_arrow_rounded,
              title: 'Start',
              subtitle: 'Begin training',
              primary: false,
              onTap: () {
                // We'll connect this to StartWorkoutScreen later.
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool primary,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          height: 125,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            gradient: primary
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      gold.withOpacity(.20),
                      gold.withOpacity(.04),
                    ],
                  )
                : const LinearGradient(
                    colors: [
                      Color(0xFF151515),
                      Color(0xFF101010),
                    ],
                  ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: primary
                  ? gold.withOpacity(.25)
                  : Colors.white.withOpacity(.07),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: primary
                      ? gold.withOpacity(.15)
                      : Colors.white.withOpacity(.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: primary ? gold : Colors.white70,
                  size: 21,
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // PROGRAMS
  // =========================================================

  Widget _buildPrograms(
    BuildContext context,
    List<Workout> workouts,
  ) {
    if (workouts.isEmpty) {
      return _emptyPrograms(context);
    }

    return Column(
      children: [
        for (int i = 0; i < workouts.length && i < 4; i++)
          _workoutCard(
            workouts[i],
            i,
          ),
        if (workouts.length > 4)
          Padding(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 28,
            ),
            child: TextButton(
              onPressed: () {
                // Later connect this to MyWorkoutScreen.
              },
              child: const Text(
                'VIEW ALL WORKOUTS',
                style: TextStyle(
                  color: gold,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          )
        else
          const SizedBox(height: 28),
      ],
    );
  }

  Widget _workoutCard(
    Workout workout,
    int index,
  ) {
    final exerciseCount = workout.exercises.length;

    final setCount = workout.exercises.fold<int>(
      0,
      (int sum, Exercise exercise) => sum + exercise.sets.length,
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: Row(
        children: [
          // Number
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  gold.withOpacity(.18),
                  gold.withOpacity(.04),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                '${index + 1}'.padLeft(2, '0'),
                style: const TextStyle(
                  color: gold,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '$exerciseCount exercises',
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 9,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 7,
                      ),
                      width: 3,
                      height: 3,
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      '$setCount sets',
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.04),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white38,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyPrograms(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      padding: const EdgeInsets.all(23),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: gold.withOpacity(.12),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: gold.withOpacity(.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.fitness_center_rounded,
              color: gold,
              size: 23,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Your training starts here',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Create your first workout program and build your training routine.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white38,
              fontSize: 10,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateWorkoutScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: gold,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                '+ CREATE WORKOUT',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: .8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SNAPSHOT
  // =========================================================

  Widget _buildSnapshot(List<Workout> workouts) {
    if (workouts.isEmpty) {
      return Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 28),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(22),
        ),
        child: const Text(
          'Your training statistics will appear here as you build your programs.',
          style: TextStyle(
            color: Colors.white38,
            fontSize: 11,
          ),
        ),
      );
    }

    int exercises = 0;
    int sets = 0;

    for (final workout in workouts) {
      exercises += workout.exercises.length;

      for (final exercise in workout.exercises) {
        sets += exercise.sets.length;
      }
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _snapshotItem(
              Icons.fitness_center_rounded,
              '$exercises',
              'EXERCISES',
            ),
          ),
          _verticalDivider(),
          Expanded(
            child: _snapshotItem(
              Icons.layers_rounded,
              '$sets',
              'SETS',
            ),
          ),
          _verticalDivider(),
          Expanded(
            child: _snapshotItem(
              Icons.auto_graph_rounded,
              '${workouts.length}',
              'PROGRAMS',
            ),
          ),
        ],
      ),
    );
  }

  Widget _snapshotItem(
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: gold,
          size: 17,
        ),
        const SizedBox(height: 9),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 7,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 55,
      color: Colors.white.withOpacity(.07),
    );
  }
}






// import 'package:flutter/material.dart';

// import '../../Models/workout.dart';
// import '../create_workout_screen.dart';
// import '../../Widgets/create_workout_button.dart';

// class HomeBody extends StatefulWidget {
//   const HomeBody({
//     super.key,
//     required this.size,
//   });

//   final Size size;

//   @override
//   State<HomeBody> createState() => _HomeBodyState();
// }

// class _HomeBodyState extends State<HomeBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // 👑 FULL SCREEN GRADIENT BACKGROUND
//         Positioned.fill(
//           child: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 stops: [0.0, 0.3, 0.6, 1.0],
//                 colors: [
//                   Color(0xFF000000),
//                   Color(0xFF1C1C1C),
//                   Color(0xFF2E2E2E),
//                   Color(0xFFB8860B),
//                 ],
//               ),
//             ),
//           ),
//         ),

//         // 📸 CONTENT ABOVE THE GRADIENT
//         Column(
//           children: [
//             SizedBox(
//               height: 0.41 * widget.size.height,
//               width: widget.size.width,
//               child: Stack(
//                 children: [
//                   Positioned.fill(
//                     child: Image.asset(
//                       'asset/images/ex_1.jpg',
//                       fit: BoxFit.cover,
//                     ),
//                   ),

//                   // Bottom fade over image
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     height: 50,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                             Colors.transparent,
//                             Color(0xFF2E2E2E),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10),
//             premiumButton(),
//             // Column( // diplaying workout name after saving
//             //   children: workouts.map((workout) {
//             //     return Text(workout.name);
//             //   }).toList(),
//             // )
//           ],
//         ),
//       ],
//     );
//   }
// }
