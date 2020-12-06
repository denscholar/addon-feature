import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/models/payment_plan/base_payment_plan.dart';
import 'package:uplanit_supplier/core/models/payment_plan/payment_plan_response.dart';
import 'package:uplanit_supplier/core/models/payment_plan/post_payment_plan.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/payment_plan_service.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class PaymentPlanModel extends BaseModel {
  AuthenticationService auth = locator<AuthenticationService>();
  PaymentPlanService paymentPlanService = locator<PaymentPlanService>();
  List<BasePaymentPlan> _paymentPlans;
  bool _isSubmitLoading = false;
  bool _activating = false;

  List<BasePaymentPlan> get paymentPlans => _paymentPlans;
  bool get isSubmitLoading => _isSubmitLoading;
  bool get activating => _activating;

  PaymentPlanModel() {
    getPaymentPlans();
  }

  void getPaymentPlans() async {
    String token = await auth.user.getIdToken();
    List<BasePaymentPlan> paymentPlans =
        await paymentPlanService.getPaymentPlans(token: token);
    _paymentPlans = paymentPlans;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isSubmitLoading = loading;
    notifyListeners();
  }

  void setActivating(bool activating) {
    _activating = activating;
    notifyListeners();
  }

  final form = FormGroup({
    'name': FormControl(validators: [Validators.required]),
    'min_cost': FormControl(validators: [Validators.required]),
    'down_payment': FormControl(validators: [Validators.required]),
    'interval': FormControl(validators: [Validators.required]),
    'preferred_payment_day': FormControl(validators: [Validators.required]),
    'number_of_payments': FormControl(validators: [Validators.required]),
    'refund': FormControl<bool>(value: false),
    'last_payment': FormControl(validators: [Validators.required]),
  });

  Future<PaymentPlanResponse> createPaymentPlan(
      Map<String, dynamic> data) async {
    print('post payment plan');
    String token = await auth.user.getIdToken();
    PostPaymentPlan postPaymentPlan = PostPaymentPlan.fromJson(data);
    return await paymentPlanService.createPaymentPlan(
        postPaymentPlan: postPaymentPlan, token: token);
  }

  Future<PaymentPlanResponse> activatePaymentPlan(String _id) async {
    String token = await auth.user.getIdToken();
    return await paymentPlanService.activatePaymentPlan(id: _id, token: token);
  }

  Future<PaymentPlanResponse> deactivatePaymentPlan(String _id) async {
    String token = await auth.user.getIdToken();
    return await paymentPlanService.deactivatePaymentPlan(id: _id, token: token);
  }
}
