import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class MockSupplier {
  String name;
  MockSupplier({this.name});
}

class MockService {
  String name;
  double price;
  String image;
  MockService({this.name, this.price, this.image});
}

class MockServiceImage {
  String path;
  MockServiceImage({this.path});
}

List<MockSupplier> mockSuppliers = [
  MockSupplier(name: 'Louis Vitton'),
  MockSupplier(name: 'Louis Vitton'),
  MockSupplier(name: 'Louis Vitton'),
  MockSupplier(name: 'Louis Vitton'),
];

List<MockService> mockServices = [
  MockService(
      name: 'House Dressing',
      price: 450.0,
      image: 'assets/images/service01.png'),
  MockService(
      name: 'Dry cleaning services',
      price: 300.0,
      image: 'assets/images/service02.png'),
];
List<MockServiceImage> mockServiceImages = [
  MockServiceImage(path: 'https://source.unsplash.com/random/300x300'),
  MockServiceImage(path: 'https://source.unsplash.com/random/300x300'),
  MockServiceImage(path: 'https://source.unsplash.com/random/300x300'),
];

class ServiceModel extends BaseModel {
  final serviceDescriptionForm = FormGroup({
    'name': FormControl(validators: [Validators.required]),
    'description': FormControl(validators: [Validators.required])
  });
  final serviceCostForm = FormGroup({
    'cost': FormControl(validators: [Validators.required]),
    'reservation_fee': FormControl(validators: [Validators.required]),
    'down_payment': FormControl(validators: [Validators.required]),
    'service_duration': FormControl(validators: [Validators.required]),
    'notice_duration': FormControl(validators: [Validators.required]),
    'service_days': FormControl(),
    'notice_days': FormControl(),
  });
  final serviceDeliveryForm = FormGroup({
    'delivery_type': FormControl(validators: [Validators.required]),
    'refund_on_cancellation': FormControl<bool>(),
    'refund_validity': FormControl(),
    'refund_days_before_service_delivery': FormControl()
  });
  final addTeamMemberForm = FormGroup({
    'name': FormControl(),
    'gender': FormControl(),
    'bio': FormControl(),
    'image': FormControl(),
  });
  bool _loading = false;
  List _serviceList = [];

  bool get loading => _loading;
  List<dynamic> get serviceList => _serviceList;

  bool _serviceImagesLoading = false;
  List _services = mockServices;
  List<MockServiceImage> _serviceImages = mockServiceImages;
  List<MockSupplier> _suppliers = mockSuppliers;
  int _selectedTeamMemberIndex = -1;

  bool get serviceImagesLoading => _serviceImagesLoading;
  List<dynamic> get services => _services;
  List<MockServiceImage> get serviceImages => _serviceImages;
  List<MockSupplier> get suppliers => _suppliers;
  int get selectedTeamMemberIndex => _selectedTeamMemberIndex;

  setSelectedTeamMember(int index) {
    _selectedTeamMemberIndex = index;
    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setServiceImagesLoading(bool value) {
    _serviceImagesLoading = value;
    notifyListeners();
  }

  submitServiceDescriptionForm() {
    print('form value: ${serviceDescriptionForm.value}');
  }

  submitServiceCostAndDeliveryForm() {
    print('service cost and delivery form: ${serviceCostForm.value}');
  }

  uploadServiceImages() {
    print('upload service images');
  }
}
