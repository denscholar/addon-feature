import 'dart:convert';

import 'package:uplanit_supplier/core/models/shared/ated_at.dart';

List<BaseService> getBaseServiceListFromJson(String str) => List<BaseService>.from(json.decode(str).map((x) => BaseService.fromJson(x)));
String getBaseServiceListToJson(List<BaseService> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

BaseService getBaseServiceFromJson(String str) => BaseService.fromJson(json.decode(str));
String getBaseServiceToJson(BaseService data) => json.encode(data.toJson());

class BaseService {
    BaseService({
        this.service,
        this.images,
        this.currency,
        this.addonCount,
        this.providersCount,
    });

    Service service;
    List<Image> images;
    Currency currency;
    int addonCount;
    int providersCount;

    factory BaseService.fromJson(Map<String, dynamic> json) => BaseService(
        service: json["service"] != null ? Service.fromJson(json["service"]) : null,
        images: json["images"] != null ? List<Image>.from(json["images"].map((x) => Image.fromJson(x))) : null,
        currency: json["currency"] != null ? Currency.fromJson(json["currency"])  : null,
        addonCount: json["addon_count"] != null ? json["addon_count"] : null,
        providersCount: json["providers_count"] != null ? json["providers_count"] : null,
    );

    Map<String, dynamic> toJson() => {
        "service": service.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "currency": currency.toJson(),
        "addon_count": addonCount,
        "providers_count": providersCount,
    };
}

class Currency {
    Currency({
        this.country,
        this.code,
        this.name,
        // this.updatedAt,
        // this.createdAt,
        this.currencyId,
        this.id,
    });

    String country;
    String code;
    String name;
    // AtedAt updatedAt;
    // AtedAt createdAt;
    String currencyId;
    String id;

    factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        country: json["country"],
        code: json["code"],
        name: json["name"],
        // updatedAt: AtedAt.fromJson(json["updated_at"]),
        // createdAt: AtedAt.fromJson(json["created_at"]),
        currencyId: json["id"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "code": code,
        "name": name,
        // "updated_at": updatedAt.toJson(),
        // "created_at": createdAt.toJson(),
        "id": currencyId,
        "_id": id,
    };
}


class Image {
    Image({
        this.path,
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
    String vendorId;
    String name;
    AtedAt createdAt;
    String path1M;
    String imageId;
    String id;
    String key;
    List<String> tags;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        path: json["path"],
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

class Service {
    Service({
        this.ndType,
        this.providerIds,
        this.images,
        this.addOnsIds,
        this.cost,
        this.paymentPlanIds,
        this.createdAt,
        this.description,
        this.sdType,
        this.currentTab,
        this.loading,
        this.serviceDuration,
        this.tags,
        this.updatedAt,
        this.deliveryType,
        this.vendorId,
        this.name,
        this.noticeDuration,
        this.serviceId,
        this.id,
        this.status,
    });

    String ndType;
    List<String> providerIds;
    List<String> images;
    List<String> addOnsIds;
    int cost;
    List<String> paymentPlanIds;
    AtedAt createdAt;
    String description;
    String sdType;
    String currentTab;
    bool loading;
    int serviceDuration;
    List<String> tags;
    AtedAt updatedAt;
    String deliveryType;
    String vendorId;
    String name;
    int noticeDuration;
    String serviceId;
    String id;
    bool status;

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        ndType: json["nd_type"],
        providerIds: List<String>.from(json["provider_ids"].map((x) => x)),
        images: List<String>.from(json["images"].map((x) => x)),
        addOnsIds: List<String>.from(json["add_ons_ids"].map((x) => x)),
        cost: json["cost"],
        paymentPlanIds: List<String>.from(json["payment_plan_ids"].map((x) => x)),
        createdAt: AtedAt.fromJson(json["created_at"]),
        description: json["description"],
        sdType: json["sd_type"],
        currentTab: json["currentTab"],
        loading: json["loading"] == null ? null : json["loading"],
        serviceDuration: json["service_duration"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        updatedAt: AtedAt.fromJson(json["updated_at"]),
        deliveryType: json["delivery_type"],
        vendorId: json["vendor_id"],
        name: json["name"],
        noticeDuration: json["notice_duration"],
        serviceId: json["id"],
        id: json["_id"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "nd_type": ndType,
        "provider_ids": List<dynamic>.from(providerIds.map((x) => x)),
        "images": List<dynamic>.from(images.map((x) => x)),
        "add_ons_ids": List<dynamic>.from(addOnsIds.map((x) => x)),
        "cost": cost,
        "payment_plan_ids": List<dynamic>.from(paymentPlanIds.map((x) => x)),
        "created_at": createdAt.toJson(),
        "description": description,
        "sd_type": sdType,
        "currentTab": currentTab,
        "loading": loading == null ? null : loading,
        "service_duration": serviceDuration,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "updated_at": updatedAt.toJson(),
        "delivery_type": deliveryType,
        "vendor_id": vendorId,
        "name": name,
        "notice_duration": noticeDuration,
        "id": serviceId,
        "_id": id,
        "status": status,
    };
}