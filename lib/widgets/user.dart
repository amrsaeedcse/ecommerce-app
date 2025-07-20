import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({
    required this.email,
    required this.name,
    required this.age,
    required this.sex,
    required this.userCredential,
  });

  factory UserModel.fromJson({
    required UserCredential userCredential,
    required String email,
    required String name,
    required String sex,
    required String age,
  }) {
    return UserModel(
      userCredential: userCredential,
      email: email,
      name: name,
      age: age,
      sex: sex,
    );
  }
  final UserCredential userCredential;
  final String email;
  final String name;
  final String age;
  final String sex;
}
