import 'dart:convert';

List<Employees> empFromJson(String string) =>
    List<Employees>.from(
        jsonDecode(string).map((x) => Employees.fromJson(x)));
class Employees {
  int? id;
  String? name;
  int? experience;
  String? education;
  int? employeeDetail;
  String? reference;

  Employees(
      {this.id,
      this.name,
      this.experience,
      this.education,
      this.employeeDetail,
      this.reference});

  Employees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    experience = json['experience'];
    education = json['education'];
    employeeDetail = json['employeeDetail'];
    reference = json['reference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['experience'] = this.experience;
    data['education'] = this.education;
    data['employeeDetail'] = this.employeeDetail;
    data['reference'] = this.reference;
    return data;
  }
}
