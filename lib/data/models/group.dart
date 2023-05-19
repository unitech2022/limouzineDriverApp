class Group {
  final int id;
  final double price;
  final String startCity;
  final String endCity;
  final int status;
  final int peoples;
  final String createdAt;

  Group(
      {required this.id,
      required this.price,
      required this.startCity,
      required this.endCity,
      required this.status,
      required this.peoples,
      required this.createdAt});

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json['id'],
        price: json['price'].toDouble(),
        startCity: json['startCity'],
        peoples: json['peoples'],
        endCity: json['endCity'],
        status: json['status'],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['startCity'] = this.startCity;
    data['endCity'] = this.endCity;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
