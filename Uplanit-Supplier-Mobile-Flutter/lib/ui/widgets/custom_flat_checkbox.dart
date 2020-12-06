import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomFlatCheckBox extends StatelessWidget {
  final bool isChecked;
  final Color color;
  final Function(bool) onChanged;
  CustomFlatCheckBox({
    Key key,
    this.isChecked,
    this.color = Colors.black54,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: onChanged,
      checkColor: Colors.white,
      activeColor: color,
    );
  }
}
