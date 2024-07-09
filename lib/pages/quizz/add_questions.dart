import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/models/question_model.dart';
import 'package:interro/models/quizz_model.dart';
import 'package:interro/widgets/default_button_3.dart';
import 'package:interro/widgets/show_snack_bar.dart';

/// Ecran pour créer un quizz
class AddQuestions extends StatefulWidget {
  final Quizz newQuizz;

  const AddQuestions({super.key, required this.newQuizz});

  @override
  State<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _answerController = TextEditingController();
  final _prop2Controller = TextEditingController();
  final _prop3Controller = TextEditingController();
  final _prop4Controller = TextEditingController();

  List<Map<String, String>> questions = [];
  int currentQuestionIndex = 0;

  void _saveCurrentQuestion() {
    if (_formKey.currentState!.validate()) {
      final question = {
        'title': _titleController.text,
        'answer': _answerController.text,
        'prop2': _prop2Controller.text,
        'prop3': _prop3Controller.text,
        'prop4': _prop4Controller.text,
      };

      if (currentQuestionIndex < questions.length) {
        questions[currentQuestionIndex] = question;
      } else {
        questions.add(question);
      }
    }
  }

  void _addNewQuestion() {
    _saveCurrentQuestion();
    setState(() {
      _titleController.clear();
      _answerController.clear();
      _prop2Controller.clear();
      _prop3Controller.clear();
      _prop4Controller.clear();
      currentQuestionIndex = questions.length;
    });
  }

  void _goToPreviousQuestion() {
    _saveCurrentQuestion();
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        _loadQuestion(questions[currentQuestionIndex]);
      });
    }
  }

  void _loadQuestion(Map<String, String> question) {
    _titleController.text = question['title']!;
    _answerController.text = question['answer']!;
    _prop2Controller.text = question['prop2']!;
    _prop3Controller.text = question['prop3']!;
    _prop4Controller.text = question['prop4']!;
  }

  Future<void> _finishAddingQuestions() async {
    _saveCurrentQuestion();
    try {
      // Créer une nouvelle instance de Quizz avec les questions ajoutées
      Quizz completeQuizz = Quizz(
        id: widget.newQuizz.id,
        name: widget.newQuizz.name,
        description: widget.newQuizz.description,
        theme: widget.newQuizz.theme,
        image: widget.newQuizz.image,
        questions: questions.map((questionData) {
          return Question.fromJson(questionData);
        }).toList(),
        creator: widget.newQuizz.creator,
        createdAt: widget.newQuizz.createdAt,
        updatedAt: widget.newQuizz.updatedAt,
      );

      // Enregistrer le quiz et ses questions dans Firestore
      CollectionReference quizzesRef =
          FirebaseFirestore.instance.collection('quizzes');
      DocumentReference newDocQuizzRef =
          await quizzesRef.add(completeQuizz.toJson());

      for (final question in questions) {
        await newDocQuizzRef.collection('questions').add(question);
      }

      Navigator.of(context).pop();
      showSnackBar(context, "Quiz et questions ajoutés avec succès");
    } catch (e) {
      print('Erreur lors de l\'ajout des questions: $e');
      showSnackBar(context, "Erreur lors de l'ajout des questions");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter des questions'),
      ),
      bottomSheet: Container(
        color: primaryColor,
        padding: bottomSheetPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentQuestionIndex > 0)
              DefaultButton3(
                text: "Précédent",
                press: _goToPreviousQuestion,
              ),
            DefaultButton3(
              text: "Ajouter une question",
              press: _addNewQuestion,
            ),
            DefaultButton3(
              text: "Terminer",
              press: _finishAddingQuestions,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une question';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _answerController,
                decoration: const InputDecoration(labelText: 'Bonne réponse'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la bonne réponse';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _prop2Controller,
                decoration: const InputDecoration(labelText: 'Proposition 2'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la proposition 2';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _prop3Controller,
                decoration: const InputDecoration(labelText: 'Proposition 3'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la proposition 3';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _prop4Controller,
                decoration: const InputDecoration(labelText: 'Proposition 4'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la proposition 4';
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
