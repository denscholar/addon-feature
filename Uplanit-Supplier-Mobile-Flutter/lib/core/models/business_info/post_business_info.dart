import 'dart:convert';

PostBusinessInfo postBusinessInfoFromJson(String str) =>
    PostBusinessInfo.fromJson(json.decode(str));

String postBusinessInfoToJson(PostBusinessInfo data) =>
    json.encode(data.toJson());

class PostBusinessInfo {
  PostBusinessInfo({
    this.companyName,
    this.companyNumber,
    this.contactName,
    this.contactNumber,
    this.type,
    this.vatNumber,
  });

  String companyName;
  String companyNumber;
  String contactName;
  int contactNumber;
  String type;
  int vatNumber;

  factory PostBusinessInfo.fromJson(Map<String, dynamic> json) =>
      PostBusinessInfo(
        companyName: json["company_name"] ?? '',
        companyNumber: json["company_number"] ?? '',
        contactName: json["contact_name"],
        contactNumber: json["contact_number"],
        type: json["type"],
        vatNumber: json["vat_number"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName ?? '',
        "company_number": companyNumber ?? '',
        "contact_name": contactName,
        "contact_number": contactNumber,
        "type": type,
        "vat_number": vatNumber ?? null,
      };
}
