import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/models/business_info/business_info_response.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';
import 'package:uplanit_supplier/core/viewmodels/business_info_model.dart';
import 'package:uplanit_supplier/core/viewmodels/business_profile_model.dart';
import 'package:uplanit_supplier/ui/shared/profile_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uplanit_supplier/ui/views/business_profile/profile_image.dart';
import 'package:uplanit_supplier/ui/widgets/custom_button.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textfield.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textfield.dart';

class BusinessInfoPage extends StatelessWidget {
  static const String ROUTE = '/business_info/business_info';
  BusinessInfoModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<BusinessInfoModel>(context);
    return Scaffold(
      appBar: profileAppBar(
        context: context,
        title: 'Business Info',
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 30, right: 20.0),
        child: ListView(
          children: [
            ReactiveForm(
              formGroup: model.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      'Business information helps provide more information  about your business and company details. This information will be provided in invoices sent out from uplanit',
                      style: GoogleFonts.workSans(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left),
                  SizedBox(height: 20),
                  Text(
                    'What will you be trading as?',
                    style: GoogleFonts.workSans(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ReactiveDropdownField<String>(
                    formControlName: 'selected',
                    items: model.businessTypes.map((String type) {
                      return DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: GoogleFonts.workSans(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ));
                    }).toList(),
                    onChanged: (String selectedBusinessType) {
                      model.setSelectedBusinessType(selectedBusinessType);
                    },
                  ),
                  SizedBox(height: 10),
                  model.infoLoading ? CustomProgressWidget() : Container(),
                  model.isSoleTraderSelected == null
                      ? Container()
                      : FormWidget(),
                  //End form
                  SizedBox(height: 40),
                  ReactiveFormConsumer(
                    builder: (context, form, child) => CustomButton(
                      onPressed: () async {
                        HelperUtil.dismissKeyboard(context);
                        model.setSubmitLoading(true);
                        BusinessInfoResponse response =
                            await model.createBusinessInfo(form.value);
                        model.setSubmitLoading(false);
                        if (response != null) {
                          form
                              .control('selected')
                              .markAsDisabled(); //Disable the dropdown
                        }
                      },
                      title: 'Save',
                      disabled: !form.valid,
                      loading: model.submitLoading,
                      style: GoogleFonts.workSans(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormWidget extends StatelessWidget {
  FormWidget({
    Key key,
  }) : super(key: key);

  BusinessInfoModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<BusinessInfoModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        model.isSoleTraderSelected
            ? Container()
            : Text(
                'Registered Company Name',
                style: GoogleFonts.workSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
        model.isSoleTraderSelected
            ? Container()
            : CustomReactiveTextField(
                keyboardType: TextInputType.text,
                color: Colors.black,
                formControlName: 'company_name',
              ),
        model.isSoleTraderSelected ? Container() : SizedBox(height: 20),
        model.isSoleTraderSelected
            ? Container()
            : Text(
                'Company Number',
                style: GoogleFonts.workSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
        model.isSoleTraderSelected
            ? Container()
            : CustomReactiveTextField(
                keyboardType: TextInputType.text,
                color: Colors.black,
                formControlName: 'company_number',
              ),
        model.isSoleTraderSelected ? Container() : SizedBox(height: 20),
        Text(
          'Business Representative',
          style: GoogleFonts.workSans(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        CustomReactiveTextField(
          keyboardType: TextInputType.text,
          color: Colors.black,
          formControlName: 'contact_name',
        ),
        SizedBox(height: 20),
        Text(
          'Contact Number',
          style: GoogleFonts.workSans(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        CustomReactiveTextField(
          keyboardType: TextInputType.number,
          color: Colors.black,
          formControlName: 'contact_number',
        ),
        SizedBox(height: 20),
        model.isSoleTraderSelected
            ? Container()
            : Text(
                'VAT Number',
                style: GoogleFonts.workSans(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
        model.isSoleTraderSelected
            ? Container()
            : CustomReactiveTextField(
                keyboardType: TextInputType.number,
                color: Colors.black,
                formControlName: 'vat_number',
              ),
      ],
    );
  }
}
