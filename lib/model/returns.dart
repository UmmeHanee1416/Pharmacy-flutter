class Returns {
  int? id;
  String? tradeName;
  String? companyName;
  String? returnedDate;
  int? returnedAmount;

  Returns(
      {this.id,
      this.tradeName,
      this.companyName,
      this.returnedDate,
      this.returnedAmount});

  Returns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tradeName = json['tradeName'];
    companyName = json['companyName'];
    returnedDate = json['returnedDate'];
    returnedAmount = json['returnedAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tradeName'] = this.tradeName;
    data['companyName'] = this.companyName;
    data['returnedDate'] = this.returnedDate;
    data['returnedAmount'] = this.returnedAmount;
    return data;
  }
}
