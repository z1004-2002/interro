import 'package:flutter/material.dart';
import 'package:interro/Services/authentication.dart';
import 'package:interro/Services/google_auth.dart';
import 'package:interro/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          top: 16,
          bottom: 16,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("isAuthenticated", false);
                  await FirebaseServices().googleSignOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LogIn(),
                    ),
                  );
                },
                child: const Text('Modifier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
