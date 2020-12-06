import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
// import 'package:path/path.dart';
import 'package:uplanit_supplier/core/enums/view_state.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/viewmodels/signin_model.dart';
import 'package:uplanit_supplier/ui/views/auth/forgot_password/forgot_pwd.dart';
import 'package:uplanit_supplier/ui/views/auth/signup/sign_up.dart';
import 'package:uplanit_supplier/ui/views/auth/signup/sign_up_pager_finish.dart';
import 'package:uplanit_supplier/ui/widgets/custom_button.dart';
import 'package:uplanit_supplier/ui/widgets/custom_login_gf.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textfield.dart';
import 'package:uplanit_supplier/main.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  static const String ROUTE = '/login';
  Login({Key key}) : super(key: key);
  SigninModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SigninModel>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: 30),
                CustomLoginGF(
                  onTap: () async {
                    User user = await context
                        .read<AuthenticationService>()
                        .facebookSignIn();
                    if (user != null) {
                      Navigator.pushNamed(
                        context,
                        AuthenticationWrapper.ROUTE,
                      );
                    } else {
                      // _showSnackBarError(context);
                    }
                  },
                  title: 'Sign in with Facebook',
                  images: 'assets/images/facebook.png',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomLoginGF(
                  onTap: () async {
                    User user = await context
                        .read<AuthenticationService>()
                        .googleSignIn();

                    if (user != null) {
                      Navigator.pushNamed(
                        context,
                        AuthenticationWrapper.ROUTE,
                      );
                    } else {
                      // _showSnackBarError(context);
                    }
                  },
                  title: 'Sign in with Google',
                  images: 'assets/images/google.png',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _buildText(),
                SizedBox(height: 20),
                ReactiveForm(
                  formGroup: model.form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'EMAIL',
                        style: GoogleFonts.workSans(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomReactiveTextField(
                        formControlName: 'email',
                        keyboardType: TextInputType.emailAddress,
                        color: Colors.black,
                        validationMessages: (control) => {
                          'required': 'Enter your email address',
                          'email': 'Please enter a valid email'
                        },
                      ),
                      SizedBox(height: 20),
                      Text(
                        'PASSWORD',
                        style: GoogleFonts.workSans(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomReactiveTextField(
                        formControlName: 'password',
                        color: Colors.black,
                        keyboardType: TextInputType.text,
                        isPassword: true,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => ForgotPwd());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Consumer<SigninModel>(
                        builder: (context, value, child) =>
                            ReactiveFormConsumer(
                          builder: (context, form, child) => Opacity(
                            opacity: !form.valid ? .4 : 1,
                            child: CustomButton(
                              title: 'LOG IN',
                              style: GoogleFonts.workSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              disabled: !form.valid,
                              loading: value.state == ViewState.Busy,
                              onPressed:
                                  !form.valid || value.state == ViewState.Busy
                                      ? null
                                      : () async {
                                          value.setState(ViewState.Busy);
                                          User user = await value.submitData();
                                          value.setState(ViewState.Idle);
                                          // form.control('password').reset();
                                          if (user != null) {
                                            Navigator.pushNamed(
                                              context,
                                              AuthenticationWrapper.ROUTE,
                                            );
                                          } else {
                                            print('an error occurred');
                                          }
                                        },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // margin: EdgeInsets.only(top: 5),
            child: Image.asset(
              "assets/images/logo.png",
              height: 50.0,
            ),
          ),
          FlatButton(
            onPressed: () => Navigator.pushNamed(context, SignUp.ROUTE),
            child: Text(
              'Sign Up',
              style: GoogleFonts.workSans(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildText() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Log in to continue',
              style: GoogleFonts.workSans(
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
              ),
            )
          ]),
    );
  }
}
