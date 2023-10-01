import 'package:flutter/foundation.dart';
import 'package:instagram_clone/services/functions/auth_methods.dart';
import 'package:instagram_clone/services/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await AuthMethods.getUserDetail();
    _user = user;
    notifyListeners();
  }
}
