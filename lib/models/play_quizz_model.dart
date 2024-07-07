import 'package:interro/models/quizz_model.dart';
import 'package:interro/models/user_model.dart';

class PlayQuizz {
  final int? id;
  final User? user;
  final Quizz? quizz;
  final int? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PlayQuizz({
    this.id,
    this.user,
    this.quizz,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory PlayQuizz.fromJson(Map<String, dynamic> question) {
    return PlayQuizz(
      id: question['id'],
      user: question['user'],
      quizz: question['quizz'],
      note: question['note'],
      createdAt: question['createdAt'] != null
          ? DateTime.parse(question['createdAt'])
          : null,
      updatedAt: question['updatedAt'] != null
          ? DateTime.parse(question['updatedAt'])
          : null,
    );
  }
}
