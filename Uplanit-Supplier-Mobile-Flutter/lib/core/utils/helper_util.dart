import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:uplanit_supplier/core/models/shared/availability.dart';

class HelperUtil {
  static List<String> getTimes() {
    //for work time
    var x = 30; //minutes interval
    List<String> times = []; // time array
    var tt = 0; // start time
//loop to increment the time and push results in array
    for (var i = 0; tt < 24 * 60; i++) {
      var hh = (tt / 60).floor(); // getting hours of day in 0-24 format
      var mm = (tt % 60).floor(); // getting minutes of the hour in 0-55 format

      String time =
          ('${hh < 10 ? '0$hh' : hh}:${mm < 10 ? '0$mm' : mm}'); // pushing data in array in [00:00 - 12:00 AM/PM format]
      times.add(time);

      tt = tt + x;
    }

    return times;
  }

  static List<String> getTimelines() {
    //for business calendar
    var x = 60; //minutes interval
    List<String> times = []; // time array
    var tt = 0; // start time
//loop to increment the time and push results in array
    for (var i = 0; tt < 24 * 60; i++) {
      var hh = (tt / 60).floor(); // getting hours of day in 0-24 format
      var mm = (tt % 60).floor(); // getting minutes of the hour in 0-55 format

      String time =
          ('${hh < 10 ? '0$hh' : hh}:${mm < 10 ? '0$mm' : mm}'); // pushing data in array in [00:00 - 12:00 AM/PM format]
      times.add(time);

      tt = tt + x;
    }

    return times;
  }

  static String leadingZero(int value) {
    return (value < 10) ? '0$value' : '$value';
  }

  static String capitalize(String string) {
    if (string == null) {
      throw ArgumentError.notNull('string');
    }

    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  static dismissKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static String getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch (dayNum % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static DateTime parseDateTime(Availability availability) {
    int year = availability.year;
    int month = availability.month;
    int day = availability.day;
    String dateString = '$year/$month/$day';

    DateTime dt = DateFormat('yyyy/M/d').parse(dateString);
    return dt;
  }

  static Map<int, dynamic> parseMap(Availability availability) {
    int year = availability.year;
    int month = availability.month;
    int day = availability.day;

    Map map = {
      year: {
        month: {day: {}}
      }
    };
    return map;
  }

  static DateTime parseEvent(year, month, day, hour, minute) {
    String dateString = '$year/$month/$day $hour:$minute';

    DateTime dt = DateFormat('yyyy/M/d h:m').parse(dateString);
    return dt;
  }

  static List<DateTime> parseAvailabilityToDateTime(
      List<Availability> availability) {
    List<DateTime> dtList = [];
    for (int i = 0; i < availability.length; i++) {
      int year = availability[i].year;
      int month = availability[i].month;
      int day = availability[i].day;
      String dateString = '$year/$month/$day';

      DateTime dt = DateFormat('yyyy/M/d').parse(dateString);
      dtList.add(dt);
    }
    return dtList;
  }

  static Map<int, dynamic> parseAvailabilityToMap(
      List<Availability> availability) {
    Map<int, Map<int, dynamic>> yearMap = {};
    Map<int, Map<int, dynamic>> monthMap = {};
    Map<int, dynamic> dayMap = {};

    for (int i = 0; i < availability.length; i++) {
      int year = availability[i].year;
      int month = availability[i].month;
      int day = availability[i].day;

      dayMap[day] = {};
      monthMap[month] = dayMap;
      yearMap[year] = monthMap;
    }
    return yearMap;
  }

  static showSnackBarError(BuildContext context) {
    // return Scaffold.of(context).showSnackBar(
    //   SnackBar(
    //     action: SnackBarAction(label: 'Close', onPressed: () {}),
    //     content:
    //         Text('An error occurred, please check your internet connection'),
    //   ),
    // );
    print('An error occurred, please check your internet connection');
  }
}
