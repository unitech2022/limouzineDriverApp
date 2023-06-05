class AddressModel {
  int? id;
  String? userId;
  bool? defaultAddress;
  double? lat;
  double? lang;
  String? label;
  String? createdAt;

  AddressModel(
      {this.id,
      this.userId,
      this.defaultAddress,
      this.lat,
      this.lang,
      this.label,
      this.createdAt});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    defaultAddress = json['default'];
    lat = json['lat'];
    lang = json['lang'];
    label = json['label'];
    createdAt = json['createdAt'];
  }
}
