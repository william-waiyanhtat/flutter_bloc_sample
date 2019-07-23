import 'package:json_annotation/json_annotation.dart';

part 'name.g.dart';

@JsonSerializable()
class Name {
    Name();

    String first_name;
    String last_name;
    
    factory Name.fromJson(Map<String,dynamic> json) => _$NameFromJson(json);
    Map<String, dynamic> toJson() => _$NameToJson(this);
}
