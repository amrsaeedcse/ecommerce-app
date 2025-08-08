import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({
    required this.email,
    required this.name,
    required this.age,
    required this.sex,
  });

  factory UserModel.fromJson({
    required String email,
    required String name,
    required String sex,
    required String age,
  }) {
    return UserModel(email: email, name: name, age: age, sex: sex);
  }

  factory UserModel.fromJsonXd(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      age: json['age'],
      sex: json['sex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "age": age, "email": email, "sex": sex};
  }

  final String email;
  final String name;
  final String age;
  final String sex;
}
