import 'dart:convert';

List<Sales> salesFromJson(String string) => List<Sales>.from(jsonDecode(string).map((x) => Sales.fromJson(x)));

class Sales {
  int? id;
  String? customerId;
  int? totalQuantity;
  int? totalCharge;
  int? empId;
  String? empName;

  Sales(
      {this.id,
      this.customerId,
      this.totalQuantity,
      this.totalCharge,
      this.empId,
      this.empName});

  Sales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    totalQuantity = json['totalQuantity'];
    totalCharge = json['totalCharge'];
    empId = json['empId'];
    empName = json['empName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['totalQuantity'] = this.totalQuantity;
    data['totalCharge'] = this.totalCharge;
    data['empId'] = this.empId;
    data['empName'] = this.empName;
    return data;
  }
}
