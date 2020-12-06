import 'dart:convert';

List<CurrencyResponse> getCurrencyResponseListFromJson(String str) => List<CurrencyResponse>.from(json.decode(str).map((x) => CurrencyResponse.fromJson(x)));
String getCurrencyResponseListToJson(List<CurrencyResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

CurrencyResponse getCurrencyResponseFromJson(String str) => CurrencyResponse.fromJson(json.decode(str));
String getCurrencyResponseToJson(CurrencyResponse data) => json.encode(data.toJson());

class CurrencyResponse {
    CurrencyResponse({
        this.name,
        this.id,
        this.country,
        this.code,
        this.currencyResponseId,
        this.createdAt,
        this.updatedAt,
    });

    String name;
    String id;
    String country;
    String code;
    String currencyResponseId;
    AtedAt createdAt;
    AtedAt updatedAt;

    factory CurrencyResponse.fromJson(Map<String, dynamic> json) => CurrencyResponse(
        name: json["name"],
        id: json["_id"],
        country: json["country"],
        code: json["code"],
        currencyResponseId: json["id"],
        createdAt: AtedAt.fromJson(json["created_at"]),
        updatedAt: AtedAt.fromJson(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
        "country": country,
        "code": code,
        "id": currencyResponseId,
        "created_at": createdAt.toJson(),
        "updated_at": updatedAt.toJson(),
    };
}

class AtedAt {
    AtedAt({
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

    factory AtedAt.fromJson(Map<String, dynamic> json) => AtedAt(
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
