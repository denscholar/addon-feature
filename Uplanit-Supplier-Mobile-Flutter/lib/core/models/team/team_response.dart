import 'dart:convert';

import '../shared/ated_at.dart';

TeamResponse teamResponseFromJson(String str) => TeamResponse.fromJson(json.decode(str));

String teamResponseToJson(TeamResponse data) => json.encode(data.toJson());

class TeamResponse {
    TeamResponse({
        this.provider,
        this.image,
        this.services,
        this.availability,
    });

    TeamProvider provider;
    TeamImage image;
    List<dynamic> services;
    List<dynamic> availability;

    factory TeamResponse.fromJson(Map<String, dynamic> json) => TeamResponse(
        provider: TeamProvider.fromJson(json["provider"]),
        image: TeamImage.fromJson(json["image"]),
        services: List<dynamic>.from(json["services"].map((x) => x)),
        availability: List<dynamic>.from(json["availability"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "provider": provider.toJson(),
        "image": image.toJson(),
        "services": List<dynamic>.from(services.map((x) => x)),
        "availability": List<dynamic>.from(availability.map((x) => x)),
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
    AtedAt updatedAt;
    String vendorId;
    String name;
    AtedAt createdAt;
    String path1M;
    String imageId;
    String id;
    String key;
    List<String> tags;

    factory TeamImage.fromJson(Map<String, dynamic> json) => TeamImage(
        path: json["path"],
        updatedAt: AtedAt.fromJson(json["updated_at"]),
        vendorId: json["vendor_id"],
        name: json["name"],
        createdAt: AtedAt.fromJson(json["created_at"]),
        path1M: json["path1m"],
        imageId: json["id"],
        id: json["_id"],
        key: json["key"],
        tags: List<String>.from(json["tags"].map((x) => x)),
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
        this.bio,
        this.createdAt,
        this.active,
        this.providerId,
        this.id,
    });

    AtedAt updatedAt;
    String gender;
    String vendorId;
    String name;
    String bio;
    AtedAt createdAt;
    bool active;
    String providerId;
    String id;

    factory TeamProvider.fromJson(Map<String, dynamic> json) => TeamProvider(
        updatedAt: AtedAt.fromJson(json["updated_at"]),
        gender: json["gender"],
        vendorId: json["vendor_id"],
        name: json["name"],
        bio: json["bio"],
        createdAt: AtedAt.fromJson(json["created_at"]),
        active: json["active"],
        providerId: json["id"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "updated_at": updatedAt.toJson(),
        "gender": gender,
        "vendor_id": vendorId,
        "name": name,
        "bio": bio,
        "created_at": createdAt.toJson(),
        "active": active,
        "id": providerId,
        "_id": id,
    };
}
