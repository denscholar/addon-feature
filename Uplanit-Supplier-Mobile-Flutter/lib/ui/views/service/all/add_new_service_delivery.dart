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

import './add_new_service_image.dart';

class AddNewServiceDelivery extends StatelessWidget {
  static const String ROUTE = '/service/all/add_new_service_delivery';
  const AddNewServiceDelivery({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceModel>(
      builder: (context, model, child) => Scaffold(
        appBar: defaultAppBar(
          context: context,
          title: 'Service Delivery',
        ),
        body: ReactiveForm(
          formGroup: model.serviceDeliveryForm,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: ReactiveForm(
              formGroup: model.serviceDeliveryForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            'Delivery Type',
                            style: GoogleFonts.workSans(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          ReactiveDropdownField(
                            formControlName: 'delivery_type',
                            items: [],
                            validationMessages: (control) =>
                                {'required': 'please select delivery location'},
                          ),
                          Text(
                            'What location is the service delivered?',
                            style: GoogleFonts.workSans(
                              fontSize: 14.0,
                              color: Color(0xFFBFC1CF),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Would you refund on cancellation?',
                            style: GoogleFonts.workSans(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              ReactiveRadio(
                                formControlName: 'refund_on_cancellation',
                                activeColor: Colors.black45,
                                value: 'yes',
                              ),
                              Text(
                                'Yes',
                                style: GoogleFonts.workSans(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              ReactiveRadio(
                                formControlName: 'refund_on_cancellation',
                                activeColor: Colors.black45,
                                value: 'no',
                              ),
                              Text(
                                'No',
                                style: GoogleFonts.workSans(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Refund validity',
                            style: GoogleFonts.workSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomReactiveTextField(
                                  formControlName: 'refund_validity',
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 3,
                                child: ReactiveDropdownField(
                                  formControlName:
                                      'refund_days_before_service_delivery',
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(
                                          'Day(s) before service delivery'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 150,
                      child: CustomServiceButton(
                        onTap: () {
                          model.submitServiceDescriptionForm();
                          Navigator.pushNamed(
                            context,
                            AddNewServiceImage.ROUTE,
                          );
                        },
                        title: 'Next',
                      ),
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
