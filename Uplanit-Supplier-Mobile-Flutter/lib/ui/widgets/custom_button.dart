import 'package:flutter/material.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double radius;
  final TextStyle style;
  final bool disabled;
  final bool loading;
  const CustomButton({
    Key key,
    @required this.title,
    this.radius = 0.0,
    this.style,
    this.disabled,
    this.loading,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeIn,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: disabled != null && disabled
              ? CustomColor.primaryColor.withOpacity(.4)
              : CustomColor.primaryColor,
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
        child: Center(
          child: loading != null && loading 
              ? CustomProgressWidget()
              : Text(
                  '${this.title}',
                  style: style,
                ),
        ),
      ),
    );
  }
}
