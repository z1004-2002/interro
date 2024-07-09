import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/models/quizz_model.dart';
import 'package:interro/pages/quizz/play_quizz.dart';
import 'package:interro/widgets/default_button.dart';
import 'package:interro/widgets/my_app_bar.dart';
import 'package:interro/widgets/row_title.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DetailsQuizzScreen extends StatefulWidget {
  final Quizz quizz;

  const DetailsQuizzScreen({super.key, required this.quizz});

  @override
  State<DetailsQuizzScreen> createState() => _DetailsQuizzScreenState();
}

class _DetailsQuizzScreenState extends State<DetailsQuizzScreen> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR', null).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat("d MMMM yyyy 'à' HH'h'mm", 'fr_FR');

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
            const SizedBox(height: 20),
            RowTitle(
              title: "Description",
              subTitle: widget.quizz.description,
            ),
            const SizedBox(height: 20),
            RowTitle(
              title: "Thème",
              subTitle: widget.quizz.theme!.name,
            ),
            const SizedBox(height: 20),
            RowTitle(
              title: "Nombre de questions",
              subTitle: "${widget.quizz.questions!.length}",
            ),
            const SizedBox(height: 20),
            const RowTitle(
              title: "Timing",
              subTitle: "3 min / question",
            ),
            const SizedBox(height: 20),
            const RowTitle(
              title: "Créé par",
              subTitle: "Blanche Audrey",
            ),
            const SizedBox(height: 20),
            RowTitle(
              title: "Créé le",
              subTitle: formatter.format(widget.quizz.createdAt!),
            ),
            const SizedBox(height: 20),
            RowTitle(
              title: "Mis à jour le",
              subTitle: formatter.format(widget.quizz.updatedAt!),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
