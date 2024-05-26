import 'dart:convert';

List<SalesDetails> salesDetailsFromJson(String string) => List<SalesDetails>.from(jsonDecode(string).map((x) => SalesDetails.fromJson(x)));

class SalesDetails {
  int? id;
  int? salesId;
  String? productId;
  String? productQuantity;
  String? totalCharge;

  SalesDetails(
      {this.id,
      this.salesId,
      this.productId,
      this.productQuantity,
      this.totalCharge});

  SalesDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesId = json['salesId'];
    productId = json['productId'];
    productQuantity = json['productQuantity'];
    totalCharge = json['totalCharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesId'] = this.salesId;
    data['productId'] = this.productId;
    data['productQuantity'] = this.productQuantity;
    data['totalCharge'] = this.totalCharge;
    return data;
  }
}
