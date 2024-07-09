import 'package:flutter/material.dart';
import 'package:interro/constants/constants.dart';
import 'package:interro/widgets/my_app_bar.dart';

class MyQuizzScreen extends StatefulWidget {
  const MyQuizzScreen({super.key});

  @override
  State<MyQuizzScreen> createState() => _MyQuizzScreenState();
}

class _MyQuizzScreenState extends State<MyQuizzScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: myAppBar(
        title: 'Mes quizz',
        implyLeading: false,
        context: context,
      ),
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Placeholder(),
        ]),
      ),
    );
  }
}
