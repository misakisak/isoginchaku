// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitsuenjoLoc2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) => LatLng(
      kitsuenjoLatitude: (json['kitsuenjoLatitude'] as num).toDouble(),
      kitsuenjoLongitude: (json['kitsuenjoLongitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'kitsuenjoLatitude': instance.kitsuenjoLatitude,
      'kitsuenjoLongitude': instance.kitsuenjoLongitude,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      coords: LatLng.fromJson(json['coords'] as Map<String, dynamic>),
      kitsuenjoTitle: json['kitsuenjoTitle'] as String,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'coords': instance.coords,
      'kitsuenjoTitle': instance.kitsuenjoTitle,
    };

EachDetails _$EachDetailsFromJson(Map<String, dynamic> json) => EachDetails(
      kitsuenjoTown: json['kitsuenjoTown'] as String,
      kitsuenjoTitle: json['kitsuenjoTitle'] as String,
      kitsuenjoLatitude: (json['kitsuenjoLatitude'] as num).toDouble(),
      kitsuenjoLongitude: (json['kitsuenjoLongitude'] as num).toDouble(),
      kitsuenjoPlace: json['kitsuenjoPlace'] as String,
      kitsuenjoStartTime: json['kitsuenjoStartTime'] as String,
      kitsuenjoEndTime: json['kitsuenjoEndTime'] as String,
      kitsuenjoNote: json['kitsuenjoNote'] as String,
    );

Map<String, dynamic> _$EachDetailsToJson(EachDetails instance) =>
    <String, dynamic>{
      'kitsuenjoTown': instance.kitsuenjoTown,
      'kitsuenjoTitle': instance.kitsuenjoTitle,
      'kitsuenjoLatitude': instance.kitsuenjoLatitude,
      'kitsuenjoLongitude': instance.kitsuenjoLongitude,
      'kitsuenjoPlace': instance.kitsuenjoPlace,
      'kitsuenjoStartTime': instance.kitsuenjoStartTime,
      'kitsuenjoEndTime': instance.kitsuenjoEndTime,
      'kitsuenjoNote': instance.kitsuenjoNote,
    };

KitsuenjoList _$KitsuenjoListFromJson(Map<String, dynamic> json) =>
    KitsuenjoList(
      details: (json['details'] as List<dynamic>)
          .map((e) => Details.fromJson(e as Map<String, dynamic>))
          .toList(),
      eachDetails: (json['eachDetails'] as List<dynamic>)
          .map((e) => EachDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KitsuenjoListToJson(KitsuenjoList instance) =>
    <String, dynamic>{
      'details': instance.details,
      'eachDetails': instance.eachDetails,
    };
