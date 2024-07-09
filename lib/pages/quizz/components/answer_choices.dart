import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';

class AnswersChoices extends StatefulWidget {
  final List<String> choices;
  final Map<String, Color>? choiceColors;
  final bool answered;
  final Function(String?) onChanged;

  const AnswersChoices({
    super.key,
    required this.choices,
    this.answered = false,
    required this.onChanged,
    this.choiceColors,
  });

  @override
  State<AnswersChoices> createState() => _AnswersChoicesState();
}

class _AnswersChoicesState extends State<AnswersChoices> {
  String? _selectedChoice;
  late List<String> shuffledChoices;

  @override
  void initState() {
    super.initState();
    shuffledChoices = List.from(widget.choices)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // color: Colors.green,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: shuffledChoices.map((choice) {
          return RadioListTile(
            title: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: widget.answered
                    ? widget.choiceColors![choice]
                    : Colors.transparent,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Text(choice),
            ),
            value: choice,
            activeColor: thirdColor,
            groupValue: _selectedChoice,
            onChanged: (String? value) {
              setState(() {
                _selectedChoice = value;
              });
              widget.onChanged(value);
            },
          );
        }).toList(),
      ),
    );
  }
}
