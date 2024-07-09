import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interro/Services/google_auth.dart';
import 'package:interro/Widget/button.dart';
import 'package:interro/Widget/snackbar.dart';
import 'package:interro/Widget/text_field.dart';
import 'package:interro/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stroke_text/stroke_text.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late CollectionReference users;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late String phone = "";
  void initial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone')!;
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .where("phone", isEqualTo: phone)
        .get();
    nameController.text = snap.docs[0].get('name');
    emailController.text = snap.docs[0].get('email');
    phoneController.text = snap.docs[0].get('phone');
  }

  @override
  void initState() {
    initial();
    super.initState();
  }

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Column(
                  children: [
                    const StrokeText(
                      text: "Profil",
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
                    MyButtons(
                      onTap: modifier,
                      text: "Modifier",
                    ),
                    MyButtons(
                      onTap: () async {
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
                      text: "Se Deconnecter",
                    ),
                    MyButtons(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Supprimer ?'),
                              content: const Text(
                                "Voulez vous supprimer votre compte ?",
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Non"),
                                ),
                                TextButton(
                                  onPressed: supprimer,
                                  child: const Text("Oui"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      text: "Supprimer Mon compte",
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Icon(
                    //     Icons.exit_to_app,
                    //     size: 50,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void supprimer() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .where("phone", isEqualTo: phone)
        .get();
    var collection = FirebaseFirestore.instance.collection('users');
    collection
        .doc(
          snap.docs[0].get("uid"),
        )
        .delete();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isAuthenticated", false);
    await FirebaseServices().googleSignOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LogIn(),
      ),
    );
    showSnackBar(context, "Compte supprimmé");
  }

  void modifier() async {
    // set is loading to true.

    // signup user using our authmethod
    String res = await edit(
      email: emailController.text,
      newphone: phoneController.text,
      name: nameController.text,
    );
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      showSnackBar(context, res);
    } else {
      showSnackBar(context, res);
    }
  }

  Future<String> edit({
    required String email,
    required String newphone,
    required String name,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || name.isNotEmpty || newphone.isNotEmpty) {
        QuerySnapshot snap = await FirebaseFirestore.instance
            .collection('users')
            .where("phone", isEqualTo: phone)
            .get();
        if (snap.docs.isNotEmpty) {
          QuerySnapshot snap2 = await FirebaseFirestore.instance
              .collection('users')
              .where("phone", isEqualTo: newphone)
              .get();
          if (phone != newphone && snap2.docs.isNotEmpty) {
            res = "Numéro pris par un utilisateur";
          } else {
            var collection = FirebaseFirestore.instance.collection('users');
            collection
                .doc(
              snap.docs[0].get("uid"),
            )
                .update({"name": name});

            res = "success";
          }
        } else {
          return "l'utilisateur n'existe pas";
        }
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
