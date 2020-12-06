import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/viewmodels/service_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/default_app_bar.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textarea.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textfield.dart';
import 'package:uplanit_supplier/ui/widgets/custom_service_button.dart';

import './add_new_cost_and_delivery.dart';

class AddNewService extends StatelessWidget {
  static const String ROUTE = '/service/all/add_new_service';
  const AddNewService({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceModel>(
      builder: (context, model, child) => Scaffold(
        appBar: defaultAppBar(
          context: context,
          title: 'Service Description',
        ),
        body: ReactiveForm(
          formGroup: model.serviceDescriptionForm,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: ReactiveForm(
              formGroup: model.serviceDescriptionForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            'Service name',
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
                                {'required': 'please enter the service name'},
                          ),
                          Text(
                            'Ensure to provide a name people can easily understand.',
                            style: GoogleFonts.workSans(
                              fontSize: 14.0,
                              color: Color(0xFFBFC1CF),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Service name',
                            style: GoogleFonts.workSans(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          CustomReactiveTextArea(
                            formControlName: 'description',
                            title: 'Write something here...',
                            color: Colors.black,
                            fontSize: 14.0,
                            keyboardType: TextInputType.text,
                            validationMessages: (control) => {
                              'required': 'write something about the service'
                            },
                          ),
                          Text(
                            'Tell your client everything about the service. Answer all questions you\'ll expect in a consultation.',
                            style: GoogleFonts.workSans(
                              fontSize: 14.0,
                              color: Color(0xFFBFC1CF),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: CustomServiceButton(
                      onTap: () {
                        model.submitServiceDescriptionForm();
                        Navigator.pushNamed(
                          context,
                          AddNewCostAndDelivery.ROUTE,
                        );
                      },
                      title: 'Next',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
