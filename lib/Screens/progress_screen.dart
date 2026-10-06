import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_provider.dart';
import '../Models/workout.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  static const Color gold = Color(0xFFD4AF37);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color background = Color(0xFF050505);
  static const Color card = Color(0xFF111111);
  static const Color cardLight = Color(0xFF181818);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WorkoutProvider>();
    final workouts = provider.workouts;

    final totalWorkouts = workouts.length;

    final totalExercises = workouts.fold<int>(
      0,
      (total, workout) => total + workout.exercises.length,
    );

    final totalSets = workouts.fold<int>(
      0,
      (total, workout) {
        return total +
            workout.exercises.fold<int>(
              0,
              (exerciseTotal, exercise) => exerciseTotal + exercise.sets.length,
            );
      },
    );

    final totalVolume = workouts.fold<double>(
      0,
      (total, workout) {
        return total +
            workout.exercises.fold<double>(
              0,
              (exerciseTotal, exercise) {
                return exerciseTotal +
                    exercise.sets.fold<double>(
                      0,
                      (setTotal, set) => setTotal + (set.reps * set.weight),
                    );
              },
            );
      },
    );

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(totalWorkouts),
            ),
            SliverToBoxAdapter(
              child: _buildHeroCard(
                totalVolume,
                totalSets,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                'TRAINING OVERVIEW',
                'Your training at a glance',
              ),
            ),
            SliverToBoxAdapter(
              child: _buildStatisticsGrid(
                totalWorkouts,
                totalExercises,
                totalSets,
                totalVolume,
              ),
            ),
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                'WORKOUT DISTRIBUTION',
                'How your training is structured',
              ),
            ),
            SliverToBoxAdapter(
              child: _buildWorkoutDistribution(workouts),
            ),
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                'YOUR EXERCISES',
                'Exercises inside your programs',
              ),
            ),
            SliverToBoxAdapter(
              child: _buildExerciseCollection(workouts),
            ),
            SliverToBoxAdapter(
              child: _buildSectionTitle(
                'RECENT WORKOUTS',
                'Your training programs',
              ),
            ),
            SliverToBoxAdapter(
              child: _buildRecentWorkouts(workouts),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 110),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // HEADER
  // ─────────────────────────────────────────────

  Widget _buildHeader(int totalWorkouts) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
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
                      'YOUR JOURNEY',
                      style: TextStyle(
                        color: gold.withOpacity(.8),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Progress',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -.8,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: gold.withOpacity(.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: gold.withOpacity(.25),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.bolt_rounded,
                  color: gold,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text(
                  '$totalWorkouts workouts',
                  style: const TextStyle(
                    color: gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // HERO CARD
  // ─────────────────────────────────────────────

  Widget _buildHeroCard(
    double totalVolume,
    int totalSets,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 26),
      height: 205,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1D1D1D),
            Color(0xFF0A0A0A),
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
          Positioned(
            right: -55,
            top: -65,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: gold.withOpacity(.07),
                  width: 25,
                ),
              ),
            ),
          ),
          Positioned(
            right: 25,
            bottom: -75,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: gold.withOpacity(.04),
                  width: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL TRAINING VOLUME',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.5),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.7,
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatVolume(totalVolume),
                      style: const TextStyle(
                        color: gold,
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 7),
                      child: Text(
                        'KG',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    _heroMiniStat(
                      Icons.layers_rounded,
                      '$totalSets',
                      'SETS',
                    ),
                    const SizedBox(width: 24),
                    _heroMiniStat(
                      Icons.trending_up_rounded,
                      'ACTIVE',
                      'TRAINING',
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

  Widget _heroMiniStat(
    IconData icon,
    String value,
    String label,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: gold.withOpacity(.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: gold,
            size: 16,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // SECTION TITLE
  // ─────────────────────────────────────────────

  Widget _buildSectionTitle(
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 2, 22, 14),
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
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // STATISTICS GRID
  // ─────────────────────────────────────────────

  Widget _buildStatisticsGrid(
    int workouts,
    int exercises,
    int sets,
    double volume,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _statCard(
              icon: Icons.fitness_center_rounded,
              value: '$workouts',
              label: 'WORKOUTS',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _statCard(
              icon: Icons.accessibility_new_rounded,
              value: '$exercises',
              label: 'EXERCISES',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _statCard(
              icon: Icons.layers_rounded,
              value: '$sets',
              label: 'SETS',
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      height: 125,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: gold.withOpacity(.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: gold,
              size: 17,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 8,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // WORKOUT DISTRIBUTION
  // ─────────────────────────────────────────────

  Widget _buildWorkoutDistribution(
    List<Workout> workouts,
  ) {
    if (workouts.isEmpty) {
      return _emptyCard(
        Icons.analytics_outlined,
        'No training data yet',
        'Create your first workout to start building your progress.',
      );
    }

    final total = workouts.fold<int>(
      0,
      (sum, workout) => sum + workout.exercises.length,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < workouts.length; i++)
            Padding(
              padding: EdgeInsets.only(
                bottom: i == workouts.length - 1 ? 0 : 17,
              ),
              child: _distributionRow(
                workouts[i].name,
                workouts[i].exercises.length,
                total,
              ),
            ),
        ],
      ),
    );
  }

  Widget _distributionRow(
    String name,
    int exerciseCount,
    int total,
  ) {
    final percentage = total == 0 ? 0.0 : exerciseCount / total;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '$exerciseCount exercises',
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: 9),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Container(
                height: 6,
                color: Colors.white.withOpacity(.05),
              ),
              FractionallySizedBox(
                widthFactor: percentage,
                child: Container(
                  height: 6,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        darkGold,
                        gold,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // EXERCISE COLLECTION
  // ─────────────────────────────────────────────

  Widget _buildExerciseCollection(
    List<Workout> workouts,
  ) {
    final Map<String, int> exerciseFrequency = {};

    for (final workout in workouts) {
      for (final exercise in workout.exercises) {
        exerciseFrequency[exercise.name] =
            (exerciseFrequency[exercise.name] ?? 0) + 1;
      }
    }

    if (exerciseFrequency.isEmpty) {
      return _emptyCard(
        Icons.fitness_center_outlined,
        'No exercises yet',
        'Exercises from your workouts will appear here.',
      );
    }

    final exercises = exerciseFrequency.entries.toList()
      ..sort(
        (a, b) => b.value.compareTo(a.value),
      );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: Column(
        children: [
          for (int i = 0; i < exercises.length; i++)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              leading: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: gold.withOpacity(.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.fitness_center_rounded,
                  color: gold,
                  size: 17,
                ),
              ),
              title: Text(
                exercises[i].key,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                '${exercises[i].value} workout${exercises[i].value == 1 ? '' : 's'}',
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 10,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white24,
              ),
            ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // RECENT WORKOUTS
  // ─────────────────────────────────────────────

  Widget _buildRecentWorkouts(
    List<Workout> workouts,
  ) {
    if (workouts.isEmpty) {
      return _emptyCard(
        Icons.history_rounded,
        'Your workout history',
        'Your saved workouts will appear here.',
      );
    }

    final visibleWorkouts = workouts.reversed.take(5).toList();

    return Column(
      children: [
        for (int i = 0; i < visibleWorkouts.length; i++)
          Container(
            margin: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              i == visibleWorkouts.length - 1 ? 0 : 10,
            ),
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(.05),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        gold.withOpacity(.22),
                        gold.withOpacity(.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.fitness_center_rounded,
                    color: gold,
                    size: 19,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        visibleWorkouts[i].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${visibleWorkouts[i].exercises.length} exercises',
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.04),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${visibleWorkouts[i].exercises.fold<int>(
                          0,
                          (sum, exercise) => sum + exercise.sets.length,
                        )} sets',
                    style: const TextStyle(
                      color: gold,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // EMPTY STATE
  // ─────────────────────────────────────────────

  Widget _emptyCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(.06),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: gold.withOpacity(.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: gold,
              size: 22,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────

  String _formatVolume(double volume) {
    if (volume >= 1000000) {
      return '${(volume / 1000000).toStringAsFixed(1)}M';
    }

    if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(1)}K';
    }

    return volume.toStringAsFixed(0);
  }
}
