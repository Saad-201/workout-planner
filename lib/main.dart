import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ios_test_fresh_37/Screens/Home/home_screen.dart';
import 'package:provider/provider.dart';
import 'Screens/login_screen.dart';
import 'firebase_options.dart';
import 'providers/workout_provider.dart';

import 'Screens/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); //  REQUIRED);

  runApp(
    ChangeNotifierProvider(
      create: (context) => WorkoutProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner:
          false, // for red checked banner in the simulation
      home: MainNavigation(),
      // home: HomeScreen(),
      // home: LoginScreen(),
    );
  }
}
