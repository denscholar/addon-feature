import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
// import 'package:uplanit_calendar/uplanit_calendar.dart';
import 'package:uplanit_supplier/core/models/team/get_team_member_response.dart';
import 'package:uplanit_supplier/core/models/team/team_response.dart';
import 'package:uplanit_supplier/core/utils/filehandler_util.dart';
import 'package:uplanit_supplier/core/viewmodels/team_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/default_app_bar.dart';
import 'package:uplanit_supplier/ui/widgets/custom_button.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';
import 'package:uplanit_supplier/ui/widgets/custom_radio.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textarea.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textfield.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textarea.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textfield.dart';
import 'package:uuid/uuid.dart';

class TeamDetailPage extends StatelessWidget {
  static const String ROUTE = '/team/team_detail';

  TeamDetailPage({
    Key key,
  }) : super(key: key);
  File _selectedFile;
  TeamModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<TeamModel>(context);
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: 'Add a team member',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReactiveForm(
              formGroup: model.form,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    // color: Colors.grey.withOpacity(.2),
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 120,
                        clipBehavior: Clip.antiAlias,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          overflow: Overflow.visible,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: model.selectedFile != null
                                  ? Image.asset(
                                      model.selectedFile.path,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset('assets/images/team_img.png'),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: InkWell(
                                onTap: () async =>
                                    await uploadProviderImage(model),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFECECEC),
                                  ),
                                  child: Text(
                                    'Change Image',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.workSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            model.isProviderImageUploading
                                ? CustomProgressWidget()
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Name',
                      style: GoogleFonts.workSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomReactiveTextField(
                      formControlName: 'name',
                      color: Colors.black54,
                      keyboardType: TextInputType.text,
                      fontSize: 14.0,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Gender',
                          style: GoogleFonts.workSans(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 10),
                        ReactiveRadio(
                          formControlName: 'gender',
                          value: 'Male',
                          activeColor: CustomColor.uplanitBlue,
                        ),
                        Text(
                          'Male',
                          style: GoogleFonts.workSans(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 4),
                        ReactiveRadio(
                          formControlName: 'gender',
                          value: 'Female',
                          activeColor: CustomColor.uplanitBlue,
                        ),
                        Text(
                          'Female',
                          style: GoogleFonts.workSans(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Bio',
                      style: GoogleFonts.workSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomReactiveTextArea(
                      formControlName: 'bio',
                      maxLines: 2,
                      fontSize: 16,
                      keyboardType: TextInputType.text,
                      color: Colors.black54,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        ReactiveCheckbox(
                          formControlName: 'active',
                          activeColor: CustomColor.uplanitBlue,
                          checkColor: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Activate team member on create',
                          style: GoogleFonts.workSans(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4),
                    ReactiveFormConsumer(
                      builder: (context, form, child) => CustomButton(
                        title: 'Update',
                        style: GoogleFonts.workSans(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                        disabled: !form.valid,
                        loading: model.submitting,
                        onPressed: !form.valid || model.submitting
                            ? null
                            : () async {
                                model.setSubmitting(true);
                                TeamResponse response =
                                    await model.createTeamMember();
                                if (response != null) {
                                  print('provider id: ${response.provider.id}');
                                  Navigator.pop(context);
                                  model.init();
                                  // model.setTeamMember(res);
                                }
                                model.setSubmitting(false);
                              },
                      ),
                    ),
                    // SizedBox(height: 4),
                    // Text(
                    //   'Linked Service',
                    //   style: GoogleFonts.workSans(
                    //     fontSize: 16.0,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // Wrap(
                    //   children: [
                    //     Chip(
                    //       backgroundColor: Colors.black,
                    //       clipBehavior: Clip.antiAlias,
                    //       deleteButtonTooltipMessage: 'Remove service',
                    //       deleteIconColor: Colors.white,
                    //       deleteIcon: Icon(
                    //         Icons.cancel,
                    //         color: Colors.white,
                    //       ),
                    //       label: Text(
                    //         'Cake',
                    //         style: GoogleFonts.workSans(
                    //           color: Colors.white,
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadProviderImage(TeamModel model) async {
    _selectedFile = await FileHandlerUtil.handlePickImage();
    //operation was cancelled by user
    if (_selectedFile == null) return;

    String filePath = _selectedFile.path;
    // model.setLogo(filePath);
    String generatedUuid = Uuid().v4();
    String fileExtension = FileHandlerUtil.getExtension(filePath);

    String filename = '$generatedUuid$fileExtension';
    print('filename: $filename');
    model.setSelectedFile(_selectedFile);
    model.form.patchValue({'image': filename}); //update the form
  }
}
