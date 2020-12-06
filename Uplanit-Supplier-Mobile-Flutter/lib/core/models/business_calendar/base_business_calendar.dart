import 'dart:convert';

import 'package:uplanit_supplier/core/models/business_profile/contact.dart';
import 'package:uplanit_supplier/core/models/shared/availability.dart';

import './event.dart';

BaseBusinessCalendar baseBusinessCalendarFromJson(String str) =>
    BaseBusinessCalendar.fromJson(json.decode(str));

String baseBusinessCalendarToJson(BaseBusinessCalendar data) =>
    json.encode(data.toJson());

class BaseBusinessCalendar {
  BaseBusinessCalendar({
    this.profile,
    this.availability,
    this.events,
    this.bookings,
    this.workTime,
  });

  Profile profile;
  List<Availability> availability;
  List<Event> events;
  List<dynamic> bookings;
  WorkTime workTime;

  factory BaseBusinessCalendar.fromJson(Map<String, dynamic> json) =>
      BaseBusinessCalendar(
        profile: Profile.fromJson(json["profile"]),
        availability: List<Availability>.from(
            json["availability"].map((x) => Availability.fromJson(x))),
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
        bookings: List<dynamic>.from(json["bookings"].map((x) => x)),
        workTime: WorkTime.fromJson(json["work_time"]),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "availability": List<dynamic>.from(availability.map((x) => x.toJson())),
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
        "bookings": List<dynamic>.from(bookings.map((x) => x)),
        "work_time": workTime.toJson(),
      };
}

class Profile {
  Profile({
    this.name,
    this.permalink,
    this.vendorId,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.verified,
  });

  String name;
  String permalink;
  String vendorId;
  String description;
  AtedAt createdAt;
  AtedAt updatedAt;
  bool verified;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"],
        permalink: json["permalink"],
        vendorId: json["vendor_id"],
        description: json["description"],
        createdAt: AtedAt.fromJson(json["created_at"]),
        updatedAt: AtedAt.fromJson(json["updated_at"]),
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "permalink": permalink,
        "vendor_id": vendorId,
        "description": description,
        "created_at": createdAt.toJson(),
        "updated_at": updatedAt.toJson(),
        "verified": verified,
      };
}

class WorkTime {
  WorkTime({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday
  });

  Day monday;
  Day tuesday;
  Day wednesday;
  Day thursday;
  Day friday;
  Day saturday;
  Day sunday;

  factory WorkTime.fromJson(Map<String, dynamic> json) => WorkTime(
        monday: json["monday"] != null ? Day.fromJson(json["monday"]) : null,
        tuesday: json["tuesday"] != null ? Day.fromJson(json["tuesday"]) : null,
        wednesday: json["wednesday"] != null ? Day.fromJson(json["wednesday"]) : null,
        thursday: json["thursday"] != null ? Day.fromJson(json["thursday"]) : null,
        friday: json["friday"] != null ? Day.fromJson(json["friday"]) : null,
        saturday: json["saturday"] != null ? Day.fromJson(json["saturday"]) : null,
        sunday: json["sunday"] != null ? Day.fromJson(json["sunday"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "monday": monday.toJson(),
        "tuesday": tuesday.toJson(),
        "wednesday": wednesday.toJson(),
        "thursday": thursday.toJson(),
        "friday": friday.toJson(),
        "saturday": saturday.toJson(),
        "sunday": sunday.toJson(),
      };
  @override 
  String toString(){
    return '{monday: ${monday?.toJson()}, tuesday: ${tuesday?.toJson()},wednesday: ${wednesday?.toJson()}, thursday: ${thursday?.toJson()},friday: ${friday?.toJson()},saturday: ${saturday?.toJson()},sunday: ${sunday?.toJson()}';
  }
}

class Day {
  Day({
    this.open,
    this.close,
  });

  Close open;
  Close close;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        open: Close.fromJson(json["open"]),
        close: Close.fromJson(json["close"]),
      );

  Map<String, dynamic> toJson() => {
        "open": open.toJson(),
        "close": close.toJson(),
      };
}

class Close {
  Close({
    this.hour,
    this.minute,
    this.nanosecond,
    this.second,
    this.timeZoneOffsetSeconds,
  });

  int hour;
  int minute;
  int nanosecond;
  int second;
  int timeZoneOffsetSeconds;

  factory Close.fromJson(Map<String, dynamic> json) => Close(
        hour: json["hour"],
        minute: json["minute"],
        nanosecond: json["nanosecond"],
        second: json["second"],
        timeZoneOffsetSeconds: json["timeZoneOffsetSeconds"],
      );

  Map<String, dynamic> toJson() => {
        "hour": hour,
        "minute": minute,
        "nanosecond": nanosecond,
        "second": second,
        "timeZoneOffsetSeconds": timeZoneOffsetSeconds,
      };
}
