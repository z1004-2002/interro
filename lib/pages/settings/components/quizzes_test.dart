import 'package:interro/models/question_model.dart';
import 'package:interro/models/quizz_model.dart';
import 'package:interro/models/theme_model.dart';
import 'package:interro/models/user_model.dart';

final List<Quizz> quizzesTest = [
  Quizz(
    id: 1,
    name: 'Quizz 1 zefiozef ozigf zoifhzo kjcbez fzuhu hzpgfzefz',
    description: 'Description for Quizz 1 hfoai haf oiahf azfihaf a',
    theme: ThemeModel(name: 'Science'),
    image: 'https://example.com/image1.png',
    questions: [
      Question(
        title: 'What is the chemical symbol for water?',
        answer: "H2O",
        prop2: "NaCl",
        prop3: "W2",
        prop4: "NaE3",
      ),
      Question(
        title: 'What planet is known as the Red Planet?',
        answer: "Mars",
        prop2: "Terre",
        prop3: "Jupiter",
        prop4: "Pluton",
      ),
    ],
    creator: User(email: 'User1'),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Quizz(
    id: 2,
    name: 'Quizz 2',
    description: 'Description for Quizz 2',
    theme: ThemeModel(name: 'History'),
    image: 'https://example.com/image2.png',
    questions: [
      Question(title: 'Who was the first president of the United States?'),
      Question(title: 'In what year did the Titanic sink?'),
    ],
    creator: User(email: 'User2'),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Quizz(
    id: 3,
    name: 'Quizz 3',
    description: 'Description for Quizz 3',
    theme: ThemeModel(name: 'Geography'),
    image: 'https://example.com/image3.png',
    questions: [
      Question(title: 'What is the capital of France?'),
      Question(title: 'Which river is the longest in the world?'),
      Question(title: 'Which sea is the longest in the world?'),
    ],
    creator: User(email: 'User3'),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Quizz(
    id: 4,
    name: 'Quizz 4',
    description: 'Description for Quizz 4',
    theme: ThemeModel(name: 'Mathematics'),
    image: 'https://example.com/image4.png',
    questions: [
      Question(title: 'What is 2+2?'),
      Question(title: 'What is the square root of 16?'),
    ],
    creator: User(email: 'User4'),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Quizz(
    id: 5,
    name: 'Quizz 5',
    description: 'Description for Quizz 5',
    theme: ThemeModel(name: 'Literature'),
    image: 'https://example.com/image5.png',
    questions: [
      Question(title: 'Who wrote "1984"?'),
      Question(title: 'What is the title of the first Harry Potter book?'),
    ],
    creator: User(email: 'User5'),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Quizz(
    id: 6,
    name: 'Quizz 6',
    description: 'Description for Quizz 6',
    theme: ThemeModel(name: 'Sports'),
    image: 'https://example.com/image6.png',
    questions: [
      Question(title: 'How many players are there in a soccer team?'),
      Question(title: 'In which sport is the term "home run" used?'),
    ],
    creator: User(email: 'User6'),
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
