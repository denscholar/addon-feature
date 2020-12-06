import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:uplanit_supplier/core/enums/request_type.dart';
import 'package:uplanit_supplier/core/models/business_calendar/base_business_calendar.dart';
import 'package:uplanit_supplier/core/models/business_calendar/event.dart';
import 'package:uplanit_supplier/core/models/shared/availability.dart';
import 'package:uplanit_supplier/core/repository/api_repository.dart';
import 'package:uplanit_supplier/core/utils/api_endpoint_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';

class BusinessCalendarService {
  ApiRepository apiRepository = locator<ApiRepository>();

  Future<BaseBusinessCalendar> getCalendar({String token}) async {
    print('==================GET CALENDAR===================');
    print('$token');
    try {
      final response = await apiRepository.request(
          requestType: RequestType.GET,
          path: ApiEndpoint.GET_CALENDAR,
          token: token);
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return baseBusinessCalendarFromJson(response.body);
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }

  Future<Availability> markDayAsAvailable({DateTime dt, String token}) async {
    print('==================MARK DAY AS AVAILABLE===================');
    int year = dt.year;
    int month = dt.month;
    int day = dt.day;
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.MARK_DAY_AS_AVAILABLE + '$year/$month/$day',
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

  Future<bool> unsetDayAsAvailable({DateTime dt, String token}) async {
    print('==================UNSET DAY AS AVAILABLE===================');
    String dateString = DateFormat('yyyy-M-d').format(dt);
    try {
      final response = await apiRepository.request(
        requestType: RequestType.GET,
        path: ApiEndpoint.UNSET_DAY_AVAILABILITY + '$dateString',
        token: token,
      );
      print('response object: $response');
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return true; //from the backend it returns 'true' as in boolean TRUE
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }

  //create event
  Future<Event> markAsBusy(
      {DateTime start, DateTime end, String token}) async {
    print('==================MARK AS BUSY===================');
    Map<String, String> data = {
      "start": start.toIso8601String(),
      "end": end.toIso8601String()
    };

    try {
      final response = await apiRepository.request(
        requestType: RequestType.POST,
        path: ApiEndpoint.MARK_AS_BUSY,
        parameter: json.encode(data),
        token: token,
      );
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return businessCalendarResponseFromJson(response.body);
      } else if (response.statusCode == 503) {
        print('cannot construct date from VALUE');
        return null;
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }

  Future<Event> removeBusyTime(
      {String id, String token}) async {
    print('==================REMOVE BUSY TIME===================');
    try {
      final response = await apiRepository.request(
        requestType: RequestType.DELETE,
        path: ApiEndpoint.REMOVE_BUSY_TIME + '$id',
        token: token,
      );
      print('status: ${response.statusCode}');
      print('body: ${response.body}');
      if (response.statusCode == 200) {
        return businessCalendarResponseFromJson(response.body);
      } else if (response.statusCode == 404) {
        print('The requested calendar event was not found');
        return null;
      }
      return null;
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }
}
