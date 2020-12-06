import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/viewmodels/service_model.dart';
import 'package:uplanit_supplier/ui/shared/default_app_bar.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textfield.dart';
import 'package:uplanit_supplier/ui/widgets/custom_service_button.dart';

import './add_new_service_delivery.dart';

class AddNewCostAndDelivery extends StatelessWidget {
  static const String ROUTE = '/service/all/add_new_cost_and_delivery';
  const AddNewCostAndDelivery({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceModel>(
      builder: (context, model, child) => Scaffold(
        appBar: defaultAppBar(
          context: context,
          title: 'Service cost and delivery',
        ),
        body: ReactiveForm(
          formGroup: model.serviceCostForm,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
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
                          'Cost(\$)',
                          style: GoogleFonts.workSans(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        CustomReactiveTextField(
                          formControlName: 'cost',
                          color: Colors.black,
                          fontSize: 14.0,
                          keyboardType: TextInputType.text,
                          validationMessages: (control) =>
                              {'required': 'please enter the service cost'},
                        ),
                        Text(
                          'How much would you charge for this service?',
                          style: GoogleFonts.workSans(
                            fontSize: 14.0,
                            color: Color(0xFFBFC1CF),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Reservation fee(\$)',
                          style: GoogleFonts.workSans(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        CustomReactiveTextField(
                          formControlName: 'reservation_fee',
                          color: Colors.black,
                          fontSize: 14.0,
                          keyboardType: TextInputType.text,
                          validationMessages: (control) =>
                              {'required': 'please enter the service cost'},
                        ),
                        Text(
                          'Non-refundable to planner on cancelation ',
                          style: GoogleFonts.workSans(
                            fontSize: 14.0,
                            color: Color(0xFFBFC1CF),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F1F1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Service Cost',
                                    style: GoogleFonts.workSans(
                                      fontSize: 16,
                                      color: Color(0xFF909090),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Reservation fee inclusive',
                                    style: GoogleFonts.workSans(
                                      fontSize: 14,
                                      color: Color(0xFFBFC1CF),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '\$ 1,234',
                                style: GoogleFonts.workSans(
                                  fontSize: 24.0,
                                  color: Color(0xFF909090),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Text(
                          'Down Payment(\$)',
                          style: GoogleFonts.workSans(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        CustomReactiveTextField(
                          formControlName: 'down_payment',
                          color: Colors.black,
                          fontSize: 14.0,
                          keyboardType: TextInputType.text,
                          validationMessages: (control) =>
                              {'required': 'please enter the service cost'},
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Service Duration'),
                                      Icon(
                                        Icons.help,
                                        color: Colors.grey,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: CustomReactiveTextField(
                                          formControlName: 'service_duration',
                                          color: Colors.black45,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        flex: 2,
                                        child: ReactiveDropdownField(
                                          formControlName: 'service_days',
                                          items: [
                                            DropdownMenuItem(
                                              child: Text('Day(s)', style: GoogleFonts.workSans(fontSize: 12,),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Notice Duration'),
                                      Icon(
                                        Icons.help,
                                        color: Colors.grey,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: CustomReactiveTextField(
                                          formControlName: 'notice_duration',
                                          color: Colors.black26,
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        flex: 2,
                                        child: ReactiveDropdownField(
                                            formControlName: 'notice_days',
                                            items: [
                                              DropdownMenuItem(
                                                child: Text('Day(s)', style: GoogleFonts.workSans(fontSize: 12,),),
                                              ),
                                            ]),
                                      )
                                    ],
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
                        model.submitServiceCostAndDeliveryForm();
                        Navigator.pushNamed(
                          context,
                          AddNewServiceDelivery.ROUTE,
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
    );
  }
}
