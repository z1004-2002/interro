import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/models/quizz_model.dart';
import 'package:interro/pages/quizz/details_quizz.dart';

class QuizzBlock extends StatelessWidget {
  final Quizz? quizz;

  const QuizzBlock({
    super.key,
    this.quizz,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailsQuizzScreen(quizz: quizz!),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: const BoxDecoration(
              color: thirdColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quizz!.name!,
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                      Text(
                        quizz!.description!,
                        style: const TextStyle(
                          color: primaryColor,
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${quizz!.questions!.length} questions"),
                    const Text("12 min"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}
