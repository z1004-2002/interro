class Question {
  final int? id;
  final String? title;
  final String? answer;
  final String? prop2;
  final String? prop3;
  final String? prop4;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Question({
    this.id,
    this.title,
    this.answer,
    this.prop2,
    this.prop3,
    this.prop4,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Question.fromJson(Map<String, dynamic> question) {
    return Question(
      id: question['id'],
      title: question['title'],
      answer: question['answer'],
      prop2: question['prop2'],
      prop3: question['prop3'],
      prop4: question['prop4'],
      image: question['image'],
      createdAt: question['createdAt'] != null
          ? DateTime.parse(question['createdAt'])
          : null,
      updatedAt: question['updatedAt'] != null
          ? DateTime.parse(question['updatedAt'])
          : null,
    );
  }

  List<String> get getPropositions {
    return [answer!, prop2!, prop3!, prop4!];
  }
}
