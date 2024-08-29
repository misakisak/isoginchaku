// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'libraryLoc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) => LatLng(
      libraryLatitude: (json['libraryLatitude'] as num).toDouble(),
      libraryLongitude: (json['libraryLongitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LatLngToJson(LatLng instance) => <String, dynamic>{
      'libraryLatitude': instance.libraryLatitude,
      'libraryLongitude': instance.libraryLongitude,
    };

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      coords: LatLng.fromJson(json['coords'] as Map<String, dynamic>),
      libraryName: json['libraryName'] as String,
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'coords': instance.coords,
      'libraryName': instance.libraryName,
    };

EachDetails _$EachDetailsFromJson(Map<String, dynamic> json) => EachDetails(
      libraryTown: json['libraryTown'] as String,
      libraryName: json['libraryName'] as String,
      libraryLatitude: (json['libraryLatitude'] as num).toDouble(),
      libraryLongitude: (json['libraryLongitude'] as num).toDouble(),
      libraryWifi: (json['libraryWifi'] as num).toInt(),
      libraryPriorityParking: (json['libraryPriorityParking'] as num).toInt(),
      libraryDate: json['libraryDate'] as String,
      libraryPhone: json['libraryPhone'] as String,
    );

Map<String, dynamic> _$EachDetailsToJson(EachDetails instance) =>
    <String, dynamic>{
      'libraryTown': instance.libraryTown,
      'libraryName': instance.libraryName,
      'libraryLatitude': instance.libraryLatitude,
      'libraryLongitude': instance.libraryLongitude,
      'libraryWifi': instance.libraryWifi,
      'libraryPriorityParking': instance.libraryPriorityParking,
      'libraryDate': instance.libraryDate,
      'libraryPhone': instance.libraryPhone,
    };

LibraryList _$LibraryListFromJson(Map<String, dynamic> json) => LibraryList(
      details: (json['details'] as List<dynamic>)
          .map((e) => Details.fromJson(e as Map<String, dynamic>))
          .toList(),
      eachDetails: (json['eachDetails'] as List<dynamic>)
          .map((e) => EachDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LibraryListToJson(LibraryList instance) =>
    <String, dynamic>{
      'details': instance.details,
      'eachDetails': instance.eachDetails,
    };
