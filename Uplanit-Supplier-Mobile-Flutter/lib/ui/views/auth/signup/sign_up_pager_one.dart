import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';

import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/core/viewmodels/auth_model.dart';
import 'package:uplanit_supplier/ui/widgets/custom_indicators.dart';
import 'package:uplanit_supplier/ui/widgets/custom_plain_textfield.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textfield.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textfield.dart';

import 'sign_up_pager_two.dart';

class SignUpPagerOne extends StatelessWidget {
  static const String ROUTE = '/auth/signup/signUpPagerOne';
  SignUpPagerOne({Key key}) : super(key: key);

  AuthModel authModel;

  @override
  Widget build(BuildContext context) {
    authModel = Provider.of<AuthModel>(context);
    return Scaffold(
      backgroundColor: CustomColor.primaryColor,
      body: ReactiveForm(
        formGroup: authModel.firstLastNameForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Container(
                        child: Text(
                          'Tell us about \nyourself',
                          style: GoogleFonts.workSans(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildForm(context),
                      //  Expanded(child: Container()),
                    ],
                  ),
                ),
              ),
            ),
            _buildIndicator(),
            ReactiveFormConsumer(
              builder: (context, form, child) => Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: !form.valid ? Colors.white70 : Colors.white,
                ),
                child: InkWell(
                  onTap: !form.valid
                      ? null
                      : () {
                          HelperUtil.dismissKeyboard(context);
                          authModel.goToSignUpPagerTwo();
                          Navigator.pushNamed(
                            context,
                            SignUpPagerTwo.ROUTE,
                          );
                        },
                  child: Center(
                    child: Text(
                      'Next',
                      style: GoogleFonts.workSans(
                        fontSize: 22.0,
                        color: CustomColor.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 40,
        left: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildForm(BuildContext context) {
    authModel = Provider.of<AuthModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FIRST NAME',
          style: GoogleFonts.workSans(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        CustomReactiveTextField(
          formControlName: 'first_name',
          keyboardType: TextInputType.text,
          validationMessages: (control) =>
              {'required': 'Enter your first name'},
          color: Colors.white,
          fontSize: 16,
        ),
        SizedBox(height: 20),
        Text(
          'LAST NAME',
          style: GoogleFonts.workSans(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        CustomReactiveTextField(
          formControlName: 'last_name',
          keyboardType: TextInputType.text,
          validationMessages: (control) => {'required': 'Enter your last name'},
          fontSize: 16,
          color: Colors.white,
        ),
        SizedBox(height: 20),
      ],
    );
  }

  _buildIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BorderedDot(),
          SizedBox(width: 2),
          SimpleLine(),
          SizedBox(width: 2),
          SimpleDot(),
          SizedBox(width: 2),
          SimpleLine(),
          SizedBox(width: 2),
          SimpleDot(),
        ],
      ),
    );
  }
}
