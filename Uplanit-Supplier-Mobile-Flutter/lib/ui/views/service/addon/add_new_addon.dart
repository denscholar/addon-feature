import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/viewmodels/service_model.dart';
import 'package:uplanit_supplier/ui/shared/default_app_bar.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textarea.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textfield.dart';
import 'package:uplanit_supplier/ui/widgets/custom_service_button.dart';

import 'add_on_new_image.dart';

class AddNewAddon extends StatelessWidget {
  static const String ROUTE = '/add_new_addon-ons';
  const AddNewAddon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceModel>(
      builder: (context, model, child) => Scaffold(
        appBar: defaultAppBar(
          context: context,
          title: 'List a new add-on',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: ReactiveForm(
              formGroup: model.serviceDescriptionForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add-on name',
                    style: GoogleFonts.workSans(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  CustomReactiveTextField(
                    formControlName: 'name',
                    color: Colors.black,
                    fontSize: 14.0,
                    keyboardType: TextInputType.text,
                    validationMessages: (control) =>
                        {'required': 'please enter the services name'},
                  ),
                  Text(
                    'Ensure to provide a name people can easily understand.',
                    style: GoogleFonts.workSans(
                      fontSize: 14.0,
                      color: Color(0xFFBFC1CF),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Add-on Description',
                    style: GoogleFonts.workSans(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  CustomReactiveTextArea(
                    formControlName: 'name',
                    title: 'Write something here...',
                    color: Colors.black,
                    fontSize: 14.0,
                    keyboardType: TextInputType.text,
                    validationMessages: (control) =>
                        {'required': 'write something about the service'},
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Tell your client everything about this add-on and how it changes the parents service',
                    style: GoogleFonts.workSans(
                      fontSize: 14.0,
                      color: Color(0xFFBFC1CF),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'Cost(\$)',
                    style: GoogleFonts.workSans(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomReactiveTextField(
                    formControlName: 'name',
                    color: Colors.black,
                    fontSize: 14.0,
                    keyboardType: TextInputType.text,
                    validationMessages: (control) =>
                        {'required': 'please enter an amount'},
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'How much would you charge for this add-on?',
                    style: GoogleFonts.workSans(
                      fontSize: 14.0,
                      color: Color(0xFFBFC1CF),
                      fontWeight: FontWeight.w400,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
