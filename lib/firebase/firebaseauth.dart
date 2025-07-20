import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/firebase/FireBaseFireStore.dart';
import 'package:ecommerceapp/widgets/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuth {
  final fireBaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn.instance;

  Future signUp({
    required String email,
    required String pass,
    required String name,
    required String age,
    required String sex,
  }) async {
    try {
      final UserCredential userCredential = await fireBaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
            "name": name,
            "email": email,
            "age": age,
            "sex": sex,
          }, SetOptions(merge: true));

      UserModel userModel = UserModel(
        email: email,
        name: name,
        age: age,
        sex: sex,
        userCredential: userCredential,
      );
      return userModel;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return AuthFailure.emailAlreadyInUse;
        default:
          return AuthFailure.unknown;
      }
    } catch (e) {
      return AuthFailure.fireStoreError;
    }
  }

  Future signIn({required String email, required String pass}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );
  }

  Future signInWithGoogle() async {
    try {
      await googleSignIn.initialize(
        serverClientId:
            "382370893360-0ho1l2nivhf474d6cb6hnsf5138e9dri.apps.googleusercontent.com",
      );

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .authenticate();
      if (googleSignInAccount == null) {
        throw "get-out";
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential = await fireBaseAuth
          .signInWithCredential(authCredential);

      final db = FireBaseFireStore();
      bool isHere = await db.isHere(userCredential.user!.uid);
      if (isHere == false) {
        throw 'isnt-here';
      }
    } catch (e) {
      if (e.toString().contains("get-out")) {
        throw "get-out";
      } else if (e.toString().contains("isnt-here")) {
        print("got it");
        throw "isnt-here";
      }
      {
        throw "error";
      }
    }
  }
}

enum AuthFailure {
  invalidEmail,
  emailAlreadyInUse,
  weakPassword,
  userNotFound,
  wrongPassword,
  userDisabled,
  operationNotAllowed,
  unknown,
  fireStoreError,
}
