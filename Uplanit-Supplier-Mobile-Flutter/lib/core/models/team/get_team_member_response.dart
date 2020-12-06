import 'dart:convert';

import 'package:uplanit_supplier/core/models/shared/ated_at.dart';
import 'package:uplanit_supplier/core/models/shared/ated_at_with_day.dart';
import 'package:uplanit_supplier/core/models/shared/availability.dart';

List<GetTeamMemberResponse> getTeamMemberResponseFromJson(String str) =>
    List<GetTeamMemberResponse>.from(
        json.decode(str).map((x) => GetTeamMemberResponse.fromJson(x)));
String getTeamMemberResponseToJson(List<GetTeamMemberResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

GetTeamMemberResponse getOneTeamMemberResponseFromJson(String str) =>
    GetTeamMemberResponse.fromJson(json.decode(str));
String getOneTeamMemberResponseToJson(GetTeamMemberResponse data) =>
    json.encode(data.toJson());

class GetTeamMemberResponse {
  GetTeamMemberResponse({
    this.provider,
    this.image,
    this.services,
    this.availability,
  });

  TeamProvider provider;
  TeamImage image;
  List<dynamic> services;
  List<Availability> availability;

  factory GetTeamMemberResponse.fromJson(Map<String, dynamic> json) {
    print('availability response: ${json['availability']}');
    return GetTeamMemberResponse(
      provider: json['provider'] != null
          ? TeamProvider.fromJson(json["provider"])
          : null,
      image: json['image'] != null ? TeamImage.fromJson(json["image"]) : null,
      services: json['services'] != null
          ? List<dynamic>.from(json["services"].map((x) => x))
          : [],
      availability: json['availability'] != null
          ? List<Availability>.from(json["availability"].map((x) => Availability.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "provider": provider.toJson(),
        "image": image.toJson(),
        "services": List<dynamic>.from(services.map((x) => x)),
        "availability": List<dynamic>.from(availability.map((x) => x.toJson())),
      };
}

class TeamImage {
  TeamImage({
    this.path,
    this.updatedAt,
    this.vendorId,
    this.name,
    this.createdAt,
    this.path1M,
    this.imageId,
    this.id,
    this.key,
    this.tags,
  });

  String path;
  AtedAtWithDay updatedAt;
  String vendorId;
  String name;
  AtedAtWithDay createdAt;
  String path1M;
  String imageId;
  String id;
  String key;
  List<String> tags;

  factory TeamImage.fromJson(Map<String, dynamic> json) => TeamImage(
        path: json["path"] != null ? json["path"] : null,
        // updatedAt: json['updated_at'] != null ? AtedAtWithDay.fromJson(json["updated_at"]) : null,
        vendorId: json['vendor_id'] != null ? json["vendor_id"] : null,
        name: json['name'] != null ? json["name"] : null,
        // createdAt: json['created_at'] != null ? AtedAtWithDay.fromJson(json["created_at"]) : null,
        path1M: json['path1m'] != null ? json["path1m"] : null,
        imageId: json['id'] != null ? json["id"] : null,
        id: json['_id'] != null ? json["_id"] : null,
        key: json["key"] != null ? json["key"] : null,
        tags: json['tags'] != null
            ? List<String>.from(json["tags"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "updated_at": updatedAt.toJson(),
        "vendor_id": vendorId,
        "name": name,
        "created_at": createdAt.toJson(),
        "path1m": path1M,
        "id": imageId,
        "_id": id,
        "key": key,
        "tags": List<dynamic>.from(tags.map((x) => x)),
      };
}

class TeamProvider {
  TeamProvider({
    this.updatedAt,
    this.gender,
    this.vendorId,
    this.name,
    this.createdAt,
    this.bio,
    this.active,
    this.providerId,
    this.id,
  });

  AtedAt updatedAt;
  String gender;
  String vendorId;
  String name;
  AtedAt createdAt;
  String bio;
  bool active;
  String providerId;
  String id;

  factory TeamProvider.fromJson(Map<String, dynamic> json) => TeamProvider(
        updatedAt: AtedAt.fromJson(json["updated_at"]),
        gender: json["gender"],
        vendorId: json["vendor_id"],
        name: json["name"],
        createdAt: AtedAt.fromJson(json["created_at"]),
        bio: json["bio"],
        active: json["active"],
        providerId: json["id"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "updated_at": updatedAt.toJson(),
        "gender": gender,
        "vendor_id": vendorId,
        "name": name,
        "created_at": createdAt.toJson(),
        "bio": bio,
        "active": active,
        "id": providerId,
        "_id": id,
      };
}
