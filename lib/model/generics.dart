
import 'dart:convert';

List<Generics> usersFromJson(String string) => List<Generics>.from(jsonDecode(string).map((x) => Generics.fromJson(x)));

class Generics {
  int? id;
  String? genericName;
  int? registeredQuantity;

  Generics(
      {this.id,
      this.genericName,
      this.registeredQuantity});

  Generics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    genericName = json['genericName'];
    registeredQuantity = json['registeredQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['genericName'] = this.genericName;
    data['registeredQuantity'] = this.registeredQuantity;
    return data;
  }
}