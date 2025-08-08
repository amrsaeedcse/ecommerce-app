import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/data/notifications/notificationsentity.dart';

class NotificationsModel extends NotificationsEntity {
  NotificationsModel({required super.time, required super.message});

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(time: json['time'], message: json['message']);
  }
  Map<String, dynamic> toJson() {
    return {"time": Timestamp.now(), "message": message};
  }
}
