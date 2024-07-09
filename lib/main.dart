import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:interro/base.dart';
import 'package:interro/pages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isAuthenticated = prefs.getBool('isAuthenticated');

  runApp(MyApp(isAuthenticated: isAuthenticated ?? false));
}

class MyApp extends StatelessWidget {
  final bool isAuthenticated;
  const MyApp({super.key, required this.isAuthenticated});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 7, 5, 136),
        ),
        useMaterial3: true,
      ),
      home: isAuthenticated ? const Base() : const Welcome(),
    );
  }
}
