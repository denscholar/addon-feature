import 'package:flutter/material.dart';

class CustomLoginGF extends StatelessWidget {
  final double heights;
  final double width;
  final Function onTap;
  final String images;
  final TextStyle style;
  final Text text;
  final String title;

  CustomLoginGF(
      {this.onTap,
      this.images,
      this.text,
      this.style,
      this.title,
      this.width,
      this.heights});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
      child: ButtonTheme(
        minWidth: 10.0,
        height: 50.0,
        child: OutlineButton(
          onPressed: onTap,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          splashColor: Colors.grey,
          borderSide: BorderSide(color: Colors.grey),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(
                  images,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '${this.title}',
                style: style,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
