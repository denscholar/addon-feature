import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uplanit_supplier/core/enums/request_type.dart';
import 'package:uplanit_supplier/core/repository/api_repository.dart';
// import 'package:uplanit_supplier/core/utils/api_endpoint_util.dart';
import 'package:uplanit_supplier/core/utils/exception_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

class UtilityService{
  ApiRepository apiRepository = locator<ApiRepository>();
  //get file upload url
  Future<String> getFileUploadURL({
    @required String token,
    @required String dynamicURL,
  }) async {
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: dynamicURL,
        token: token,
      );
      if (response.statusCode == 200) {
        return response.body;
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: ${e.message}');
      return null;
    }
  }

  //upload to s3
  Future<String> uploadFileToS3({
    @required String url,
    @required File file,
  }) async {
    try {
      final response = await apiRepository.requestFile(
        requestType: RequestType.UPLOAD_IMAGE,
        path: url,
        file: file,
      );
      return response;
    } catch (e) {
      print('s3 Network error: ${e.message}');
      return "";
    }
  }

}