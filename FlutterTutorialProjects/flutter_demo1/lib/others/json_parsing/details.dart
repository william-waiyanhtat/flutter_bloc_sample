class Details {
  int houseNo;
  String town;

  Details({this.houseNo, this.town});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      houseNo: json['house_no'] as int,
      town: json['town'],
    );
  }
}
