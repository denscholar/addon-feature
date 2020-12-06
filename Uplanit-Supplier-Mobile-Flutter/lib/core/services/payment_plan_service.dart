import 'package:uplanit_supplier/core/enums/request_type.dart';
import 'package:uplanit_supplier/core/models/payment_plan/base_payment_plan.dart';
import 'package:uplanit_supplier/core/models/payment_plan/payment_plan_response.dart';
import 'package:uplanit_supplier/core/models/payment_plan/post_payment_plan.dart';
import 'package:uplanit_supplier/core/repository/api_repository.dart';
import 'package:uplanit_supplier/core/utils/api_endpoint_util.dart';
import 'package:uplanit_supplier/core/utils/exception_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

class PaymentPlanService {
  ApiRepository apiRepository = locator<ApiRepository>();

  Future<List<BasePaymentPlan>> getPaymentPlans({String token}) async {
    print('==================GET PAYMENT PLANS===================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.GET_ALL_PAYMENT_PLAN,
        token: token,
      );
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return basePaymentPlanFromJson(response.body);
      } else if (response.statusCode == 404) {
        return [];
      }
      return returnResponse(response);
    } catch (e) {
      print('Network Error: $e');
    }
  }

  Future<List<BasePaymentPlan>> getOnePaymentPlan(
      {String id, String token}) async {
    print('==================GET ONE PAYMENT PLAN===================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.GET_ONE_PAYMENT_PLAN + '$id',
        token: token,
      );
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return basePaymentPlanFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network Error: $e');
    }
  }

  Future<PaymentPlanResponse> createPaymentPlan({
    PostPaymentPlan postPaymentPlan,
    String token,
  }) async {
    print('===================CREATE PAYMENT PLAN==========================');
    print('parameter: ${postPaymentPlan.toJson()}');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.CREATE_NEW_PAYMENT_PLAN,
        token: token,
        parameter: postPaymentPlanToJson(postPaymentPlan),
      );
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return paymentPlanResponseFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network Error: $e');
    }
  }

  Future<PaymentPlanResponse> activatePaymentPlan(
      {String id, String token}) async {
    print(
        '===================ACTIVATING PAYMENT PLAN==========================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.ACTIVATE_PAYMENT_PLAN + '$id',
        token: token,
      );
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return paymentPlanResponseFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network Error: $e');
    }
  }

  Future<PaymentPlanResponse> deactivatePaymentPlan(
      {String id, String token}) async {
    print(
        '===================DEACTIVATING PAYMENT PLAN==========================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.DEACTIVE_PAYMENT_PLAN + '$id',
        token: token,
      );
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return paymentPlanResponseFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network Error: $e');
    }
  }
}
