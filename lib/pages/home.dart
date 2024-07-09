import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/models/quizz_model.dart';
import 'package:interro/pages/quizz/components/quizz_block.dart';
import 'package:interro/pages/quizz/create_quizz.dart';
import 'package:interro/pages/quizz/components/quizzes_test.dart';
import 'package:interro/widgets/search_field.dart';
import 'package:stroke_text/stroke_text.dart';

/// Page d'accueil
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Quizz> quizzesTest2;

  /// liste des quizz
  List<Quizz> quizzes = [];
  bool isLoading = true;

  // recherche utilisateur
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  void _performSearch() {
    setState(() {
      _searchText = _searchController.text;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_performSearch);
    _fetchQuizzes();
    quizzesTest2 = quizzesTest;
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchQuizzes() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('quizzes').get();

      List<Quizz> fetchedQuizzes = querySnapshot.docs.map((doc) {
        return Quizz.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      setState(() {
        quizzes = fetchedQuizzes;
        isLoading = false;
      });
    } catch (e) {
      print('Erreur lors de la récupération des quizz: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  bool _isQuizzMatchingSearch(Quizz quizz) {
    final searchLowerCase = _searchText.toLowerCase();
    final quizzFullName =
        "${quizz.name ?? ''} ${quizz.description ?? ''}".toLowerCase();
    return quizzFullName.contains(searchLowerCase);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateQuizz(),
            ),
          );
        },
        tooltip: 'Créer un nouveau quiz',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: primaryColor,
        ),
        padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
        child: Column(
          children: [
            const Column(
              children: [
                StrokeText(
                  text: "Bienvenue sur",
                  textStyle: TextStyle(
                    fontSize: 30,
                    color: secondColor,
                    fontFamily: "CadhoToys",
                  ),
                  strokeColor: thirdColor,
                  strokeWidth: 5,
                ),
                StrokeText(
                  text: "INTERRO",
                  textStyle: TextStyle(
                    fontSize: 60,
                    color: secondColor,
                    fontFamily: "CadhoToys",
                  ),
                  strokeColor: thirdColor,
                  strokeWidth: 5,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SearchField(
                    hintText: "Rechercher un quizz ...",
                    searchController: _searchController,
                    onPressed: _performSearch,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            // Expanded(
            //   child: StreamBuilder(
            //     stream: quizzes.snapshots(),
            //     builder: (context, AsyncSnapshot<QuerySnapshot> streamSnap) {
            //       if (streamSnap.hasError) {
            //         return Center(child: Text('Erreur: ${streamSnap.error}'));
            //       }

            //       if (streamSnap.connectionState == ConnectionState.waiting) {
            //         return const Center(child: CircularProgressIndicator());
            //       }

            //       final data = streamSnap.requireData;
            //       final quizDocument = data.docs.last;
            //       print(quizDocument.data());

            //       return ListView.builder(
            //         itemCount: streamSnap.data!.docs.length,
            //         itemBuilder: (context, index) {
            //           final DocumentSnapshot documentSnapshot =
            //               streamSnap.data!.docs[index];
            //           final quizDocument =
            //               documentSnapshot.data() as Map<String, dynamic>;
            //           return Material(
            //             child: ListTile(
            //               title: Text(
            //                 quizDocument['name'] ?? "rien",
            //                 style: const TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 20,
            //                 ),
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: quizzes.length,
                      itemBuilder: (context, index) {
                        final quizz = quizzes[index];
                        if (_isQuizzMatchingSearch(quizz)) {
                          return QuizzBlock(quizz: quizz);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
