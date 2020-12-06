import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uplanit_supplier/core/enums/view_state.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/utility_service.dart';
import 'package:uplanit_supplier/core/utils/api_endpoint_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

class BaseModel extends ChangeNotifier {
  AuthenticationService auth = locator<AuthenticationService>();
  UtilityService _utilityService = locator<UtilityService>();
  
  bool _isEditMode = false;
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  bool get isEditMode => _isEditMode;
 

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  

  void toggleMode() {
    _isEditMode = !_isEditMode;
    notifyListeners();
  }

  Future<String> getFileUploadURL({String filename, String type}) async {
    String dynamicURL =
        ApiEndpoint.GET_FILE_UPLOAD_URL + "?name=$filename&type=$type";
    String token = await auth.user.getIdToken();
    return await _utilityService.getFileUploadURL(
      token: token,
      dynamicURL: dynamicURL,
    );
  }

  Future<String> uploadFileToS3({
    String url,
    File file,
  }) async {
    return await _utilityService.uploadFileToS3(
      url: url,
      file: file,
    );
  }

  Future<String> firebaseExceptionsHandler(FirebaseAuth auth, dynamic e) async {
    if (e.code == 'account-exists-with-different-credential') {
      // The account already exists with a different credential
      String email = e.email;
      AuthCredential pendingCredential = e.credential;

      // Fetch a list of what sign-in methods exist for the conflicting user
      List<String> userSignInMethods =
          await auth.fetchSignInMethodsForEmail(email);

      // If the user has several sign-in methods,
      // the first method in the list will be the "recommended" method to use.
      if (userSignInMethods.first == 'password') {
        // Prompt the user to enter their password
        String password = '...';

        // Sign the user in to their account with the password
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Link the pending credential with the existing account
        await userCredential.user.linkWithCredential(pendingCredential);

        // Success! Go back to your application flow
        return "true";
      }
    }
  }
}
