import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'libraryLoc.g.dart';

//SAMPLE DATA !!!
     //     "libraryTown": "江東区",
     //      "libraryName": "江東区立万年橋際公衆便所",
     //      "libraryLatitude": 35.68322,
     //      "libraryLongitude": 139.7948,
     //      "libraryWifi": 1,
     //      "libraryPriorityParking": 0,
     //      "libraryDate": 0,
     //      "libraryPhone": 1,
     //      "toiletWheelChair": 1,
     //      "toiletForKids": 0,
     //      "toiletOstomate": 1.0,
     //      "toiletInfo": "男性トイレ: 2 女性トイレ: 0 男女共用トイレ: 0 バリアフリートイレ: 1"


@JsonSerializable()
class LatLng {
  LatLng({
    required this.libraryLatitude,
    required this.libraryLongitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double libraryLatitude;
  final double libraryLongitude;
}

@JsonSerializable()
class Details {
  Details({
    required this.coords,
    required this.libraryName,
  });

  factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsToJson(this);

  final LatLng coords;
  final String libraryName;
}

@JsonSerializable()
class EachDetails {
  EachDetails({
    required this.libraryTown,
    required this.libraryName,
    required this.libraryLatitude,
    required this.libraryLongitude,
    required this.libraryWifi,
    required this.libraryPriorityParking,
    required this.libraryDate,
    required this.libraryPhone,
  });

  // factory EachDetails.fromJson(Map<String, dynamic> json) => _$EachDetailsFromJson(json);　//下のやつに変えることで、もし中身がnullであっても動く
  factory EachDetails.fromJson(Map<String, dynamic> json) {
     //nullだとエラー出るので、ここでnullの場合をunKnownとかにしてる
     //もしかしたらlibraryWifiとか0, 1, にしてるからnullの場合を0にしたら困るかも　(確認中)  
     return EachDetails(
          libraryTown: json['libraryTown'] ?? 'Unknown',
          libraryName: json['libraryName'] ?? 'Unknown',
          libraryLatitude: (json['libraryLatitude'] ?? 0.0).toDouble(),
          libraryLongitude:(json['libraryLongitude'] ?? 0.0).toDouble(),
          libraryWifi: (json['libraryWifi'] ?? 0).toInt(),
          libraryPriorityParking: (json['libraryPriorityParking'] ?? 0).toInt(),
          libraryDate: json['libraryDate'] ?? 'Unknown',
          libraryPhone: json['libraryPhone'] ?? 'Unknown',
     );
  }

  Map<String, dynamic> toJson() => _$EachDetailsToJson(this);

  final String libraryTown;
  final String libraryName;
  final double libraryLatitude;
  final double libraryLongitude;
  final int libraryWifi;
  final int libraryPriorityParking;
  final String libraryDate;
  final String libraryPhone;
  
}


@JsonSerializable()
class LibraryList {
  LibraryList({
    required this.details,
    required this.eachDetails,
  });

  factory LibraryList.fromJson(Map<String, dynamic> json) =>
    _$LibraryListFromJson(json);
  Map<String, dynamic> toJson() => _$LibraryListToJson(this);

  final List<Details> details;
  final List<EachDetails> eachDetails;
}

Future<List<EachDetails>> fetchLibraryData() async {
     const url = 'https://raw.githubusercontent.com/isoginchakus/data_set/main/libraryFinal.json';

     try {
          final response = await http.get(Uri.parse(url));
          if (response.statusCode == 200) {
               final List<dynamic> data = json.decode(response.body);
               
               // Debugging statement to print the fetched data
               print("Fetched data from URL: $data");
               
               return data.map((json) => EachDetails.fromJson(json)).toList();
          } 
     } catch (e) {
          print(e);
     }
  
     // Fallback to local asset if network fails
     final List<dynamic> data = json.decode(
     await rootBundle.loadString('assets/taitoku_kitsuenjo.json'),
     );
     
     // Debugging statement to print the local data
     print("-------------------Stored Data used: $data");
     
     return data.map((json) => EachDetails.fromJson(json)).toList();
}