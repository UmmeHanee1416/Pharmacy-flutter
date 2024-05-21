import 'dart:convert';

List<EmployeeDetails> empDetailFromJson(String string) =>
    List<EmployeeDetails>.from(
        jsonDecode(string).map((x) => EmployeeDetails.fromJson(x)));

class EmployeeDetails {
  int? id;
  String? permanentAdd;
  String? currentAdd;
  int? familyMembers;

  EmployeeDetails(
      {this.id, this.permanentAdd, this.currentAdd, this.familyMembers});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    permanentAdd = json['permanentAdd'];
    currentAdd = json['currentAdd'];
    familyMembers = json['familyMembers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['permanentAdd'] = this.permanentAdd;
    data['currentAdd'] = this.currentAdd;
    data['familyMembers'] = this.familyMembers;
    return data;
  }
}
