import 'package:flutter/material.dart';
import 'package:interro/pages/bottom_nav/bottom_nav.dart';
import 'package:interro/services/authentication.dart';
import 'package:interro/widgets/button.dart';
import 'package:interro/widgets/show_snack_bar.dart';
import 'package:interro/widgets/text_field.dart';
import 'package:interro/pages/auth/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stroke_text/stroke_text.dart';

/// Ecran de connexion
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  /// email and passowrd auth part
  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    // signup user using our authmethod
    String res = await AuthMethod().loginUser(
        email: emailController.text, password: passwordController.text);

    setState(() {
      isLoading = false;
    });
    if (res == "success") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isAuthenticated", true);
      //navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNav(),
        ),
      );
    } else {
      // show error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 7, 5, 136),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StrokeText(
              text: "INTERRO",
              textStyle: TextStyle(
                fontSize: 70,
                color: Colors.white,
                fontFamily: "CadhoToys",
              ),
              strokeColor: Colors.lightBlue,
              strokeWidth: 5,
            ),
            TextFieldInput(
              icon: Icons.person,
              textEditingController: emailController,
              hintText: 'Email',
              textInputType: TextInputType.text,
            ),
            TextFieldInput(
              icon: Icons.lock,
              textEditingController: passwordController,
              hintText: 'Mot de passe',
              textInputType: TextInputType.text,
              isPass: true,
            ),
            MyButtons(onTap: loginUser, text: "Connexion"),

            // Don't have an account? got to signup screen
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    );
                  },
                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container socialIcon(image) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFedf0f8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black45,
          width: 2,
        ),
      ),
      child: Image.network(
        image,
        height: 40,
      ),
    );
  }
}
