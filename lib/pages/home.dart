import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/models/quizz_model.dart';
import 'package:interro/pages/quizz/components/quizz_block.dart';
import 'package:interro/pages/quizz/create_quizz.dart';
import 'package:interro/pages/settings/components/quizzes.dart';
import 'package:interro/widgets/search_field.dart';
import 'package:stroke_text/stroke_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  void _performSearch() {
    setState(() {
      _searchText = _searchController.text;
    });
  }

  bool _isQuizzMatchingSearch(Quizz quizz) {
    final searchLowerCase = _searchText.toLowerCase();
    final quizzFullName =
        "${quizz.name ?? ''} ${quizz.description ?? ''}".toLowerCase();
    return quizzFullName.contains(searchLowerCase);
  }

  /// liste des quizz
  late CollectionReference quizzes;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_performSearch);
    quizzes = FirebaseFirestore.instance.collection("quizzes");
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    super.dispose();
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
        padding: const EdgeInsets.only(top: 40),
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
                itemCount: quizzesTest.length,
                itemBuilder: (context, index) {
                  final quizz = quizzesTest[index];
                  if (_isQuizzMatchingSearch(quizz)) {
                    return Material(
                      child: ListTile(
                        title: Text(
                          quizz.name ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(quizz.description ?? ''),
                      ),
                    );
                  } else {
                    return const Text("Aucun quizz trouvé");
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
