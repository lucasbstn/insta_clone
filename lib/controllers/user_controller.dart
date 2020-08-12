import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:insta_clone/models/user.dart';

class UserController extends GetxController {
  FirebaseUser firebaseUser;
  User user;

  UserController(this.firebaseUser) {
    //if signed in automatically by firebase
    if (firebaseUser != null) {
      fetchUserData();
    }
  }

  signIn(FirebaseUser user) {
    //manual sign in
    firebaseUser = user;
    fetchUserData();
    update();
  }

  signOut() {
    firebaseUser = null;
    user = null;
    update();
  }

  updateUser() {
    Firestore.instance
        .collection('users')
        .document(user.uid)
        .setData(user.toMap(), merge: true);
    update();
  }

  fetchUserData() async {
    user = User.fromMap(
      (await Firestore.instance
              .collection('users')
              .document(firebaseUser.uid)
              .get())
          .data,
    );
  }
}
