import 'dart:convert';


List<Sales> usersFromJsonS(String string) =>
    List<Sales>.from(jsonDecode(string).map((x) => Sales.fromJson(x)));

class Sales {
  int? id;
  String? productName;
  String? productQTY;

  Sales({this.id, this.productName, this.productQTY});

  Sales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    productQTY = json['productQTY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productName'] = this.productName;
    data['productQTY'] = this.productQTY;
    return data;
  }
}
