// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lanLoc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) => LatLng(
      lanLatitude: (json['lanLatitude'] as num).toDouble(),
      lanLongitude: (json['lanLongitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'lanLatitude': instance.lanLatitude,
      'lanLongitude': instance.lanLongitude,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      coords: LatLng.fromJson(json['coords'] as Map<String, dynamic>),
      lanName: json['lanName'] as String,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'coords': instance.coords,
      'lanName': instance.lanName,
    };

EachDetails _$EachDetailsFromJson(Map<String, dynamic> json) => EachDetails(
      lanTown: json['lanTown'] as String,
      lanName: json['lanName'] as String,
      lanLatitude: (json['lanLatitude'] as num).toDouble(),
      lanLongitude: (json['lanLongitude'] as num).toDouble(),
      lanSupplyArea: json['lanSupplyArea'] as String,
      lanSSID: json['lanSSID'] as String,
      lanPhone: json['lanPhone'] as String,
      lanURL: json['lanURL'] as String,
      lanNotes: json['lanNotes'] as String,
    );

Map<String, dynamic> _$EachDetailsToJson(EachDetails instance) =>
    <String, dynamic>{
      'lanTown': instance.lanTown,
      'lanName': instance.lanName,
      'lanLatitude': instance.lanLatitude,
      'lanLongitude': instance.lanLongitude,
      'lanSupplyArea': instance.lanSupplyArea,
      'lanSSID': instance.lanSSID,
      'lanPhone': instance.lanPhone,
      'lanURL': instance.lanURL,
      'lanNotes': instance.lanNotes,
    };

LanList _$LanListFromJson(Map<String, dynamic> json) => LanList(
      details: (json['details'] as List<dynamic>)
          .map((e) => Details.fromJson(e as Map<String, dynamic>))
          .toList(),
      eachDetails: (json['eachDetails'] as List<dynamic>)
          .map((e) => EachDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LanListToJson(LanList instance) => <String, dynamic>{
      'details': instance.details,
      'eachDetails': instance.eachDetails,
    };
