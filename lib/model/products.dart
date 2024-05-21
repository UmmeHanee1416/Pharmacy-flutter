import 'dart:convert';

List<Products> usersFromJson(String string) => List<Products>.from(jsonDecode(string).map((x) => Products.fromJson(x)));

class Products {
  String? tradeName;
  String? companyName;
  int? regsrtQuantity;
  int? soldQuantity;
  int? remainedQuantity;
  String? mfd;
  String? exp;
  int? sellPrice;
  List<int>? generics;

  Products(
      {this.tradeName,
      this.companyName,
      this.regsrtQuantity,
      this.soldQuantity,
      this.remainedQuantity,
      this.mfd,
      this.exp,
      this.sellPrice,
      this.generics});

  Products.fromJson(Map<String, dynamic> json) {
    tradeName = json['tradeName'];
    companyName = json['companyName'];
    regsrtQuantity = json['regsrtQuantity'];
    soldQuantity = json['soldQuantity'];
    remainedQuantity = json['remainedQuantity'];
    mfd = json['mfd'];
    exp = json['exp'];
    sellPrice = json['sellPrice'];
    generics = json['generics'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tradeName'] = this.tradeName;
    data['companyName'] = this.companyName;
    data['regsrtQuantity'] = this.regsrtQuantity;
    data['soldQuantity'] = this.soldQuantity;
    data['remainedQuantity'] = this.remainedQuantity;
    data['mfd'] = this.mfd;
    data['exp'] = this.exp;
    data['sellPrice'] = this.sellPrice;
    data['generics'] = this.generics;
    return data;
  }
}
