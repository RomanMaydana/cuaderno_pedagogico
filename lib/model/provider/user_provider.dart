import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/user.dart';

class UserProvider extends ChangeNotifier {
  User _user;

  User get user => this._user;

  set user(User user) {
    this._user = user;
    notifyListeners();
  }

  void removeUser() {
    this._user = null;
    notifyListeners();
  }

  static UserProvider of(BuildContext context) =>
      Provider.of<UserProvider>(context, listen: false);
}
