// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelModel _$HotelModelFromJson(Map<String, dynamic> json) => HotelModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      status: json['status'] as String,
      lat: json['lat'] as String,
      lon: json['lon'] as String,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$HotelModelToJson(HotelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address,
      'status': instance.status,
      'lat': instance.lat,
      'lon': instance.lon,
      'rating': instance.rating,
    };
