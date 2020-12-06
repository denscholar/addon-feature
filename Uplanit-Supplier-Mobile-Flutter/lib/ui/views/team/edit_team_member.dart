import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
// import 'package:uplanit_calendar/uplanit_calendar.dart';

import 'package:uplanit_supplier/core/models/shared/availability.dart';

import 'package:uplanit_supplier/core/models/team/get_team_member_response.dart';
import 'package:uplanit_supplier/core/models/team/team_response.dart';
import 'package:uplanit_supplier/core/utils/filehandler_util.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';
import 'package:uplanit_supplier/core/viewmodels/team_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/default_app_bar.dart';
import 'package:uplanit_supplier/ui/views/business_calendar/test/calendar_view.dart';
import 'package:uplanit_supplier/ui/widgets/custom_button.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';
import 'package:uplanit_supplier/ui/widgets/custom_radio.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textarea.dart';
import 'package:uplanit_supplier/ui/widgets/custom_reactive_textfield.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textarea.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textfield.dart';
import 'package:uuid/uuid.dart';

class EditTeamDetail {
  final String providerId;
  final List<Availability> availability;

  EditTeamDetail({this.providerId, this.availability});
}

class EditTeamDetailPage extends StatefulWidget {
  static const String ROUTE = '/team/edit_team_detail';
  final String id;
  final List<Availability> availabilities;
  EditTeamDetailPage({
    Key key,
    this.id,
    this.availabilities,
  }) : super(key: key);

  @override
  _EditTeamDetailPageState createState() => _EditTeamDetailPageState();
}

class _EditTeamDetailPageState extends State<EditTeamDetailPage> {
  File _selectedFile;

  TeamModel model;

  @override
  void initState() {
    super.initState();
    model = Provider.of(context, listen: false);
    model.setAvailabilities(widget.availabilities);
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<TeamModel>(context);

    return FutureProvider(
      lazy: false,
      create: (_) => model.getTeamMemberById(
        providerId: widget.id,
      ),
      catchError: (context, error) {
        print('$error');
        return null;
      },
      child: Scaffold(
        appBar: defaultAppBar(
          context: context,
          title:
              '${model.teamMember != null ? model.teamMember.provider.name : ""}',
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 44),
              model.availabilities != null && model.availabilities.length > 0
                  ? Container()
                  : Center(
                      child: InkWell(
                        onTap: () async {
                          print(
                              'markedavailabecallbalck: ${model.setSelectedDateTime}');
                          model.setMarkMonthAvailableLoading(true);
                          List<Availability> response =
                              await model.markMonthAsAvailableForTeamMember(
                            date: model.selectedDateTime,
                            providerId: widget.id,
                          );
                          if (response != null) {
                            print('marked month as available');
                          }
                          model.setMarkMonthAvailableLoading(false);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: model.markMonthAvailableLoading
                              ? CustomProgressWidget(
                                  color: CustomColor.primaryColor,
                                )
                              : Text(
                                  'Mark ${DateFormat('MMMM').format(model.selectedDateTime)} as available',
                                ),
                        ),
                      ),
                    ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 4),
                child: UplanitCalendarView(
                  primaryColor: CustomColor.primaryColor,
                  availabilities:
                      model.availabilities, //the available days for provider
                  onDateChanged: (date) {
                    model.setSelectedDateTime(date);
                  },
                  onDateSelected: (date, events) {
                    print('date selected: $date & $events');
                  },
                  onSwitchChanged: (value) {
                    print('switch changed: $value');
                    if (value) {}
                  },
                  loadingAvailable: model.loadingAvailable,
                  updateMemberAvailable: (DateTime dt) async {
                    print('update dt: ${DateFormat('yyyy-M-d').format(dt)}');
                    model.setLoadingAvailable(true);
                    Availability response = await model.setTeamMemberAvailable(
                      dt: dt,
                      providerId: widget.id,
                    );
                    if (response != null) {
                      print(
                          'response for teamMember available day: ${response.month} ${response.day} ${response.year}');
                      model.addAvailabilities(response);
                    }
                    model.setLoadingAvailable(false);
                  },
                  updateMemberUnavailable: (DateTime dt) async {
                    print('update dt; $dt');
                    model.setLoadingAvailable(true);
                    Availability response =
                        await model.setTeamMemberUnavailable(
                            dt: dt, providerId: widget.id);
                    if (response != null) {
                      print(
                          'response for teamMember unavailable day: ${response.month} ${response.day} ${response.year}');
                      model.removeAvailabilities(response);
                    }
                    model.setLoadingAvailable(false);
                  },
                  showMemberAvailableBox: true,
                ),
              ),
              SizedBox(height: 24),
              ReactiveForm(
                formGroup: model.form,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 150,
                          padding: EdgeInsets.all(8),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: Stack(
                            children: [
                              Container(
                                child: model.selectedFile != null
                                    ? Image.asset(
                                        model.selectedFile.path,
                                        fit: BoxFit.cover,
                                      )
                                    : model.providerImage != null
                                        ? Image.network(model.image,
                                            fit: BoxFit.cover)
                                        : Image.asset(
                                            'assets/images/team_img.png'),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: InkWell(
                                  onTap: () async =>
                                      await uploadProviderImage(model),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom: 36,
                                      top: 10,
                                    ),
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
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
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
                          SizedBox(width: 4),
                          ReactiveRadio(
                            formControlName: 'gender',
                            value: 'Female',
                            activeColor: CustomColor.uplanitBlue,
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
                                  TeamResponse response = await model
                                      .updateTeamMember(providerId: widget.id);
                                  if (response != null) {
                                    print(
                                        'provider id: ${response.provider.id}');
                                    Navigator.pop(context);
                                    await model.getTeamMembers();
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
      ),
    );
  }

  Future<void> uploadProviderImage(TeamModel model) async {
    _selectedFile = await FileHandlerUtil.handlePickImage();
    //operation was cancelled by user
    if (_selectedFile == null) return;

    model.setIsProviderImageUploading(true);
    String filePath = _selectedFile.path;
    // model.setLogo(filePath);
    String generatedUuid = Uuid().v4();
    String fileExtension = FileHandlerUtil.getExtension(filePath);

    String filename = '$generatedUuid$fileExtension';
    print('filename: $filename');
    //1. get the file upload url
    String fileUploadURL = await model.getFileUploadURL(
      filename: filename,
      type: mime(filePath),
    );
    print('file upload URL: $fileUploadURL');

    // //2. upload file to s3
    String responseFromS3 = await model.uploadFileToS3(
      url: fileUploadURL,
      file: _selectedFile,
    );
    print('response from s3: $responseFromS3');
    //3. Update cover image
    String providerId = Uuid().v4();
    GetTeamMemberResponse response = await model.updateProviderImage(
      providerId: providerId,
    );
    print('uploaded with provider image: ${response.image.path}');

    model.setProviderImage(filename);
    model.setIsProviderImageUploading(false);
  }
}
