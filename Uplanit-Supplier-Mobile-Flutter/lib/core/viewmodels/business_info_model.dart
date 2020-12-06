import 'dart:async';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uplanit_supplier/core/models/business_info/business_info_response.dart';
import 'package:uplanit_supplier/core/models/business_info/post_business_info.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/business_info_service_info.dart';
import 'package:uplanit_supplier/core/shared/validation.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class BusinessInfoModel extends BaseModel {
  AuthenticationService auth = locator<AuthenticationService>();
  final BusinessInfoService businessInfoService =
      locator<BusinessInfoService>();

  BusinessInfoModel() {
    _init();
  }

  void _init() async {
    setInfoLoading(true);
    BusinessInfoResponse info = await getBusinessInfo();
    _businessInfo = info;
    if (info != null) {
      form.control('selected').markAsDisabled();
      switch (info.type) {
        case "c":
          form.control('selected').value = 'A sole trader';
          setSelectedBusinessType('A sole trader');

          break;
        case "s":
          form.control('selected').value = 'A registered Company';
          setSelectedBusinessType('A registered Company');
          break;
        default:
          print('null info');
      }
      updateFormValues(info);
    }
    setInfoLoading(false);
    notifyListeners();
  }

  BusinessInfoResponse _businessInfo;
  BusinessInfoResponse get businessInfo => _businessInfo;

  final FormGroup form = FormGroup({
    'company_name': FormControl(validators: [Validators.required]),
    'company_number': FormControl(validators: [Validators.required]),
    'contact_name': FormControl(validators: [Validators.required]),
    'contact_number': FormControl(validators: [Validators.required]),
    'type': FormControl(validators: [Validators.required]),
    'selected': FormControl(validators: [
      Validators.required
    ]), //exclusively not part of the posting data
    'vat_number': FormControl(validators: [Validators.required])
  });

  List<String> businessTypes = [
    '--Select--',
    'A sole trader',
    'A registered Company',
  ];

  String _selectedBusinessType = '--Select--';
  bool _isSoleTraderSelected;

  bool _submitLoading = false;
  bool _infoLoading = false;
  bool get submitLoading => _submitLoading;
  bool get infoLoading => _infoLoading;

  void setSubmitLoading(bool loading) {
    _submitLoading = loading;
    notifyListeners();
  }

  void setInfoLoading(bool loading) {
    _infoLoading = loading;
    notifyListeners();
  }

  String get selectedBusinessType => _selectedBusinessType;
  bool get isSoleTraderSelected => _isSoleTraderSelected;

  void setSelectedBusinessType(String type) {
    _selectedBusinessType = type;
    print('selected type: $type');
    if (_selectedBusinessType == '--Select--') {
      _isSoleTraderSelected = null;
    } else if (_selectedBusinessType == 'A sole trader') {
      form.control('type').value = 's';
      _isSoleTraderSelected = true;
      form.control('company_name').markAsDisabled();
      form.control('company_number').markAsDisabled();
      form.control('vat_number').markAsDisabled();
      form.control('company_name').reset();
      form.control('company_number').reset();
    } else {
      form.control('type').value = 'c';
      _isSoleTraderSelected = false;
      form.control('company_name').markAsEnabled();
      form.control('company_number').markAsEnabled();
      form.control('vat_number').markAsEnabled();
    }
    print('current type after changes: ${form.control("type").value}');
    notifyListeners();
  }

  updateFormValues(BusinessInfoResponse info) {
    form.patchValue({
      'company_name': info.companyName ?? '',
      'company_number': info.companyNumber ?? '',
      'contact_name': info.contactName,
      'contact_number': info.contactNumber,
      'vat_number': info.vatNumber ?? ''
    });
    notifyListeners();
  }

  Future<BusinessInfoResponse> getBusinessInfo() async {
    String token = await auth.user.getIdToken();
    return await businessInfoService.getBusinessInfo(token: token);
  }

  Future<BusinessInfoResponse> createBusinessInfo(
      Map<String, dynamic> data) async {
    print('data to be submitted: $data');
    String token = await auth.user.getIdToken();
    return await businessInfoService.createUpdateBusinessInfo(
      info: PostBusinessInfo(
        companyName: data['company_name'] ?? '',
        companyNumber: data['company_number'] ?? '',
        contactName: data['contact_name'],
        contactNumber: int.parse(data['contact_number']),
        type: data['type'],
        vatNumber: int.parse(data['vat_number']) ?? '',
      ),
      token: token,
    );
  }
}
