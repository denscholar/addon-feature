import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/viewmodels/service_model.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textarea.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textfield.dart';
import 'package:uplanit_supplier/ui/widgets/custom_service_button.dart';

class AddTeamMemberDialog extends StatelessWidget {
  const AddTeamMemberDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Consumer<ServiceModel>(
      builder: (context, model, child) => ReactiveForm(
        formGroup: model.addTeamMemberForm,
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Add Team Member',
                            style: GoogleFonts.workSans(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.cancel_outlined,
                                  color: Colors.black54, size: 30),
                              onPressed: () => Navigator.pop(context)),
                        ],
                      ),
                      SizedBox(height: 24),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            'Click to upload photo',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.workSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Name',
                        style: GoogleFonts.workSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomReactiveTextField(
                        formControlName: 'name',
                        keyboardType: TextInputType.text,
                        validationMessages: (control) =>
                            {'required': 'enter your name'},
                      ),
                      Row(
                        children: [
                          Text(
                            'Gender',
                            style: GoogleFonts.workSans(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 24),
                          ReactiveCheckbox(
                            formControlName: 'gender',
                          ),
                          Text(
                            'Male',
                            style: GoogleFonts.workSans(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 4),
                          ReactiveCheckbox(
                            formControlName: 'gender',
                          ),
                          Text(
                            'Female',
                            style: GoogleFonts.workSans(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Bio',
                        style: GoogleFonts.workSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomReactiveTextArea(
                        formControlName: 'bio',
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
              ),
              CustomServiceButton(
                onTap: () {},
                title: 'Create profile',
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
