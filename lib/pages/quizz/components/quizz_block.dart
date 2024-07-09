import 'package:flutter/material.dart';
import 'package:interro/models/quizz_model.dart';

class QuizzBlock extends StatelessWidget {
  final Quizz? quizz;

  const QuizzBlock({
    super.key,
    this.quizz,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Equations de Maxwell"),
              Text("KJdhf ejefhez ezghzeog ezkgjez hege"),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("20 questions"),
              Text("12 min"),
            ],
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
