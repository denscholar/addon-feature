import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomReactiveTextField extends StatelessWidget {
  final String title;
  final Color color;
  final bool isPassword;
  final TextInputType keyboardType;
  final Function(AbstractControl<dynamic>) validationMessages;
  final String errorText;
  final double fontSize;
  final String formControlName;

  const CustomReactiveTextField({
    Key key,
    this.color,
    this.title,
    this.isPassword = false,
    this.keyboardType,
    this.errorText,
    this.fontSize = 14,
    this.formControlName,
    this.validationMessages,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: formControlName,
      validationMessages: validationMessages,
      obscureText: isPassword ? true : false,
      keyboardType: keyboardType,
      style: TextStyle(
        color: color == Colors.white ? Colors.white : Colors.black,
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: color == null ? Colors.white : color,
              width: 1.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: color == null ? Colors.white : color,
              width: 1.0,
            ),
          ),
          hintText: this.title,
          hintStyle: TextStyle(
            color: color == Colors.white ? Colors.white : color,
          ),
          errorText: errorText,
          errorStyle: GoogleFonts.workSans(
            fontSize: fontSize ?? 12,
            color: color == Colors.red ? Colors.red : color,
          )),
    );
  }
}
