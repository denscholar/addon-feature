import 'dart:async';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/models/onboard/onboard.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/onboard_service.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

import 'base_model.dart';

class OnboardModel extends BaseModel {
  OnboardService onboardService = OnboardService();
  AuthenticationService auth = locator<AuthenticationService>();
  final form = FormGroup({
    'name': FormControl(validators: [Validators.required]),
    'description': FormControl(validators: [Validators.required])
  });

  String get name => form.control('name').value.trim();
  String get description => form.control('description').value.trim();

  Future<Profile> createProfile() async {
    String idToken = await auth.user.getIdToken();

    return onboardService.createProfile(
      body: Profile(
        name: name,
        description: description,
      ),
      token: idToken,
    );
  }
}
