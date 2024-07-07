import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateQuizz extends StatefulWidget {
  const CreateQuizz({super.key});

  @override
  _CreateQuizz createState() => _CreateQuizz();
}

class _CreateQuizz extends State<CreateQuizz> {
  final _formKey = GlobalKey<FormState>();
  final _quizzController = TextEditingController();
  final _res1Controller = TextEditingController();
  final _res2Controller = TextEditingController();
  final _res3Controller = TextEditingController();
  final _res4Controller = TextEditingController();
  final _responseController = TextEditingController();

  void _saveQuiz() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('quizzes').add({
        'quizz': _quizzController.text,
        'res1': _res1Controller.text,
        'res2': _res2Controller.text,
        'res3': _res3Controller.text,
        'res4': _res4Controller.text,
        'response': _responseController.text,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un nouveau quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _quizzController,
                decoration: const InputDecoration(labelText: 'Question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une question';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _res1Controller,
                decoration: const InputDecoration(labelText: 'Proposition 1'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la proposition 1';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _res2Controller,
                decoration: const InputDecoration(labelText: 'Proposition 2'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la proposition 2';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _res3Controller,
                decoration: const InputDecoration(labelText: 'Proposition 3'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la proposition 3';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _res4Controller,
                decoration: const InputDecoration(labelText: 'Proposition 4'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la proposition 4';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _responseController,
                decoration: const InputDecoration(labelText: 'Bonne réponse'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la bonne réponse';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _saveQuiz,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
