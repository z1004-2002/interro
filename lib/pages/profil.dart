import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("z"),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Modifier'),
            ),
          ],
        ),
      ),
    );
  }
}
