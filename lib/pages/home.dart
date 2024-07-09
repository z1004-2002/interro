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
  late CollectionReference quizzes;

  @override
  void initState() {
    quizzes = FirebaseFirestore.instance.collection("quizzes");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 40,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateQuizz(),
            ),
          );
        },
        tooltip: 'Créer un nouveau quiz',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
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
                      color: Color.fromARGB(255, 7, 5, 136),
                      fontFamily: "CadhoToys",
                    ),
                    strokeColor: Colors.lightBlue,
                    strokeWidth: 5,
                  ),
                  StrokeText(
                    text: "INTERRO",
                    textStyle: TextStyle(
                      fontSize: 70,
                      color: Color.fromARGB(255, 7, 5, 136),
                      fontFamily: "CadhoToys",
                    ),
                    strokeColor: Colors.lightBlue,
                    strokeWidth: 5,
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: quizzes.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnap) {
                  if (streamSnap.hasError) {
                    return Center(child: Text('Erreur: ${streamSnap.error}'));
                  }

                  if (streamSnap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  ///final quizDocument = data.docs[0];
                  //print(quizDocument.data());

                  return ListView.builder(
                    itemCount: streamSnap.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnap.data!.docs[index];
                      final quizDocument = documentSnapshot.data();
                      return Material(
                        child: ListTile(
                          title: Text(
                            quizDocument.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
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
          ],
        ),
      ),
    );
  }
}
