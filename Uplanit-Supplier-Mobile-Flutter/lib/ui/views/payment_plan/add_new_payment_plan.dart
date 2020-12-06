import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/models/payment_plan/payment_plan_response.dart';
import 'package:uplanit_supplier/core/models/payment_plan/post_payment_plan.dart';
import 'package:uplanit_supplier/core/viewmodels/payment_plan_model.dart';
import 'package:uplanit_supplier/ui/shared/default_app_bar.dart';
import 'package:uplanit_supplier/ui/widgets/custom_button.dart';
import 'package:uplanit_supplier/ui/widgets/custom_checkbox.dart';
import 'package:uplanit_supplier/ui/widgets/custom_flat_checkbox.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_checkbox.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textfield.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textfield.dart';

class AddNewPaymentPlan extends StatelessWidget {
  static const String ROUTE = '/payment_plan/add_new_payment_plan';
  AddNewPaymentPlan({Key key}) : super(key: key);

  PaymentPlanModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<PaymentPlanModel>(context);
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'Add New Payment Plan'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: ReactiveForm(
            formGroup: model.form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Payment name'),
                CustomReactiveTextField(
                  formControlName: 'name',
                  color: Colors.black,
                  fontSize: 14.0,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 8),
                Text(
                  'Minimum purchase',
                  style: GoogleFonts.workSans(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomReactiveTextField(
                  formControlName: 'min_cost',
                  color: Colors.black,
                  fontSize: 14.0,
                  keyboardType: TextInputType.number,
                ),
                Text(
                  'Minimum cost to enable payment plan',
                  style: GoogleFonts.workSans(
                    fontSize: 11.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                Text('Down payment(%)'),
                CustomReactiveTextField(
                  formControlName: 'down_payment',
                  color: Colors.black,
                  fontSize: 14.0,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 8),
                Text(
                  'Total number of payment after down payment',
                  style: GoogleFonts.workSans(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomReactiveTextField(
                  formControlName: 'number_of_payments',
                  color: Colors.black,
                  fontSize: 14.0,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 8),
                Text('Payment interval(days)*'),
                CustomReactiveTextField(
                  formControlName: 'interval',
                  color: Colors.black,
                  fontSize: 14.0,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 8),
                Text(
                  'Preferred payment date',
                  style: GoogleFonts.workSans(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomReactiveTextField(
                  formControlName: 'preferred_payment_day',
                  color: Colors.black,
                  fontSize: 14.0,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 8),
                Text(
                  'Last payment gap',
                  style: GoogleFonts.workSans(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomReactiveTextField(
                  formControlName: 'last_payment',
                  color: Colors.black,
                  fontSize: 14.0,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomReactiveCheckBox(
                      formControlName: 'refund',
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Refund if booking is cancelled',
                      style: GoogleFonts.workSans(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ReactiveFormConsumer(
                  builder: (context, form, child) => CustomButton(
                    title: 'Create',
                    loading: model.isSubmitLoading,
                    radius: 4,
                    style: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    disabled: !form.valid,
                    onPressed: form.valid
                        ? () async {
                            model.setLoading(true);

                            PaymentPlanResponse response =
                                await model.createPaymentPlan(form.value);
                            model.setLoading(false);
                            if (response != null) {
                              print('success');
                              model.getPaymentPlans();
                              // model.form.reset();
                              Navigator.pop(context);
                            } else {
                              print('something went wrong: ');
                            }
                          }
                        : null,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
