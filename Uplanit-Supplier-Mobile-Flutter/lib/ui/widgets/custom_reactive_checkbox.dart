import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomReactiveCheckBox extends StatelessWidget {
  final bool isChecked;
  final Color color;
  final Function(bool) onChanged;
  final String formControlName;
  CustomReactiveCheckBox({
    Key key,
    this.formControlName,
    this.isChecked,
    this.color = Colors.black54,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveCheckbox(
      formControlName: formControlName,
      checkColor: Colors.white,
      activeColor: color,
    );
  }
}
