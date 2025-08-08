import 'package:cloud_firestore/cloud_firestore.dart';

abstract class NotificationsEntity {
  String message;
  final Timestamp time;

  NotificationsEntity({required this.time, required this.message});
}
