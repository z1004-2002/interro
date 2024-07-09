import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/models/quizz_model.dart';
import 'package:interro/models/theme_model.dart';
import 'package:interro/pages/quizz/add_questions.dart';
import 'package:interro/widgets/default_button.dart';

/// Ecran pour créer un quizz
class CreateQuizz extends StatefulWidget {
  const CreateQuizz({super.key});

  @override
  State<CreateQuizz> createState() => _CreateQuizz();
}

class _CreateQuizz extends State<CreateQuizz> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _themeController = TextEditingController();

  String? _selectedTheme;
  List<String> _themes = [];

  @override
  void initState() {
    super.initState();
    _fetchThemes();
  }

  /// charger les thèmes existants
  Future<void> _fetchThemes() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('quizzes').get();

      List<String> fetchedThemes = [];
      for (var doc in querySnapshot.docs) {
        var themeData = doc['theme'];
        if (themeData != null && themeData is Map<String, dynamic>) {
          String? themeName = themeData['name'] as String?;
          if (themeName != null && !fetchedThemes.contains(themeName)) {
            fetchedThemes.add(themeName);
          }
        }
      }

      setState(() {
        _themes = fetchedThemes;
      });
    } catch (e) {
      print('Erreur lors de la récupération des thèmes: $e');
    }
  }

  void _saveQuiz() {
    if (_formKey.currentState!.validate()) {
      Quizz newQuizz = Quizz(
        name: _nameController.text,
        description: _descriptionController.text,
        theme: ThemeModel(
          name: _themeController.text != ''
              ? _themeController.text
              : _selectedTheme,
        ),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        questions: [],
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AddQuestions(newQuizz: newQuizz),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un nouveau quiz'),
      ),
      bottomSheet: Container(
        color: primaryColor,
        padding: bottomSheetPadding,
        child: DefaultButton(
          text: "Suivant",
          press: () {
            _saveQuiz();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom du quizz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Thème'),
                value: _selectedTheme,
                items: _themes.map((String theme) {
                  return DropdownMenuItem(
                    value: theme,
                    child: Text(theme),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedTheme = value;
                    _themeController.text = value ?? '';
                  });
                },
              ),
              TextFormField(
                controller: _themeController,
                decoration: const InputDecoration(labelText: 'Nouveau thème'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un thème';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
