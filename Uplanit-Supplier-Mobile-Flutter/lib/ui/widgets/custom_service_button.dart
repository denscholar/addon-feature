import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';

class CustomServiceButton extends StatelessWidget {
  final Function onTap;
  final String title;

  final Color color;
  const CustomServiceButton({
    Key key,
    @required this.onTap,
    this.title,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: onTap,
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(vertical: 12.0,),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: CustomColor.uplanitBlue,
          ),
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
        child: Center(
          child: Text(
            '$title',
            style: GoogleFonts.workSans(
              color: color != Colors.transparent ? Colors.white : CustomColor.uplanitBlue,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

