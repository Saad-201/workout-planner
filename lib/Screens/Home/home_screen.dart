import 'package:flutter/material.dart';
import 'home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF050505),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: HomeBody(),
    );
  }
}
//import 'package:flutter/material.dart';
// import 'package:ios_test_fresh_37/Screens/Home/home_body.dart';
// import 'package:ios_test_fresh_37/Models/workout.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   // variables

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       extendBody:
//           true, // allows the body to extend behind the bottom navigation
//       extendBodyBehindAppBar: true,
//       appBar: homeAppBar(),
//       body: HomeBody(size: size),
//     );
//   }

//   AppBar homeAppBar() {
//     return AppBar(
//       centerTitle: false,
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: const [
//           Text(
//             "Workout Planner",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             "Stay consistent",
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
