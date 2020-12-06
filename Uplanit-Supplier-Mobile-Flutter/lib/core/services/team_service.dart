import 'dart:convert';

import 'package:uplanit_supplier/core/models/shared/availability.dart';

import 'package:uplanit_supplier/core/repository/api_repository.dart';
import 'package:uplanit_supplier/core/utils/exception_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/enums/request_type.dart';
import 'package:uplanit_supplier/core/utils/api_endpoint_util.dart';
import 'package:uplanit_supplier/core/models/team/post_team.dart';
import 'package:uplanit_supplier/core/models/team/team_response.dart';
import 'package:uplanit_supplier/core/models/team/get_team_member_response.dart';

class TeamService {
  ApiRepository apiRepository = locator<ApiRepository>();

  Future<List<GetTeamMemberResponse>> getTeamMembers({String token}) async {
    print('==================GET TEAM MEMBERS=====================');
    print('token: $token');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.GET_TEAM,
        token: token,
      );
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return getTeamMemberResponseFromJson(response.body);
      }
      return [];
    } catch (e) {
      print('Network error: $e');
      return [];
    }
  }

  Future<GetTeamMemberResponse> getTeamMemberById(
      {String id, String token}) async {
    print('==================GET TEAM MEMBER BY ID=====================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.GET_TEAM_MEMBER_BY_ID + '$id',
        token: token,
      );
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return getOneTeamMemberResponseFromJson(response.body);
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }

  Future<TeamResponse> createTeamMember(
      {PostTeam postTeam, String token}) async {
    print('==================CREATE TEAM MEMBERS=====================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.CREATE_TEAM_MEMBER,
        token: token,
        parameter: postTeamToJson(postTeam),
      );
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return teamResponseFromJson(response.body);
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }

  Future<TeamResponse> updateTeamMemberDetail(
      {PostTeam postTeam, String id, String token}) async {
    print('==================UPDATE TEAM MEMBERS=====================');
    print('post data: ${postTeamToJson(postTeam)}');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.PATCH,
        path: ApiEndpoint.UPDATE_TEAM_MEMBER_DETAIL + '$id',
        token: token,
        parameter: postTeamToJson(postTeam),
      );
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return teamResponseFromJson(response.body);
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }

  Future<Availability> setTeamMemberAsAvailable(
      {String year,
      String month,
      String day,
      String providerId,
      String token}) async {
    print(
        '==================SET TEAM MEMBERS AS AVAILABLE=====================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.SET_TEAM_MEMBER_DAY_AS_AVAILABLE +
            '$year/$month/$day/$providerId',
        token: token,
      );
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return availabilityFromJson(response.body);
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }

  Future<Availability> setTeamMemberAsUnavailable(
      {String dateString, String providerId, String token}) async {
    print(
        '==================SET TEAM MEMBERS AS UNAVAILABLE=====================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.SET_TEAM_MEMBER_DAY_AS_UNAVAILABLE +
            '$dateString/$providerId',
        token: token,
      );
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return availabilityFromJson(response.body);
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }

  Future<List<Availability>> markMonthAsAvailableForTeamMember(
      {int year, int month, String providerId, String token}) async {
    print(
        '==================MARK MONTH AS AVAILABLE FOR TEAM MEMBER=====================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.MARK_MONTH_AS_AVAILABLE_FOR_TEAM_MEMBER +
            '$year/$month/$providerId',
        token: token,
      );
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return listAvailabilityFromJson(response.body);
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }

  Future<GetTeamMemberResponse> updateProviderImage(
      {String filename, String providerId, String token}) async {
    print('==================UPDATE PROVIDER IMAGE=====================');
    Map<String, String> data = {'image': filename};
    String body = json.encode(data);
    print('data: $body');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.UPDATE_PROVIDER_IMAGE + '$providerId',
        token: token,
        parameter: body,
      );
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return getOneTeamMemberResponseFromJson(response.body);
      }
      return returnResponse(response);
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }
}
