import 'package:flutter/material.dart';
import 'package:interro/Services/authentication.dart';
import 'package:interro/Widget/button.dart';
import 'package:interro/Widget/snackbar.dart';
import 'package:interro/Widget/text_field.dart';
import 'package:interro/pages/login.dart';
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
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
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
      phone: phoneController.text,
      phone: phoneController.text,
      password: passwordController.text,
      name: nameController.text,
    );
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LogIn(),
        ),
      );
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
      //navigate to the next screen
    } else {
      setState(() {
        isLoading = false;
      });
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
          color: Colors.white,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const StrokeText(
                  text: "INTERRO",
                  textStyle: TextStyle(
                    fontSize: 70,
                    color: Color.fromARGB(255, 7, 5, 136),
                    fontFamily: "CadhoToys",
                  ),
                  strokeColor: Colors.lightBlue,
                  strokeWidth: 5,
                ),
                TextFieldInput(
                  icon: Icons.person,
                  textEditingController: nameController,
                  hintText: 'Nom',
                  textInputType: TextInputType.text,
                ),
                TextFieldInput(
                  icon: Icons.phone,
                  textEditingController: phoneController,
                  hintText: 'Numero',
                  textInputType: TextInputType.text,
                ),
                TextFieldInput(
                  icon: Icons.email,
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
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 7, 5, 136)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
