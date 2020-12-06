import 'dart:convert';

import '../shared/ated_at.dart';

List<BasePaymentPlan> basePaymentPlanFromJson(String str) =>
    List<BasePaymentPlan>.from(
        json.decode(str).map((x) => BasePaymentPlan.fromJson(x)));

String basePaymentPlanToJson(List<BasePaymentPlan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BasePaymentPlan {
  BasePaymentPlan({
    this.plan,
    this.services,
    this.serviceCount,
  });

  Plan plan;
  List<Service> services;
  int serviceCount;

  factory BasePaymentPlan.fromJson(Map<String, dynamic> json) =>
      BasePaymentPlan(
        plan: Plan.fromJson(json["plan"]),
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
        serviceCount: json["service_count"],
      );

  Map<String, dynamic> toJson() => {
        "plan": plan.toJson(),
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
        "service_count": serviceCount,
      };
}

class Plan {
  Plan({
    this.name,
    this.vendorId,
    this.id,
    this.minCost,
    this.refund,
    this.preferredPaymentDay,
    this.downPayment,
    this.numberOfPayments,
    this.interval,
    this.planId,
    this.live,
    this.createdAt,
    this.lastPayment,
    this.updatedAt,
  });

  String name;
  String vendorId;
  String id;
  int minCost;
  bool refund;
  int preferredPaymentDay;
  int downPayment;
  int numberOfPayments;
  int interval;
  String planId;
  bool live;
  AtedAt createdAt;
  int lastPayment;
  AtedAt updatedAt;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        name: json["name"],
        vendorId: json["vendor_id"],
        id: json["_id"],
        minCost: json["min_cost"],
        refund: json["refund"],
        preferredPaymentDay: json["preferred_payment_day"],
        downPayment: json["down_payment"],
        numberOfPayments: json["number_of_payments"],
        interval: json["interval"],
        planId: json["id"],
        live: json["live"],
        createdAt: AtedAt.fromJson(json["created_at"]),
        lastPayment: json["last_payment"],
        updatedAt: AtedAt.fromJson(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "vendor_id": vendorId,
        "_id": id,
        "min_cost": minCost,
        "refund": refund,
        "preferred_payment_day": preferredPaymentDay,
        "down_payment": downPayment,
        "number_of_payments": numberOfPayments,
        "interval": interval,
        "id": planId,
        "live": live,
        "created_at": createdAt.toJson(),
        "last_payment": lastPayment,
        "updated_at": updatedAt.toJson(),
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
  List<dynamic> addOnsIds;
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
        addOnsIds: List<dynamic>.from(json["add_ons_ids"].map((x) => x)),
        cost: json["cost"],
        paymentPlanIds:
            List<String>.from(json["payment_plan_ids"].map((x) => x)),
        createdAt: AtedAt.fromJson(json["created_at"]),
        description: json["description"],
        sdType: json["sd_type"],
        currentTab: json["currentTab"],
        loading: json["loading"],
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
        "loading": loading,
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
