import 'package:ecommerceapp/data/rating/ratingentitny.dart';

class RatingModel extends RatingEntity {
  RatingModel({
    required super.time,
    required super.userId,
    required super.userName,
    required super.rating,
    required super.comment,
    super.userImage,
  });

  factory RatingModel.fromJsom(Map<String, dynamic> json) {
    return RatingModel(
      userId: json['userId'],
      comment: json['comment'],
      rating: json['rating'],
      userName: json['username'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "comment": comment,
      "rating": rating,
      "username": userName,
      "time": time,
    };
  }
}
