import 'dart:convert';

PostTeam postTeamFromJson(String str) => PostTeam.fromJson(json.decode(str));

String postTeamToJson(PostTeam data) => json.encode(data.toJson());

class PostTeam {
    PostTeam({
        this.active,
        this.bio,
        this.gender,
        this.name,
        this.image,
    });

    bool active;
    String bio;
    String gender;
    String name;
    String image;

    factory PostTeam.fromJson(Map<String, dynamic> json) => PostTeam(
        active: json["active"] != null ? json['active'] : null,
        bio: json["bio"] != null ? json['bio'] : null,
        gender: json["gender"] != null ? json['gender'] : null,
        name: json["name"] != null ? json['name'] : null,
        image: json["image"] != null ? json['image'] : null,
    );

    Map<String, dynamic> toJson() => {
        "active": active != null ? active : null,
        "bio": bio != null ? bio : null,
        "gender": gender != null ? gender : null,
        "name": name != null ? name : null,
        "image": image != null ? image : null,
    };
}