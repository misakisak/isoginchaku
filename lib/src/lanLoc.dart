import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'lanLoc.g.dart';

//SAMPLE DATA !!!
     // {
     //    "lanTown ": "江東区",
     //    "lanTown": "江東区役所",
     //    "lanLatitude": 35.67277,
     //    "lanLongitude": 139.8173,
     //    "lanSupplyArea": "2F区民ホール/3Fきっずコーナー",
     //    "lanSSID": "Koto_City_Free_Wi-Fi",
     //    "lanPhone": "(03)3647-9367",
     //    "lanURL": "https://www.city.koto.lg.jp/012105/koto_city_free_wi-fi.html",
     //    "lanNotes": null
     // },


@JsonSerializable()
class LatLng {
  LatLng({
    required this.lanLatitude,
    required this.lanLongitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lanLatitude;
  final double lanLongitude;
}

@JsonSerializable()
class Details {
  Details({
    required this.coords,
    required this.lanName,
  });

  factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsToJson(this);

  final LatLng coords;
  final String lanName;
}

@JsonSerializable()
class EachDetails {
  EachDetails({
    required this.lanTown,
    required this.lanName,
    required this.lanLatitude,
    required this.lanLongitude,
    required this.lanSupplyArea,
    required this.lanSSID,
    required this.lanPhone,
    required this.lanURL,
    required this.lanNotes,

  });

  // factory EachDetails.fromJson(Map<String, dynamic> json) => _$EachDetailsFromJson(json);　//下のやつに変えることで、もし中身がnullであっても動く
  factory EachDetails.fromJson(Map<String, dynamic> json) {
     //nullだとエラー出るので、ここでnullの場合をunKnownとかにしてる
     //もしかしたらlanSupplyAreaとか0, 1, にしてるからnullの場合を0にしたら困るかも　(確認中)  
     return EachDetails(
          lanTown: json['lanTown'] ?? 'Unknown',
          lanName: json['lanName'] ?? 'Unknown',
          lanLatitude: (json['lanLatitude'] ?? 0.0).toDouble(),
          lanLongitude:(json['lanLongitude'] ?? 0.0).toDouble(),
          lanSupplyArea: json['lanSupplyArea'] ?? 'Not Known',
          lanSSID: json['lanSSID'] ?? 'Not Known',
          lanPhone: json['lanPhone'] ?? 'Not Known',
          lanURL: json['lanURL'] ?? 'Not Known',
          lanNotes: json['lanNotes'] ?? 'No Data',
     );
  }

  Map<String, dynamic> toJson() => _$EachDetailsToJson(this);

  final String lanTown;
  final String lanName;
  final double lanLatitude;
  final double lanLongitude;
  final String lanSupplyArea;
  final String lanSSID;
  final String lanPhone;
  final String lanURL;
  final String lanNotes;
  
}


@JsonSerializable()
class LanList {
  LanList({
    required this.details,
    required this.eachDetails,
  });

  factory LanList.fromJson(Map<String, dynamic> json) =>
    _$LanListFromJson(json);
  Map<String, dynamic> toJson() => _$LanListToJson(this);

  final List<Details> details;
  final List<EachDetails> eachDetails;
}

Future<List<EachDetails>> fetchLanData() async {
     const url = 'https://raw.githubusercontent.com/isoginchakus/data_set/main/lanFinal.json';

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