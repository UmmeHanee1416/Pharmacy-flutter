
import 'dart:convert';

List<Doctors> usersFromJson(String string) => List<Doctors>.from(jsonDecode(string).map((x) => Doctors.fromJson(x)));

class Doctors {
  int? id;
  String? name;
  String? specialty;
  String? address;
  String? contact;

  Doctors(
      {this.id,
      this.name,
      this.specialty,
      this.address,
      this.contact});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    specialty = json['specialty'];
    address = json['address'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['specialty'] = this.specialty;
    data['address'] = this.address;
    data['contact'] = this.contact;
    return data;
  }
}