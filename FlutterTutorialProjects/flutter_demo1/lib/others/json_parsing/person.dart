import 'details.dart';

class Person {
  final String id;
  final String name;
  final int age;
  final List<String> places; // final List<dynamic> places;
  final Address address;
  final List<Images> images;

  Person(
      {this.id, this.name, this.age, this.places, this.address, this.images});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        id: json['id'],
        name: json['name'],
        age: json['age'],
        places: parsePlaces(json['places']), // json['places']
        address: Address.fromJson(json['address']),
        images:
            parseImages(json) // dont work - Images.fromJson(json['images']),
        );
  }

  static List<String> parsePlaces(placesJson) {
    List<String> placesList = new List<String>.from(placesJson);
    return placesList;
  }

  static List<Images> parseImages(imagesJson) {
    var list = imagesJson['images'] as List;
    List<Images> imagesList =
        list.map((data) => Images.fromJson(data)).toList();
    return imagesList;
  }
}

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

class Images {
  int id;
  String name;

  Images({this.id, this.name});

  factory Images.fromJson(Map<String, dynamic> parsedJson) {
    return Images(id: parsedJson['id'], name: parsedJson['name']);
  }
}
