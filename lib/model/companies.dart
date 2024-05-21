
import 'dart:convert';

List<Companies> usersFromJsonC(String string) => List<Companies>.from(jsonDecode(string).map((x) => Companies.fromJson(x)));

class Companies {
  int? id;
  String? name;
  int? doctorID;
  String? representativeName;
  String? representativeContact;
  String? supplyAddress;

  Companies(
      {this.id,
      this.name,
      this.doctorID,
      this.representativeName,
      this.representativeContact,
      this.supplyAddress});

  Companies.fromJson(Map<String, dynamic> json) {
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