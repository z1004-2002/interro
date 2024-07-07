import 'package:interro/services/model_helper.dart';
import 'package:interro/models/question_model.dart';
import 'package:interro/models/theme_model.dart';
import 'package:interro/models/user_model.dart';

class Quizz {
  final int? id;
  final String? name;
  final String? description;
  final ThemeModel? theme;
  final String? image;
  final List<Question>? questions;
  final User? creator;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Quizz({
    this.id,
    this.name,
    this.description,
    this.theme,
    this.image,
    this.questions,
    this.creator,
    this.createdAt,
    this.updatedAt,
  });

  factory Quizz.fromJson(Map<String, dynamic> question) {
    return Quizz(
      id: question['id'],
      name: question['name'],
      description: question['description'],
      image: question['image'],
      theme: question['theme'] != null
          ? ThemeModel.fromJson(question['theme'])
          : null,
      questions: fetchItemsList(
        question,
        'questions',
        itemMapper: (question) => Question.fromJson(question),
      ),
      createdAt: question['createdAt'] != null
          ? DateTime.parse(question['createdAt'])
          : null,
      updatedAt: question['updatedAt'] != null
          ? DateTime.parse(question['updatedAt'])
          : null,
    );
  }
}
