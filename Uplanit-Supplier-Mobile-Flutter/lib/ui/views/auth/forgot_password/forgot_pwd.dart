import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ForgotPwd extends StatefulWidget {
  @override
  _ForgotPwdState createState() => _ForgotPwdState();
}

class _ForgotPwdState extends State<ForgotPwd> {
  final TextEditingController _popEditingController = TextEditingController();

  String email = '';

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          Container(
            height: 270.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontFamily: 'Work Sans',
                        fontSize: 18.0,
                        color: Color(0XFF25282B),
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                    child: TextFormField(
                      onChanged: (value) => _formKey.currentState.validate(),
                      validator: (String value) {
                        if (value.isEmpty == true) {
                          return 'Please enter email address';
                        } else if (!value.contains('@')) {
                          return 'enter a valid email address';
                        } else {
                          return null;
                        }
                      },
                      controller: _popEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.envelope),
                          labelStyle: TextStyle(fontSize: 15.0),
                          hintText: 'Enter your email address',
                          hintStyle: TextStyle(fontSize: 15.0),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(30.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0)),
                        color: Color(0XFFC20370),
                        onPressed: () {
                          resetPassword(context);
                        },
                        child: Text('SUBMIT',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Work Sans',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600)),
                      ))
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _popEditingController.text);
      Fluttertoast.showToast(
          msg:
              "Kindly check your email, a reset password link has been sent to you",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      // .then((value) => print('Reset link has been sent to your email'));
      Navigator.pop(context);
    }
  }

}
