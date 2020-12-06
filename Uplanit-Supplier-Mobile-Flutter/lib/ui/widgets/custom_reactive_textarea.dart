import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomReactiveTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final Color color;
  final String value;
  final Function validator;
  final bool isPassword;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final String errorText;
  final int maxLines;
  final Function(AbstractControl<dynamic>) validationMessages;
  final String formControlName;
  final double fontSize;

  const CustomReactiveTextArea(
      {Key key,
      this.controller,
      this.title,
      this.color,
      this.value,
      this.validator,
      this.isPassword = false,
      this.keyboardType,
      this.onChanged,
      this.errorText,
      this.maxLines = 5,
      this.fontSize = 22,
      this.formControlName,
      this.validationMessages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      formControlName: formControlName,
      validationMessages: validationMessages,
      keyboardType: keyboardType,
      style: TextStyle(
        color: color == Colors.white ? Colors.white : Colors.black,
        fontSize: fontSize,
      ),
      maxLines: 5,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color == Colors.white ? Colors.white : color,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color == Colors.white ? Colors.white : color,
            width: 1.0,
          ),
        ),
        errorText: errorText,
        errorStyle: GoogleFonts.workSans(
          fontSize: 12,
          color: color == Colors.white ? Colors.white : color,
        ),
      ),
    );
  }
}
