import 'package:flutter/material.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';

class CustomProgressWidget extends StatelessWidget {
  final Color color;
  const CustomProgressWidget({
    Key key,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: color == Colors.white
              ? AlwaysStoppedAnimation<Color>(Colors.white)
              : AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
