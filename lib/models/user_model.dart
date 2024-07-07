class User {
  final String? uuid;
  final String? telephone;
  final String? email;
  final String? password;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.uuid,
    this.telephone,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> question) {
    return User(
      uuid: question['uuid'],
      telephone: question['telephone'],
      email: question['email'],
      password: question['password'],
      createdAt: question['createdAt'] != null
          ? DateTime.parse(question['createdAt'])
          : null,
      updatedAt: question['updatedAt'] != null
          ? DateTime.parse(question['updatedAt'])
          : null,
    );
  }
}
