import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:instagram_clone/services/functions/storage_methods.dart';
import 'package:instagram_clone/services/models/user.dart' as model;

class AuthMethods {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<model.User> getUserDetail() async {
    User currUser = auth.currentUser!;

    DocumentSnapshot snapshot =
        await firestore.collection("users").doc(currUser.uid).get();

    return model.User.snapshotToUserModel(snapshot);
  }

  static Future<String> signUp({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          file != null) {
        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String imgUrl =
            await StorageMethods().uploadImageToStorage("profilePics", file, false);

        model.User user = model.User(
          uid: userCredential.user!.uid,
          imgUrl: imgUrl,
          username: username,
          email: email,
          password: password,
          bio: bio,
          followers: [],
          following: [],
        );

        await firestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(user.toJson());

        res = "success";
      } else {
        res = "Please enter all the field";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  static Future<String> signIn({required String email, required String password}) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);

        res = "success";
      } else {
        res = "Please enter all the field";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  static Future<void> signOut() async {
    await auth.signOut();
  }
}
