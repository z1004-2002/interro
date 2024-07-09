import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';

class AnswersChoices extends StatefulWidget {
  final List<String> choices;
  final ValueChanged<String?> onChanged;
  final Map<String, Color> choiceColors;
  final bool isAnswerChecked;
  final String correctAnswer;
  final String? selectedChoice;

  const AnswersChoices({
    super.key,
    required this.choices,
    required this.onChanged,
    required this.choiceColors,
    required this.isAnswerChecked,
    required this.correctAnswer,
    this.selectedChoice,
  });

  @override
  State<AnswersChoices> createState() => AnswersChoicesState();
}

class AnswersChoicesState extends State<AnswersChoices> {
  late List<String> shuffledChoices;

  @override
  void initState() {
    super.initState();
    shuffledChoices = List.from(widget.choices)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: shuffledChoices.map((choice) {
          return RadioListTile(
            title: Text(
              choice,
              style: TextStyle(
                color: widget.isAnswerChecked
                    ? (choice == widget.selectedChoice
                        ? (choice == widget.correctAnswer
                            ? successColor
                            : failColor)
                        : (choice == widget.correctAnswer
                            ? successColor
                            : null))
                    : null,
              ),
            ),
            value: choice,
            groupValue: widget.selectedChoice,
            onChanged: widget.isAnswerChecked
                ? null
                : (String? value) {
                    widget.onChanged(value);
                  },
            activeColor: widget.isAnswerChecked
                ? (choice == widget.correctAnswer ? successColor : failColor)
                : null,
          );
        }).toList(),
      ),
    );
  }
}
