import 'dart:convert';

import 'package:uplanit_supplier/core/enums/request_type.dart';
import 'package:uplanit_supplier/core/models/service/base_service.dart';
import 'package:uplanit_supplier/core/models/service/currency_response.dart';
import 'package:uplanit_supplier/core/models/service/post_service.dart';
import 'package:uplanit_supplier/core/repository/api_repository.dart';
import 'package:uplanit_supplier/core/utils/api_endpoint_util.dart';

class ServicesService {
  ApiRepository apiRepository = ApiRepository();

  Future<List<BaseService>> getServices({String token}) async {
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.GET_SERVICES,
        token: token,
      );
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return getBaseServiceListFromJson(response.body);
      }
      return [];
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }

  Future<BaseService> createService(
      {PostService postService, String token}) async {
    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.CREATE_SERVICE,
        parameter: postServiceToJson(postService),
        token: token,
      );
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return getBaseServiceFromJson(response.body);
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }

  Future<List<CurrencyResponse>> getAllCurrencies({String token}) async {
    try {
      final response = await apiRepository.request(
          requestType: RequestType.GET,
          path: ApiEndpoint.GET_ALL_CURRENCIES,
          token: token);
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return getCurrencyResponseListFromJson(response.body);
      }
      return null;
    } catch (e) {
      print('Network error: $e');
    }
  }

  Future<CurrencyResponse> getMyCurrency({String token}) async {
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.GET_MY_CURRENCY,
        token: token,
      );
print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return getCurrencyResponseFromJson(response.body);
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }

  Future<CurrencyResponse> setTradingCurrency(
      {String currencyId, String token}) async {
    Map<String, String> data = {"currency_id": currencyId};
    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.SET_TRADING_CURRENCY,
        parameter: json.encode(data),
        token: token,
      );
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return getCurrencyResponseFromJson(response.body);
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }
}
