import 'details.dart';

class Address {
  final String streetNo;
  final Details details;

  Address({this.streetNo, this.details});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      streetNo: json['street_no'] as String,
      details: Details.fromJson(json['details']),
    );
  }
}
