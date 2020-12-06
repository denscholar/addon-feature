import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/viewmodels/service_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/views/home_view.dart';

class AddNewServiceCompleted extends StatelessWidget {
  static const String ROUTE = '/service/all/add_new_service_completed';
  const AddNewServiceCompleted({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceModel>(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'Congrats Naomi!',
                  style: GoogleFonts.workSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.uplanitBlue,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  'You have sucessfully created a new service',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.workSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: CustomColor.uplanitBlue,
                  ),
                ),
              ),
              SizedBox(height: 24),
              RaisedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, HomeView.ROUTE),
                color: CustomColor.uplanitBlue,
                child: Text(
                  'View service',
                  style: GoogleFonts.workSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {},
                child: Text(
                  'Other Options',
                  style: GoogleFonts.workSans(
                    decoration: TextDecoration.underline,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
