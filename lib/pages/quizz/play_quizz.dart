import 'package:flutter/material.dart';
import 'package:interro/pages/quizz/components/answer_choices.dart';
import 'package:interro/widgets/default_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/models/quizz_model.dart';
import 'package:interro/pages/quizz/components/stop_quizz_dialog.dart';
import 'package:interro/widgets/circular_timer.dart';
import 'package:interro/widgets/play_app_bar.dart';

class PlayQuizzScreen extends StatefulWidget {
  final Quizz quizz;

  const PlayQuizzScreen({super.key, required this.quizz});

  @override
  State<PlayQuizzScreen> createState() => _PlayQuizzScreenState();
}

class _PlayQuizzScreenState extends State<PlayQuizzScreen> {
  /// le quiz est en cours ?
  bool gameInProgress = true;

  /// Index de la question actuelle à afficher
  int currentIndex = 0;

  /// score du joueur
  int userScore = 0;

  // timer
  final GlobalKey<CircularTimerState> _timerKey =
      GlobalKey<CircularTimerState>();

  /// vérifie la réponse du joueur
  void checkAnswer() {
    // Arrête le timer
    _timerKey.currentState?.stopTimer();
    setState(() {});
  }

  /// Passe à la question suivante
  void goToNextQuestion() {}

  @override
  Widget build(BuildContext context) {
    /// nombre de questions du quizz
    int maxQuestions = widget.quizz.questions!.length;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => stopQuizzDialog(context),
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: playAppBar(
          title: 'Question ${currentIndex + 1}',
          context: context,
          onTap: () {
            String inviteMessage =
                "Salut ! J'utilise cette superbe application Interro";
            Share.share(inviteMessage);
          },
        ),
        bottomSheet: Container(
          color: primaryColor,
          padding: bottomSheetPadding,
          child: DefaultButton(
            text: "Valider",
            press: () {},
          ),
        ),
        body: SingleChildScrollView(
          padding: bodyPadding,
          child: Column(
            children: [
              // score timining vies
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // score
                  Text(
                    "Note : $userScore / $maxQuestions",
                    style: const TextStyle(fontSize: 17),
                  ),
                  // timing
                  CircularTimer(
                    key: _timerKey,
                    durationSeconds: 120,
                    onTimerFinish: () {
                      setState(() {
                        checkAnswer();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // intitulé de la question
              Container(
                width: 326,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: primaryColor,
                  border: Border.all(color: secondColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.quizz.questions![currentIndex].title!,
                  style: const TextStyle(
                    color: secondColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),
              // choix de réponses
              AnswersChoices(
                choices: ['Paris', 'London', 'Berlin', 'Madrid'],
                onChanged: (value) {
                  print('Selected choice: $value');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
