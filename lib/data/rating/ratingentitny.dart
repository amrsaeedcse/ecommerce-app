import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RatingEntity {
  String userName;
  final String userId;
  final int rating;
  final String comment;
  final Timestamp time;
  Uint8List? userImage;

  RatingEntity({
    required this.userImage,
    required this.time,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
  });
}
