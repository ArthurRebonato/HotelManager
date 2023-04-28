import 'package:json_annotation/json_annotation.dart';

part 'hotel_model.g.dart';

@JsonSerializable()
class HotelModel {
  String id;
  String name;
  String description;
  String address;
  String status;
  String lat;
  String lon;
  double rating;

  HotelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.status,
    required this.lat,
    required this.lon,
    required this.rating,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) =>
      _$HotelModelFromJson(json);
  Map<String, dynamic> toJson() => _$HotelModelToJson(this);
}
