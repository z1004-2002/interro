import 'package:flutter/material.dart';
import 'package:interro/services/authentication.dart';
import 'package:interro/widgets/button.dart';
import 'package:interro/widgets/snackbar.dart';
import 'package:interro/widgets/text_field.dart';
import 'package:interro/pages/home.dart';
import 'package:interro/pages/auth/login.dart';
import 'package:stroke_text/stroke_text.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signupUser() async {
    // set is loading to true.
    setState(() {
      isLoading = true;
    });
    // signup user using our authmethod
    String res = await AuthMethod().signupUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    setState(() {
      isLoading = false;
    });
    if (res == "success") {
      showSnackBar(context, res);
      //navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Home(),
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
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 7, 5, 136),
        ),
        child: SizedBox(
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
                  textEditingController: nameController,
                  hintText: 'Nom',
                  textInputType: TextInputType.text),
              TextFieldInput(
                  icon: Icons.email,
                  textEditingController: emailController,
                  hintText: 'Numero',
                  textInputType: TextInputType.text),
              TextFieldInput(
                icon: Icons.lock,
                textEditingController: passwordController,
                hintText: 'Mot de passe',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              MyButtons(onTap: signupUser, text: "S'enregistrer"),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Vous avez déjà un compte ?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LogIn(),
                        ),
                      );
                    },
                    child: const Text(
                      "Connexion",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
