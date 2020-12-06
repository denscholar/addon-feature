class AtedAtWithDay {
  AtedAtWithDay({
    this.year,
    this.month,
    this.day,
    this.hour,
    this.minute,
    this.second,
    this.nanosecond,
    this.timeZoneOffsetSeconds,
    this.timeZoneId,
  });

  Day year;
  Day month;
  Day day;
  Day hour;
  Day minute;
  Day second;
  Day nanosecond;
  Day timeZoneOffsetSeconds;
  dynamic timeZoneId;

  factory AtedAtWithDay.fromJson(Map<String, dynamic> json) =>
      AtedAtWithDay(
        year: json["year"] != null ? Day.fromJson(json["year"]) : null,
        month: json["month"] != null ? Day.fromJson(json["month"]) : null,
        day: json["day"] != null ? Day.fromJson(json["day"]) : null,
        hour: json["hour"] != null ? Day.fromJson(json["hour"]) : null,
        minute: json["minute"] != null ? Day.fromJson(json["minute"]) : null,
        second: json["second"] != null ? Day.fromJson(json["second"]) : null,
        nanosecond: json["nanosecond"] != null ? Day.fromJson(json["nanosecond"]) : null,
        timeZoneOffsetSeconds: json["timeZoneOffsetSeconds"] != null ? Day.fromJson(json["timeZoneOffsetSeconds"]) : null,
        timeZoneId: json["timeZoneId"],
      );

  Map<String, dynamic> toJson() => {
        "year": year.toJson(),
        "month": month.toJson(),
        "day": day.toJson(),
        "hour": hour.toJson(),
        "minute": minute.toJson(),
        "second": second.toJson(),
        "nanosecond": nanosecond.toJson(),
        "timeZoneOffsetSeconds": timeZoneOffsetSeconds.toJson(),
        "timeZoneId": timeZoneId,
      };
}

class Day {
  Day({
    this.low, 
    this.high,
  });

  int low;
  int high;

  factory Day.fromJson(Map<String, int> json) => Day(
        low: json["low"],
        high: json["high"],
      );

  Map<String, dynamic> toJson() => {
        "low": low,
        "high": high,
      };
}
