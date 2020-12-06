import 'dart:convert';

import '../shared/ated_at.dart';

PaymentPlanResponse paymentPlanResponseFromJson(String str) =>
    PaymentPlanResponse.fromJson(json.decode(str));

String paymentPlanResponseToJson(PaymentPlanResponse data) =>
    json.encode(data.toJson());

class PaymentPlanResponse {
  PaymentPlanResponse({
    this.plan,
    this.services,
    this.serviceCount,
  });

  Plan plan;
  List<dynamic> services;
  int serviceCount;

  factory PaymentPlanResponse.fromJson(Map<String, dynamic> json) =>
      PaymentPlanResponse(
        plan: Plan.fromJson(json["plan"]),
        services: List<dynamic>.from(json["services"].map((x) => x)),
        serviceCount: json["service_count"],
      );

  Map<String, dynamic> toJson() => {
        "plan": plan.toJson(),
        "services": List<dynamic>.from(services.map((x) => x)),
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
    String minCost;
    String refund;
    String preferredPaymentDay;
    String downPayment;
    String numberOfPayments;
    String interval;
    String planId;
    bool live;
    AtedAt createdAt;
    String lastPayment;
    AtedAt updatedAt;

    factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        name: json["name"],
        vendorId: json["vendor_id"],
        id: json["_id"],
        minCost: json["min_cost"].toString(),
        refund: json["refund"].toString(),
        preferredPaymentDay: json["preferred_payment_day"].toString(),
        downPayment: json["down_payment"].toString(),
        numberOfPayments: json["number_of_payments"].toString(),
        interval: json["interval"].toString(),
        planId: json["id"],
        live: json["live"],
        createdAt: AtedAt.fromJson(json["created_at"]),
        lastPayment: json["last_payment"].toString(),
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
