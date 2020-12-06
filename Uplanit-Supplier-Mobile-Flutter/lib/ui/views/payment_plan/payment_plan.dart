import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/models/payment_plan/base_payment_plan.dart';
import 'package:uplanit_supplier/core/models/payment_plan/payment_plan_response.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';
import 'package:uplanit_supplier/core/viewmodels/payment_plan_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/profile_app_bar.dart';
import 'package:uplanit_supplier/ui/views/payment_plan/add_new_payment_plan.dart';
import 'package:uplanit_supplier/ui/widgets/custom_button.dart';
import 'package:uplanit_supplier/ui/widgets/custom_checkbox.dart';
import 'package:uplanit_supplier/ui/widgets/custom_flat_checkbox.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';

class PaymentPlanPage extends StatelessWidget {
  PaymentPlanPage({Key key}) : super(key: key);
  PaymentPlanModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<PaymentPlanModel>(context);
    return Scaffold(
      appBar: profileAppBar(context: context, title: 'Payment Plan', actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () =>
                Navigator.pushNamed(context, AddNewPaymentPlan.ROUTE),
            color: CustomColor.primaryColor,
            child: Text(
              'Add New',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ]),
      body: model.paymentPlans == null
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomProgressWidget(),
              ],
            ))
          : model.paymentPlans.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('No payment plan'),
                      Text('Payment plan makes your service more affordable.'),
                      SizedBox(height: 10),
                      RaisedButton(
                        onPressed: () => Navigator.pushNamed(
                            context, AddNewPaymentPlan.ROUTE),
                        color: CustomColor.uplanitBlue,
                        child: Text(
                          'Add new',
                          style: GoogleFonts.workSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Enable desired payment plan',
                      style: GoogleFonts.workSans(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.paymentPlans.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) =>
                          _buildPaymentPlan(context, index, model.paymentPlans),
                    ),
                  ],
                ),
    );
  }

  _buildPaymentPlan(
      BuildContext context, int index, List<BasePaymentPlan> plans) {
    BasePaymentPlan paymentPlan = plans[index];
    print('plan active: ${paymentPlan.plan.live}');
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {},
            leading: model.activating
                ? Text('...', style: TextStyle(fontSize: 22))
                : CustomFlatCheckBox(
                    isChecked: paymentPlan.plan.live == null
                        ? false
                        : paymentPlan.plan.live,
                    onChanged: (bool value) async {
                      model.setActivating(true);
                      if (value) {
                        PaymentPlanResponse response = await model
                            .activatePaymentPlan(paymentPlan.plan.id);
                        if (response != null) {
                          plans[index].plan.live = response.plan.live;
                        }
                      } else {
                        PaymentPlanResponse response = await model
                            .deactivatePaymentPlan(paymentPlan.plan.id);
                        if (response != null) {
                          plans[index].plan.live = response.plan.live;
                        }
                      }
                      model.setActivating(false);
                    },
                  ),
            title: Text(
              paymentPlan.plan.name,
              style: GoogleFonts.workSans(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            subtitle: Row(
              children: [
                Text('${paymentPlan.plan.interval} days interval',
                    style: GoogleFonts.workSans(
                      color: Colors.grey,
                      fontSize: 12.0,
                    )),
                SizedBox(width: 16),
                Text('|',
                    style: GoogleFonts.workSans(
                      color: Colors.grey,
                      fontSize: 12.0,
                    )),
                SizedBox(width: 16),
                Text(
                    'every ${paymentPlan.plan.preferredPaymentDay}${HelperUtil.getDayOfMonthSuffix(paymentPlan.plan.preferredPaymentDay)}',
                    style: GoogleFonts.workSans(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ))
              ],
            ),
            trailing: InkWell(
              onTap: () {},
              child: Text('edit'),
            ),
          ),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
