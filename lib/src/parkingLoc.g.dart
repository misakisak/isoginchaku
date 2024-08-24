// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parkingLoc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) => LatLng(
      parkingLatitude: (json['parkingLatitude'] as num).toDouble(),
      parkingLongitude: (json['parkingLongitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'parkingLatitude': instance.parkingLatitude,
      'parkingLongitude': instance.parkingLongitude,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      coords: LatLng.fromJson(json['coords'] as Map<String, dynamic>),
      parkingTitle: json['parkingTitle'] as String,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'coords': instance.coords,
      'parkingTitle': instance.parkingTitle,
    };

EachDetails _$EachDetailsFromJson(Map<String, dynamic> json) => EachDetails(
      parkingTown: json['parkingTown'] as String,
      parkingTitle: json['parkingTitle'] as String,
      parkingLatitude: (json['parkingLatitude'] as num).toDouble(),
      parkingLongitude: (json['parkingLongitude'] as num).toDouble(),
      parkingInfo: json['parkingInfo'] as String,
      parkingCarType: json['parkingCarType'] as String,
      parkingPhone: json['parkingPhone'] as String,
    );

Map<String, dynamic> _$EachDetailsToJson(EachDetails instance) =>
    <String, dynamic>{
      'parkingTown': instance.parkingTown,
      'parkingTitle': instance.parkingTitle,
      'parkingLatitude': instance.parkingLatitude,
      'parkingLongitude': instance.parkingLongitude,
      'parkingInfo': instance.parkingInfo,
      'parkingCarType': instance.parkingCarType,
      'parkingPhone': instance.parkingPhone,
    };

ParkingList _$ParkingListFromJson(Map<String, dynamic> json) => ParkingList(
      details: (json['details'] as List<dynamic>)
          .map((e) => Details.fromJson(e as Map<String, dynamic>))
          .toList(),
      eachDetails: (json['eachDetails'] as List<dynamic>)
          .map((e) => EachDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParkingListToJson(ParkingList instance) =>
    <String, dynamic>{
      'details': instance.details,
      'eachDetails': instance.eachDetails,
    };
