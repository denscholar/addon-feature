import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/viewmodels/service_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/default_app_bar.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';
import 'package:uplanit_supplier/ui/widgets/custom_service_button.dart';
// import 'add_on_done.dart';

class AddOnImage extends StatelessWidget {
  const AddOnImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceModel>(
      builder: (context, model, child) => Scaffold(
        appBar: defaultAppBar(
          context: context,
          title: 'Add Image',
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                 
                  // Navigator.push(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => AddonDone()),
                  //       );
                },
                color: CustomColor.uplanitBlue,
                child: Text(
                  'Add Image',
                  style: GoogleFonts.workSans(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text:
                          'Show clients images of add-on, you can add up to 10 images.',
                      style: GoogleFonts.workSans(
                        color: Color(0xFFBFC1CF),
                        fontSize: 14.0,
                      ),
                    ),
                  ),
              
                  SizedBox(height: 20.0),
                  Center(
                    child: CustomServiceButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddOnImage()),
                        );
                      },
                      title: 'Next',
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
  
}
