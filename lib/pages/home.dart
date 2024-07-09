import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/models/quizz_model.dart';
import 'package:interro/pages/quizz/components/quizz_block.dart';
import 'package:interro/pages/quizz/create_quizz.dart';
import 'package:interro/pages/settings/components/quizzes_test.dart';
import 'package:interro/widgets/search_field.dart';
import 'package:stroke_text/stroke_text.dart';

/// Page d'accueil
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  /// liste des quizz
  late CollectionReference quizzes;
  late List<Quizz> quizzesTest2;

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
    quizzes = FirebaseFirestore.instance.collection("quizzes");
    quizzesTest2 = quizzesTest;
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    super.dispose();
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10),
                itemCount: quizzesTest2.length,
                itemBuilder: (context, index) {
                  final quizz = quizzesTest2[index];
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
