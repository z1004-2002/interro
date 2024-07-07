import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interro/pages/create_quizz.dart';
import 'package:stroke_text/stroke_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late CollectionReference quizz;
  @override
  void initState() {
    quizz = FirebaseFirestore.instance.collection("quizzes");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 7, 5, 136),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  StrokeText(
                    text: "Bienvenu sur",
                    textStyle: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontFamily: "CadhoToys",
                    ),
                    strokeColor: Colors.lightBlue,
                    strokeWidth: 5,
                  ),
                  StrokeText(
                    text: "INTERRO",
                    textStyle: TextStyle(
                      fontSize: 70,
                      color: Colors.white,
                      fontFamily: "CadhoToys",
                    ),
                    strokeColor: Colors.lightBlue,
                    strokeWidth: 5,
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: quizz.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnap) {
                if (streamSnap.hasData) {
                  return ListView.builder(
                    itemCount: streamSnap.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnap.data!.docs[index];
                      return Material(
                        child: ListTile(
                          title: Text(
                            documentSnapshot["theme"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text("data"),
                );
              },
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateQuiz(),
                  ),
                );
              },
              tooltip: 'Créer un nouveau quiz',
              child: const Icon(Icons.add),
            ),

            // const Text(
            //   "Congratulation\nYou have successfully Login",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            // ),
            // MyButtons(
            //   onTap: () async {
            //     SharedPreferences prefs = await SharedPreferences.getInstance();
            //     prefs.setBool("isAuthenticated", false);
            //     await FirebaseServices().googleSignOut();
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //         builder: (context) => const LogIn(),
            //       ),
            //     );
            //   },
            //   text: "Log Out",
            // ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                left: 16,
                right: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('setting');
                    },
                    child: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("out");
                    },
                    child: const Icon(
                      Icons.exit_to_app_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
