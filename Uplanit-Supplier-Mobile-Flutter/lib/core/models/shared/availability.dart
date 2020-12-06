import 'dart:convert';

List<Availability> listAvailabilityFromJson(String str) => List<Availability>.from(json.decode(str).map((x) => Availability.fromJson(x)));
String listAvailabilityToJson(List<Availability> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Availability availabilityFromJson(String str) => Availability.fromJson(json.decode(str));
String availabilityToJson(Availability data) => json.encode(data.toJson());

class Availability {
    Availability({
        this.year,
        this.month,
        this.day,
    });

    int year;
    int month;
    int day;

    factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        year: json["year"] != null ? json["year"] : null,
        month: json["month"] != null ? json["month"] : null,
        day: json["day"] != null ? json["day"] : null,
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "day": day,
    };
}
