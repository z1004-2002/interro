import 'package:flutter/material.dart';

class AnswersChoices extends StatefulWidget {
  final List<String> choices;
  final Function(String?) onChanged;

  const AnswersChoices(
      {super.key, required this.choices, required this.onChanged});

  @override
  State<AnswersChoices> createState() => _AnswersChoicesState();
}

class _AnswersChoicesState extends State<AnswersChoices> {
  String? _selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: widget.choices.map((choice) {
          return RadioListTile(
            title: Text(choice),
            value: choice,
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
