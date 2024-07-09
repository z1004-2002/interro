import 'package:flutter/material.dart';
import 'package:interro/models/question_model.dart';
import 'package:interro/pages/quizz/components/answer_choices.dart';
import 'package:interro/pages/quizz/results_quizz.dart';
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

  /// texte du boouton de soumission
  String buttonText = 'Valider';

  /// liste de propositions
  List<String> propositions = [];

  /// réponse de l'utilisateur
  late String userAnswer = '';

  bool isAnswerChecked = false;

  /// Texte à afficher pour le résultat
  String correctAnswerText = '';

  // timing
  int timing = 10;

  /// note du joueur
  int userNote = 0;

  // temps de jeu du quizz
  late DateTime startedAt;
  late DateTime endedAt;

  // timer
  final GlobalKey<CircularTimerState> _timerKey =
      GlobalKey<CircularTimerState>();

  @override
  void initState() {
    super.initState();
    startedAt = DateTime.now();
  }

  /// vérifie la réponse du joueur
  void checkAnswer() {
    // Arrête le timer
    _timerKey.currentState?.stopTimer();

    List<Question>? questions = widget.quizz.questions;

    String goodAnswer = questions![currentIndex].answer!;
    bool isCorrect = userAnswer == goodAnswer;

    setState(() {
      isAnswerChecked = true;
      if (isCorrect) {
        correctAnswerText = isCorrect ? '✅ : $goodAnswer' : '❌ : $goodAnswer';
        userNote++;
      } else {}
      buttonText = 'Suivant';
    });

    if (currentIndex >= questions.length - 1) {
      gameInProgress = false;
      buttonText = 'Afficher les résultats';
      endedAt = DateTime.now();
    }
  }

  /// Passe à la question suivante
  void goToNextQuestion() {
    List<Question>? questions = widget.quizz.questions;

    if (currentIndex < questions!.length - 1) {
      setState(() {
        currentIndex++;
        correctAnswerText = '';
        buttonText = 'Valider';

        isAnswerChecked = false;
      });
      _timerKey.currentState?.startTimer();
    } else {
      // Si c'est la dernière question, on arrete le timer et le jeu
      _timerKey.currentState?.stopTimer();
      setState(() {
        gameInProgress = false;
        buttonText = 'Afficher les résultats';
        endedAt = DateTime.now();
      });
    }
  }

  /// afficher les résultats du quizz
  void displayResults() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultsQuizz(quizz: widget.quizz),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// nombre de questions du quizz
    int maxQuestions = widget.quizz.questions!.length;

    List<String> propositions =
        widget.quizz.questions![currentIndex].getPropositions;

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
            text: buttonText,
            press: () => gameInProgress
                ? correctAnswerText.isEmpty
                    ? checkAnswer()
                    : goToNextQuestion()
                : displayResults(),
          ),
        ),
        body: SingleChildScrollView(
          padding: bodyPadding,
          child: Column(
            children: [
              // note timining
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // note
                  Text(
                    "Note : $userNote / $maxQuestions",
                    style: const TextStyle(fontSize: 17),
                  ),
                  // timing
                  CircularTimer(
                    key: _timerKey,
                    durationSeconds: timing,
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
                key: ValueKey(currentIndex),
                choices: propositions,
                onChanged: (value) {
                  setState(() {
                    userAnswer = value!;
                  });
                },
                choiceColors: {
                  propositions[0]: successColor,
                  propositions[1]: failColor,
                  propositions[2]: failColor,
                  propositions[3]: failColor,
                },
                isAnswerChecked: isAnswerChecked,
                correctAnswer: widget.quizz.questions![currentIndex].answer!,
                selectedChoice: userAnswer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
