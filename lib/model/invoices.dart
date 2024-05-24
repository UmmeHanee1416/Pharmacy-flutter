
import 'dart:convert';

List<Invoices> invoiceFromJson(String string) => List<Invoices>.from(jsonDecode(string).map((x) => Invoices.fromJson(x)));

class Invoices {
  int? id;
  int? salesId;
  String? customerId;
  int? soldQty;
  String? saleDate;

  Invoices(
      {this.id, this.salesId, this.customerId, this.soldQty, this.saleDate});

  Invoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesId = json['salesId'];
    customerId = json['customerId'];
    soldQty = json['soldQty'];
    saleDate = json['saleDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salesId'] = this.salesId;
    data['customerId'] = this.customerId;
    data['soldQty'] = this.soldQty;
    data['saleDate'] = this.saleDate;
    return data;
  }
}
