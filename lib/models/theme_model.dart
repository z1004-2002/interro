class ThemeModel {
  final int? id;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ThemeModel({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> question) {
    return ThemeModel(
      id: question['id'],
      name: question['name'],
      description: question['description'],
      createdAt: question['createdAt'] != null
          ? DateTime.parse(question['createdAt'])
          : null,
      updatedAt: question['updatedAt'] != null
          ? DateTime.parse(question['updatedAt'])
          : null,
    );
  }
}
