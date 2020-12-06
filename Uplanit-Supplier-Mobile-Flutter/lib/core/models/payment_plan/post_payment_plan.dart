import 'dart:convert';

PostPaymentPlan postPaymentPlanFromJson(String str) => PostPaymentPlan.fromJson(json.decode(str));

String postPaymentPlanToJson(PostPaymentPlan data) => json.encode(data.toJson());

class PostPaymentPlan {
    PostPaymentPlan({
        this.downPayment,
        this.interval,
        this.lastPayment,
        this.minCost,
        this.name,
        this.numberOfPayments,
        this.preferredPaymentDay,
        this.refund,
    });

    int downPayment;
    int interval;
    int lastPayment;
    int minCost;
    String name;
    int numberOfPayments;
    int preferredPaymentDay;
    bool refund;

    factory PostPaymentPlan.fromJson(Map<String, dynamic> json) => PostPaymentPlan(
        downPayment: int.parse(json["down_payment"]),
        interval: int.parse(json["interval"] ),
        lastPayment: int.parse(json["last_payment"]),
        minCost: int.parse(json["min_cost"] ),
        name: json["name"],
        numberOfPayments: int.parse(json["number_of_payments"]) ,
        preferredPaymentDay: int.parse(json["preferred_payment_day"]) ,
        refund: json["refund"] as bool,
    );

    Map<String, dynamic> toJson() => {
        "down_payment": downPayment,
        "interval": interval,
        "last_payment": lastPayment,
        "min_cost": minCost,
        "name": name,
        "number_of_payments": numberOfPayments,
        "preferred_payment_day": preferredPaymentDay,
        "refund": refund,
    };
}
