import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/string_validator.dart' as str;
import '../data/user.dart';

class AuthModel extends ChangeNotifier {
  String _urlImage;
  String _fullName = '';
  String _email = '';
  String _password = '';
  String _phoneNumber = '';
  String _country;
  String _zipCode = '';
  String _userId;
  bool _accept = false;
  File _file;
  bool isLoading = false;
  bool showPassword = false;
  bool edit = false;
  final focusNode = FocusNode();

  set fullName(String value) => this._fullName = value;
  set email(String value) => this._email = value;
  set password(String value) => this._password = value;
  set phoneNumber(String value) => this._phoneNumber = value;
  set zipCode(String value) => this._zipCode = value;
  set userId(String value) => this._userId = value;
  set urlImage(String value) => this._urlImage = value;
  set country(String value) {
    this._country = value;
    notifyListeners();
  }

  void setEdit() {
    this.edit = !this.edit;
    notifyListeners();
  }

  set file(File file) {
    this._file = file;
    notifyListeners();
  }

  void reset() {
    this.file = null;
    setEdit();
    notifyListeners();
  }

  get urlImage => this._urlImage;

  void accept() {
    this._accept = !this._accept;
    notifyListeners();
  }

  String get country => this._country;
  bool get getAccept => this._accept;
  String get email => this._email;
  String get password => this._password;
  File get file => this._file;

  String validatorCountry(String value) {
    if (value == null) {
      return 'Please select some country';
    }
    return null;
  }

  void setIsLoading() {
    this.isLoading = !isLoading;
    notifyListeners();
  }

  void finallyLoading() {
    this.isLoading = false;
    this.edit = false;
    notifyListeners();
  }

  void setShowPassword() {
    this.showPassword = !showPassword;
    notifyListeners();
  }

  // User get getUser => User(
  //     country: this._country,
  //     createDate: DateTime.now(),
  //     email: this._email,
  //     favorites: [],
  //     fullName: this._fullName,
  //     phoneNumber: this._phoneNumber,
  //     urlImage: this._urlImage,
  //     userId: this._userId,
  //     zipCode: this._zipCode);

  void destroy() {
    focusNode.dispose();
  }
}
