import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/models/quizz_model.dart';
import 'package:interro/pages/quizz/play_quizz.dart';
import 'package:interro/widgets/default_button.dart';
import 'package:interro/widgets/my_app_bar.dart';
import 'package:interro/widgets/row_title.dart';

class DetailsQuizzScreen extends StatefulWidget {
  final Quizz quizz;

  const DetailsQuizzScreen({super.key, required this.quizz});

  @override
  State<DetailsQuizzScreen> createState() => _DetailsQuizzScreenState();
}

class _DetailsQuizzScreenState extends State<DetailsQuizzScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: myAppBar(
        title: 'Quizz',
        implyLeading: true,
        context: context,
      ),
      bottomSheet: Container(
        color: primaryColor,
        padding: bottomSheetPadding,
        child: DefaultButton(
          text: "Passer le quizz",
          press: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlayQuizzScreen(quizz: widget.quizz),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RowTitle(
              title: "Nom",
              subTitle: widget.quizz.name,
            ),
            const SizedBox(
              height: 20,
            ),
            RowTitle(
              title: "Description",
              subTitle: widget.quizz.description,
            ),
            const SizedBox(
              height: 20,
            ),
            RowTitle(
              title: "Nombre de questions",
              subTitle: "${widget.quizz.questions!.length}",
            ),
            const SizedBox(
              height: 20,
            ),
            RowTitle(
              title: "Créé par",
              subTitle: "${widget.quizz.name}",
            ),
            const SizedBox(
              height: 20,
            ),
            RowTitle(
              title: "Créé le",
              subTitle: "${widget.quizz.createdAt}",
            ),
            const SizedBox(
              height: 20,
            ),
            RowTitle(
              title: "Mis à jour le",
              subTitle: "${widget.quizz.updatedAt}",
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
