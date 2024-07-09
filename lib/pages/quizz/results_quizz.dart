import 'package:flutter/material.dart';
import 'package:interro/models/quizz_model.dart';

class ResultsQuizz extends StatefulWidget {
  final Quizz quizz;
  
  const ResultsQuizz({super.key, required this.quizz});

  @override
  State<ResultsQuizz> createState() => _ResultsQuizzState();
}

class _ResultsQuizzState extends State<ResultsQuizz> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
