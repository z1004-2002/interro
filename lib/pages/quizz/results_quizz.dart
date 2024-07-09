import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/models/quizz_model.dart';
import 'package:interro/pages/bottom_nav/bottom_nav.dart';
import 'package:interro/widgets/default_button.dart';
import 'package:interro/widgets/my_app_bar.dart';

class ResultsQuizz extends StatefulWidget {
  final Quizz quizz;

  const ResultsQuizz({super.key, required this.quizz});

  @override
  State<ResultsQuizz> createState() => _ResultsQuizzState();
}

class _ResultsQuizzState extends State<ResultsQuizz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: myAppBar(
        title: 'Récapitulatif',
        implyLeading: true,
        context: context,
      ),
      bottomSheet: Container(
        color: primaryColor,
        padding: bottomSheetPadding,
        child: DefaultButton(
          text: "Retour à l'accueil",
          press: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const BottomNav(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: widget.quizz.questions!.map((question) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(question.title!),
                    subtitle: Text(question.answer!),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
