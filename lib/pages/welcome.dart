import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/widgets/button.dart';
import 'package:interro/pages/auth/login.dart';
import 'package:interro/pages/auth/signup.dart';
import 'package:stroke_text/stroke_text.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: secondColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const StrokeText(
                text: "INTERRO",
                textStyle: TextStyle(
                  fontSize: 70,
                  color: Colors.white,
                  fontFamily: "CadhoToys",
                ),
                strokeColor: thirdColor,
                strokeWidth: 5,
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildSection(
                      context,
                      'Créer des quiz',
                      'Avec Interro, vous pouvez créer des quiz personnalisés sur les thèmes qui vous intéressent. Ajoutez des questions et des images pour rendre vos quiz plus interactifs.',
                      Icons.create,
                    ),
                    _buildSection(
                      context,
                      'Partager des quiz',
                      'Partagez vos quiz avec d\'autres utilisateurs et testez leurs connaissances. Les quiz peuvent être utilisés dans divers contextes, comme l\'éducation ou les jeux entre amis.',
                      Icons.share,
                    ),
                    _buildSection(
                      context,
                      'Pour les enseignants',
                      'Les enseignants peuvent utiliser Interro pour donner des devoirs à leurs élèves. Les notes sont calculées automatiquement à la fin de chaque quiz, facilitant ainsi le suivi des performances.',
                      Icons.school,
                    ),
                  ],
                ),
              ),
              MyButtons(onTap: login, text: "Commencer"),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LogIn(),
      ),
    );
  }

  void signup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUp(),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, String content, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 30.0,
            ),
            const SizedBox(width: 10.0),
            Text(
              title,
              style: const TextStyle(fontSize: 30, color: primaryColor),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          content,
          style: const TextStyle(
            fontSize: 17,
            color: Color.fromARGB(255, 223, 223, 223),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
