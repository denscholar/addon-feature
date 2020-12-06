import 'dart:convert';

PostService postServiceFromJson(String str) => PostService.fromJson(json.decode(str));
String postServiceToJson(PostService data) => json.encode(data.toJson());

class PostService {
    PostService({
        this.addOnsIds,
        this.cost,
        this.deliveryType,
        this.description,
        this.images,
        this.name,
        this.ndType,
        this.noticeDuration,
        this.paymentPlanIds,
        this.providerIds,
        this.sdType,
        this.serviceDuration,
        this.status,
        this.tags,
    });

    List<String> addOnsIds;
    int cost;
    String deliveryType;
    String description;
    List<String> images;
    String name;
    String ndType;
    int noticeDuration;
    List<String> paymentPlanIds;
    List<String> providerIds;
    String sdType;
    int serviceDuration;
    bool status;
    List<String> tags;

    factory PostService.fromJson(Map<String, dynamic> json) => PostService(
        addOnsIds: List<String>.from(json["add_ons_ids"].map((x) => x)),
        cost: json["cost"],
        deliveryType: json["delivery_type"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        name: json["name"],
        ndType: json["nd_type"],
        noticeDuration: json["notice_duration"],
        paymentPlanIds: List<String>.from(json["payment_plan_ids"].map((x) => x)),
        providerIds: List<String>.from(json["provider_ids"].map((x) => x)),
        sdType: json["sd_type"],
        serviceDuration: json["service_duration"],
        status: json["status"],
        tags: List<String>.from(json["tags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "add_ons_ids": List<dynamic>.from(addOnsIds.map((x) => x)),
        "cost": cost,
        "delivery_type": deliveryType,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "name": name,
        "nd_type": ndType,
        "notice_duration": noticeDuration,
        "payment_plan_ids": List<dynamic>.from(paymentPlanIds.map((x) => x)),
        "provider_ids": List<dynamic>.from(providerIds.map((x) => x)),
        "sd_type": sdType,
        "service_duration": serviceDuration,
        "status": status,
        "tags": List<dynamic>.from(tags.map((x) => x)),
    };
}
