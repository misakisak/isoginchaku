// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toiletLoc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) => LatLng(
      toiletLatitude: (json['toiletLatitude'] as num).toDouble(),
      toiletLongitude: (json['toiletLongitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'toiletLatitude': instance.toiletLatitude,
      'toiletLongitude': instance.toiletLongitude,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      coords: LatLng.fromJson(json['coords'] as Map<String, dynamic>),
      toiletName: json['toiletName'] as String,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'coords': instance.coords,
      'toiletName': instance.toiletName,
    };

EachDetails _$EachDetailsFromJson(Map<String, dynamic> json) => EachDetails(
      toiletTown: json['toiletTown'] as String,
      toiletName: json['toiletName'] as String,
      toiletLatitude: (json['toiletLatitude'] as num).toDouble(),
      toiletLongitude: (json['toiletLongitude'] as num).toDouble(),
      toiletMen: (json['toiletMen'] as num).toInt(),
      toiletWomen: (json['toiletWomen'] as num).toInt(),
      toiletBoth: (json['toiletBoth'] as num).toInt(),
      toiletBarrierFree: (json['toiletBarrierFree'] as num).toInt(),
      toiletWheelChair: (json['toiletWheelChair'] as num).toInt(),
      toiletForKids: (json['toiletForKids'] as num).toInt(),
      toiletOstomate: (json['toiletOstomate'] as num).toInt(),
      toiletInfo: json['toiletInfo'] as String,
    );

Map<String, dynamic> _$EachDetailsToJson(EachDetails instance) =>
    <String, dynamic>{
      'toiletTown': instance.toiletTown,
      'toiletName': instance.toiletName,
      'toiletLatitude': instance.toiletLatitude,
      'toiletLongitude': instance.toiletLongitude,
      'toiletMen': instance.toiletMen,
      'toiletWomen': instance.toiletWomen,
      'toiletBoth': instance.toiletBoth,
      'toiletBarrierFree': instance.toiletBarrierFree,
      'toiletWheelChair': instance.toiletWheelChair,
      'toiletForKids': instance.toiletForKids,
      'toiletOstomate': instance.toiletOstomate,
      'toiletInfo': instance.toiletInfo,
    };

ToiletList _$ToiletListFromJson(Map<String, dynamic> json) => ToiletList(
      details: (json['details'] as List<dynamic>)
          .map((e) => Details.fromJson(e as Map<String, dynamic>))
          .toList(),
      eachDetails: (json['eachDetails'] as List<dynamic>)
          .map((e) => EachDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ToiletListToJson(ToiletList instance) =>
    <String, dynamic>{
      'details': instance.details,
      'eachDetails': instance.eachDetails,
    };
