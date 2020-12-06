import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mime_type/mime_type.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:uplanit_supplier/core/models/shared/availability.dart';

import 'package:uplanit_supplier/core/models/team/get_team_member_response.dart';
import 'package:uplanit_supplier/core/models/team/post_team.dart';
import 'package:uplanit_supplier/core/models/team/team_response.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';
import 'package:uplanit_supplier/core/services/team_service.dart';
import 'package:uuid/uuid.dart';

class TeamModel extends BaseModel {
  TeamService teamService = locator<TeamService>();
  final form = FormGroup({
    "active": FormControl<bool>(validators: [Validators.required]),
    "bio": FormControl(validators: [Validators.required]),
    "gender": FormControl(validators: [Validators.required]),
    "image": FormControl(validators: [Validators.required]),
    "name": FormControl(validators: [Validators.required])
  });

  TeamModel() {
    init();
  }

  void init() async {
    _loadingMembers = true;
    _teamMembers = await getTeamMembers();
    _loadingMembers = false;
    notifyListeners();
  }

  List<GetTeamMemberResponse> _teamMembers;
  Map<int, dynamic> _availabilities = {};
  bool _loadingMembers;
  bool _isProviderImageUploading = false;
  String _providerImage;
  bool _submitting = false;
  bool _loadingAvailable = false;
  File _selectedFile;
  bool _fetching = false;
  bool _markMonthAvailableLoading = false;
  DateTime _selectedDateTime = DateTime.now();
  GetTeamMemberResponse _teamMember;

  Map<int, dynamic> get availabilities => _availabilities;
  List<GetTeamMemberResponse> get teamMembers => _teamMembers;
  bool get loadingMembers => _loadingMembers;
  bool get isProviderImageUploading => _isProviderImageUploading;
  String get providerImage => _providerImage;
  bool get submitting => _submitting;
  File get selectedFile => _selectedFile;
  bool get fetching => _fetching;
  bool get markMonthAvailableLoading => _markMonthAvailableLoading;
  bool get loadingAvailable => _loadingAvailable;
  DateTime get selectedDateTime => _selectedDateTime;
  GetTeamMemberResponse get teamMember => _teamMember;

  void setSelectedFile(File selectedFile) {
    _selectedFile = selectedFile;
    notifyListeners();
  }

  void setSelectedDateTime(DateTime date) {
    _selectedDateTime = date;
    notifyListeners();
  }

  void setFetching(bool loading) {
    _fetching = loading;
    notifyListeners();
  }

  void setLoadingAvailable(bool loading) {
    _loadingAvailable = loading;
    notifyListeners();
  }

  void setMarkMonthAvailableLoading(bool loading) {
    _markMonthAvailableLoading = loading;
    notifyListeners();
  }

  void setIsProviderImageUploading(bool loading) {
    _isProviderImageUploading = loading;
    notifyListeners();
  }

  void setProviderImage(String providerImage) {
    _providerImage = providerImage;

    notifyListeners();
  }

  void setSubmitting(bool submitting) {
    _submitting = submitting;
    notifyListeners();
  }

  void setAvailabilities(List<Availability> availabilities) {
    _availabilities = HelperUtil.parseAvailabilityToMap(availabilities);
    notifyListeners();
  }

  addAvailabilities(Availability availability) {
    _availabilities.addAll(HelperUtil.parseMap(availability));
    notifyListeners();
  }

  removeAvailabilities(Availability dt) {
    _availabilities.remove(dt);
    notifyListeners();
  }

  void setTeamMember(GetTeamMemberResponse teamMember) {
    _teamMember = teamMember;
    notifyListeners();
  }

  Future<List<GetTeamMemberResponse>> getTeamMembers() async {
    String token = await auth.user.getIdToken();
    return await teamService.getTeamMembers(token: token);
  }

  Future<void> getTeamMemberById({String providerId}) async {
    String token = await auth.user.getIdToken();

    print('provider id: $providerId');
    GetTeamMemberResponse response = await teamService.getTeamMemberById(
      id: providerId,
      token: token,
    );
    setTeamMember(response);
    form.patchValue({
      'name': response.provider.name,
      'bio': response.provider.bio,
      'active': response.provider.active,
      'gender': response.provider.gender,
      'image': response.image.path1M,
    });
    setProviderImage(response.image.path1M);
    print('response: ');
  }

  Future<List<Availability>> markMonthAsAvailableForTeamMember(
      {DateTime date, String providerId}) async {
    String token = await auth.user.getIdToken();
    return await teamService.markMonthAsAvailableForTeamMember(
      token: token,
      year: date.year,
      month: date.month,
      providerId: providerId,
    );
  }

  String get name => form.control('name').value;
  bool get active => form.control('active').value;
  String get bio => form.control('bio').value;
  String get gender => form.control('gender').value;
  String get image => form.control('image').value;

  Future<TeamResponse> createTeamMember() async {
    String token = await auth.user.getIdToken();

    String fileUploadURL = await getFileUploadURL(
      filename: image,
      type: mime(selectedFile.path),
    );
    print('file upload URL: $fileUploadURL');

    String responseFromS3 = await uploadFileToS3(
      url: fileUploadURL,
      file: selectedFile,
    );
    print('response from s3: $responseFromS3');
    print('image data: $image');

    return await teamService.createTeamMember(
      postTeam: PostTeam(
        active: active,
        name: name,
        bio: bio,
        gender: gender,
        image: image,
      ),
      token: token,
    );
  }

  Future<TeamResponse> updateTeamMember({String providerId}) async {
    String token = await auth.user.getIdToken();
    return await teamService.updateTeamMemberDetail(
      id: providerId,
      postTeam: PostTeam(
        active: active,
        name: name,
        bio: bio,
        gender: gender,
      ),
      token: token,
    );
  }

  Future<GetTeamMemberResponse> updateProviderImage({String providerId}) async {
    String token = await auth.user.getIdToken();

    String fileUploadURL = await getFileUploadURL(
      filename: image,
      type: mime(selectedFile.path),
    );
    print('file upload URL: $fileUploadURL');

    String responseFromS3 = await uploadFileToS3(
      url: fileUploadURL,
      file: selectedFile,
    );
    print('response from s3: $responseFromS3');
    print('image data: $image');
    return await teamService.updateProviderImage(
      token: token,
      providerId: providerId,
      filename: image,
    );
  }

  Future<Availability> setTeamMemberAvailable(
      {DateTime dt, String providerId}) async {
    String token = await auth.user.getIdToken();
    return await teamService.setTeamMemberAsAvailable(
      day: '${dt.day}',
      month: '${dt.month}',
      year: '${dt.year}',
      providerId: providerId,
      token: token,
    );
  }

  Future<Availability> setTeamMemberUnavailable(
      {DateTime dt, String providerId}) async {
    String token = await auth.user.getIdToken();
    return await teamService.setTeamMemberAsUnavailable(
      dateString: DateFormat('yyyy-M-d').format(dt),
      providerId: providerId,
      token: token,
    );
  }
}
