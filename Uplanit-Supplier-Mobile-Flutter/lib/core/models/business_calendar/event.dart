import 'dart:convert';

Event businessCalendarResponseFromJson(String str) => Event.fromJson(json.decode(str));

String businessCalendarResponseToJson(Event data) => json.encode(data.toJson());

class Event {
    Event({
        this.vendorId,
        this.start,
        this.end,
        this.id,
        this.businessCalendarResponseId,
        this.title,
    });

    String vendorId;
    StartEnd start;
    StartEnd end;
    String id;
    String businessCalendarResponseId;
    String title;

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        vendorId: json["vendor_id"],
        start: StartEnd.fromJson(json["start"]),
        end: StartEnd.fromJson(json["end"]),
        id: json["_id"],
        businessCalendarResponseId: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "start": start.toJson(),
        "end": end.toJson(),
        "_id": id,
        "id": businessCalendarResponseId,
        "title": title,
    };

    @override
    String toString(){
      return "{vendor_id: $vendorId, start: ${start.toJson()}, end: ${end.toJson()}, _id: $id, title: $title,}";
    }
}

class StartEnd {
    StartEnd({
        this.year,
        this.month,
        this.day,
        this.hour,
        this.minute,
        this.nanosecond,
        this.second,
        this.timeZoneId,
        this.timeZoneOffsetSeconds,
    });

    int year;
    int month;
    int day;
    int hour;
    int minute;
    int nanosecond;
    int second;
    dynamic timeZoneId;
    int timeZoneOffsetSeconds;

    factory StartEnd.fromJson(Map<String, dynamic> json) => StartEnd(
        year: json["year"],
        month: json["month"],
        day: json["day"],
        hour: json["hour"],
        minute: json["minute"],
        nanosecond: json["nanosecond"],
        second: json["second"],
        timeZoneId: json["timeZoneId"],
        timeZoneOffsetSeconds: json["timeZoneOffsetSeconds"],
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "day": day,
        "hour": hour,
        "minute": minute,
        "nanosecond": nanosecond,
        "second": second,
        "timeZoneId": timeZoneId,
        "timeZoneOffsetSeconds": timeZoneOffsetSeconds,
    };
}
