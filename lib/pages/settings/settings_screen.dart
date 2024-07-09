import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/pages/auth/login.dart';
import 'package:interro/services/google_auth.dart';
import 'package:interro/widgets/my_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> userInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isAuthenticated = prefs.getBool('isAuthenticated');
    // bool? isAuthenticated = prefs.getBool('isAuthenticated');
    // bool? isAuthenticated = prefs.getBool('isAuthenticated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: myAppBar(
        title: 'Paramètres',
        implyLeading: false,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("isAuthenticated", false);
                await FirebaseServices().googleSignOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LogIn(),
                  ),
                );
              },
              child: Text("Déconnexion"),
            ),
          ],
        ),
      ),
    );
  }
}
