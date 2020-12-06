import 'package:uplanit_supplier/core/enums/request_type.dart';
import 'package:uplanit_supplier/core/models/business_info/business_info_response.dart';
import 'package:uplanit_supplier/core/models/business_info/post_business_info.dart';
import 'package:uplanit_supplier/core/repository/api_repository.dart';
import 'package:uplanit_supplier/core/utils/api_endpoint_util.dart';
import 'package:uplanit_supplier/core/utils/exception_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

class BusinessInfoService {
  ApiRepository apiRepository = locator<ApiRepository>();

  Future<BusinessInfoResponse> getBusinessInfo({String token}) async {
    print('=================GET BUSINESS INFO=================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.GET_BUSINESS_INFO,
        token: token,
      );
      if (response.statusCode == 200) {
        return businessInfoResponseFromJson(response.body);
      } else if (response.statusCode == 404) {
        //when there's no data,... as instructed by the backend
        return null;
      }
      return returnResponse(response);
    } catch (e) {
      print('Network Error: $e');
      return null;
    }
  }

  Future<BusinessInfoResponse> createUpdateBusinessInfo(
      {PostBusinessInfo info, String token}) async {
    print('==================CREATE UPDATE BUSINESS INFO=================');
    print('server data: ${postBusinessInfoToJson(info)}');
    try {
      final response = await apiRepository.request(
          requestType: RequestType.POST,
          path: ApiEndpoint.CREATE_UPDATE_BUSINESS_INFO,
          token: token,
          parameter: postBusinessInfoToJson(info));
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return businessInfoResponseFromJson(response.body);
      } else if (response.statusCode == 503) {
        //the figure/code is instructed from the backend
        //when there's no data,... as instructed by the backend
        return null;
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: $e');
    }
  }
}
