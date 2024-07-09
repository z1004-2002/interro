import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Quizz.fromJson(Map<String, dynamic> data) {
    DateTime? parseDate(dynamic date) {
      if (date is Timestamp) {
        return date.toDate();
      } else if (date is String) {
        return DateTime.tryParse(date);
      }
      return null;
    }

    return Quizz(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      image: data['image'],
      theme: data['theme'] != null ? ThemeModel.fromJson(data['theme']) : null,
      questions: fetchItemsList(
        data,
        'questions',
        itemMapper: (question) => Question.fromJson(question),
      ),
      createdAt: parseDate(data['createdAt']),
      updatedAt: parseDate(data['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'theme': theme?.toJson(),
      'image': image,
      'questions': questions?.map((q) => q.toJson()).toList(),
      'createdAt': createdAt?.toString(),
      'updatedAt': updatedAt?.toString(),
    };
  }
}
