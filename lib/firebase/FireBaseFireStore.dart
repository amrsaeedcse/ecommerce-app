import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/firebase/firebaseauth.dart';

class FireBaseFireStore {
  final fireBaseFireStore = FirebaseFirestore.instance;

  Future<bool> isHere(String userId) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await fireBaseFireStore.collection("users").doc(userId).get();
      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future addUserWithGoogle({
    required String email,
    required String name,
    required String age,
    required String sex,
    required String userId,
  }) async {
    await FirebaseFirestore.instance.collection("users").doc(userId).set({
      "name": name,
      "email": email,
      "age": age,
      "sex": sex,
    }, SetOptions(merge: true));
  }
}
