import 'dart:convert';

List<Customers> usersFromJson(String string) =>
    List<Customers>.from(jsonDecode(string).map((x) => Customers.fromJson(x)));

class Customers {
  String? name;
  int? contact;
  String? purchaseDate;
  int? payMethod;
  String? empId;
  List<dynamic>? salesDetailDTOS;

  Customers(
      {this.name, this.contact, this.purchaseDate, this.payMethod, this.empId,this.salesDetailDTOS});

  Customers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contact = json['contact'];
    purchaseDate = json['purchaseDate'];
    payMethod = json['payMethod'];
    empId = json['empId'];
    salesDetailDTOS = json['salesDetailDTOS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['purchaseDate'] = this.purchaseDate;
    data['payMethod'] = this.payMethod;
    data['empId'] = this.empId;
    data['salesDetailDTOS'] = this.salesDetailDTOS;
    return data;
  }
}
