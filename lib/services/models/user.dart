import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({
    required this.uid,
    required this.imgUrl,
    required this.username,
    required this.email,
    required this.password,
    required this.bio,
    required this.followers,
    required this.following,
  });

  final String uid;
  final String imgUrl;
  final String username;
  final String email;
  final String password;
  final String bio;
  final List<int> followers;
  final List<int> following;

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "imgUrl": imgUrl,
        "username": username,
        "email": email,
        "password": password,
        "bio": bio,
        "followers": followers,
        "following": following,
      };

  static User snapshotToUserModel(DocumentSnapshot snapshot) {
    return User(
      uid: (snapshot.data() as Map<String, dynamic>)["uid"],
      imgUrl: (snapshot.data() as Map<String, dynamic>)["imgUrl"],
      username: (snapshot.data() as Map<String, dynamic>)["username"],
      email: (snapshot.data() as Map<String, dynamic>)["email"],
      password: (snapshot.data() as Map<String, dynamic>)["password"],
      bio: (snapshot.data() as Map<String, dynamic>)["bio"],
      followers: (snapshot.data() as Map<String, dynamic>)["followers"],
      following: (snapshot.data() as Map<String, dynamic>)["following"],
    );
  }
}
