import 'package:firebase_auth/firebase_auth.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/enums/view_state.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/shared/validation.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class SigninModel extends BaseModel {
  final form = FormGroup({
    'email': FormControl(validators: [Validators.required, Validators.email]),
    'password': FormControl(validators: [Validators.required])
  });

  Future<User> submitData() async {
    try {
      return auth.loginWithEmailAndPassword(
        email: form.control('email').value,
        password: form.control('password').value,
      );
    } on FirebaseAuthException catch (e) {
      print('Auth error: $e');
      return null;
    }
  }
}
