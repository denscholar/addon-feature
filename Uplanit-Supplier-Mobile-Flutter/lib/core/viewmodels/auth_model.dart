import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uplanit_supplier/core/enums/view_state.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/shared/validation.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

import 'base_model.dart';

class AuthModel extends BaseModel {
  AuthenticationService auth = locator<AuthenticationService>();
  final firstLastNameForm = FormGroup({
    'first_name': FormControl(validators: [Validators.required]),
    'last_name': FormControl(validators: [Validators.required])
  });

  final emailPasswordForm = FormGroup({
    'email': FormControl(validators: [Validators.required, Validators.email]),
    'password': FormControl(validators: [Validators.required])
  });
  bool _showPassword = false;
  String _displayName = "";
  String _uid = "";

  String get uid => _uid;
  String get displayName => _displayName;
  bool get showPassword => _showPassword;

  void togglePassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  setDisplayName(String displayName) {
    _displayName = displayName;
    notifyListeners();
  }

  setUid(String uid) {
    _uid = uid;
    notifyListeners();
  }

  goToSignUpPagerTwo() {
    String firstname = firstLastNameForm.control('first_name').value.trim();
    String lastname = firstLastNameForm.control('last_name').value.trim();
    String displayName = '$firstname $lastname';
    setDisplayName(displayName);
  }

  Future<User> registerUserWithEmailAndPassword() async {
    String emailAddress = emailPasswordForm.control('email').value.trim();
    String password = emailPasswordForm.control('password').value.trim();
    try {
      return auth.registerUserWithEmailAndPassword(
        displayName: displayName,
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
    }
  }

}
