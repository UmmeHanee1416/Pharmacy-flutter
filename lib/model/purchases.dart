
import 'dart:convert';

List<Purchases> purchaseFromJson(String string) => List<Purchases>.from(jsonDecode(string).map((x) => Purchases.fromJson(x)));

class Purchases {
  int? id;
  String? name;
  int? doctorID;
  String? representativeName;
  String? representativeContact;
  String? supplyAddress;

  Purchases(
      {this.id,
      this.name,
      this.doctorID,
      this.representativeName,
      this.representativeContact,
      this.supplyAddress});

  Purchases.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    doctorID = json['doctorID'];
    representativeName = json['representativeName'];
    representativeContact = json['representativeContact'];
    supplyAddress = json['supplyAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['doctorID'] = this.doctorID;
    data['representativeName'] = this.representativeName;
    data['representativeContact'] = this.representativeContact;
    data['supplyAddress'] = this.supplyAddress;
    return data;
  }
}