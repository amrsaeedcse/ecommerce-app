import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RatingEntity {
  final String userName;
  final String userId;
  final int rating;
  final String comment;
  final Timestamp time;

  RatingEntity({
    required this.time,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
  });
}
