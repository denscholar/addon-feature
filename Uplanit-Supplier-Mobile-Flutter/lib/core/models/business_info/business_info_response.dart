import 'dart:convert';

import '../shared/ated_at.dart';

BusinessInfoResponse businessInfoResponseFromJson(String str) =>
    BusinessInfoResponse.fromJson(json.decode(str));

String businessInfoResponseToJson(BusinessInfoResponse data) =>
    json.encode(data.toJson());

class BusinessInfoResponse {
  BusinessInfoResponse({
    this.contactName,
    this.companyNumber,
    this.updatedAt,
    this.vatNumber,
    this.vendorId,
    this.companyName,
    this.createdAt,
    this.type,
    this.contactNumber,
  });

  String contactName;
  String companyNumber;
  AtedAt updatedAt;
  String vatNumber;
  String vendorId;
  String companyName;
  AtedAt createdAt;
  String type;
  String contactNumber;

  factory BusinessInfoResponse.fromJson(Map<String, dynamic> json) {
    print('from json: $json');
    return BusinessInfoResponse(
      contactName: json["contact_name"] != null ? json['contact_name'] : null,
      companyNumber:
          json["company_number"] != null ? json['company_number'].toString() : null,
      updatedAt: json['updated_at'] != null
          ? AtedAt.fromJson(json["updated_at"])
          : null,
      vatNumber: json["vat_number"] != null ? json['vat_number'].toString() : null,
      vendorId: json["vendor_id"] != null ? json['vendor_id'] : null,
      companyName: json["company_name"] != null ? json["company_name"] : '',
      createdAt: json['created_at'] != null
          ? AtedAt.fromJson(json["created_at"])
          : null,
      type: json["type"] != null ? json['type'].toString() : null,
      contactNumber:
          json["contact_number"] != null ? json["contact_number"].toString() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "contact_name": contactName,
        "company_number": companyNumber,
        "updated_at": updatedAt.toJson(),
        "vat_number": vatNumber,
        "vendor_id": vendorId,
        "company_name": companyName,
        "created_at": createdAt.toJson(),
        "type": type,
        "contact_number": contactNumber,
      };
}
