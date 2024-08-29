import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;
part 'toiletLoc.g.dart';

//SAMPLE DATA !!!
     //     "toiletTown": "江東区",
     //      "toiletName": "江東区立万年橋際公衆便所",
     //      "toiletLatitude": 35.68322,
     //      "toiletLongitude": 139.7948,
     //      "toiletMen": 1,
     //      "toiletWomen": 0,
     //      "toiletBoth": 0,
     //      "toiletBarrierFree": 1,
     //      "toiletWheelChair": 1,
     //      "toiletForKids": 0,
     //      "toiletOstomate": 1.0,
     //      "toiletInfo": "男性トイレ: 2 女性トイレ: 0 男女共用トイレ: 0 バリアフリートイレ: 1"

@JsonSerializable()
class LatLng {
  LatLng({
    required this.toiletLatitude,
    required this.toiletLongitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double toiletLatitude;
  final double toiletLongitude;
}

@JsonSerializable()
class Details {
  Details({
    required this.coords,
    required this.toiletName,
  });

  factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsToJson(this);

  final LatLng coords;
  final String toiletName;
}

@JsonSerializable()
class EachDetails {
  EachDetails({
    required this.toiletTown,
    required this.toiletName,
    required this.toiletLatitude,
    required this.toiletLongitude,
    required this.toiletMen,
    required this.toiletWomen,
    required this.toiletBoth,
    required this.toiletBarrierFree,
    required this.toiletWheelChair,
    required this.toiletForKids,
    required this.toiletOstomate,
    required this.toiletInfo,
  });

  // factory EachDetails.fromJson(Map<String, dynamic> json) => _$EachDetailsFromJson(json);　//下のやつに変えることで、もし中身がnullであっても動く
  factory EachDetails.fromJson(Map<String, dynamic> json) {
    //nullだとエラー出るので、ここでnullの場合をunKnownとかにしてる
    //もしかしたらtoiletMenとか0, 1, にしてるからnullの場合を0にしたら困るかも　(確認中)  
    return EachDetails(
      toiletTown: json['toiletTown'] ?? 'Unknown',
      toiletName: json['toiletName'] ?? 'Unknown',
      toiletLatitude: (json['toiletLatitude'] ?? 0.0).toDouble(),
      toiletLongitude:(json['toiletLongitude'] ?? 0.0).toDouble(),
      toiletMen: (json['toiletMen'] ?? 0).toInt(),
      toiletWomen: (json['toiletWomen'] ?? 0).toInt(),
      toiletBoth: (json['toiletBoth'] ?? 0).toInt(),
      toiletBarrierFree: (json['toiletBarrierFree'] ?? 0).toInt(),
      toiletWheelChair: (json['toiletWheelChair'] ?? 0).toInt(),
      toiletForKids: (json['toiletForKids'] ?? 0).toInt(),
      toiletOstomate: (json['toiletOstomate'] ?? 0).toInt(),  //小数点だからエラー出るかも
      toiletInfo: json['toiletInfo'] ?? 'No Data',
    );
  }

  Map<String, dynamic> toJson() => _$EachDetailsToJson(this);

  final String toiletTown;
  final String toiletName;
  final double toiletLatitude;
  final double toiletLongitude;
  final int toiletMen;
  final int toiletWomen;
  final int toiletBoth;
  final int toiletBarrierFree;
  final int toiletWheelChair;
  final int toiletForKids;
  final int toiletOstomate;
  final String toiletInfo; 
}

@JsonSerializable()
class ToiletList {
  ToiletList({
    required this.details,
    required this.eachDetails,
  });

  factory ToiletList.fromJson(Map<String, dynamic> json) =>
    _$ToiletListFromJson(json);
  Map<String, dynamic> toJson() => _$ToiletListToJson(this);

  final List<Details> details;
  final List<EachDetails> eachDetails;
}

Future<List<EachDetails>> fetchToiletData() async {
  const url = 'https://raw.githubusercontent.com/isoginchakus/data_set/main/toiletFinal.json';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Debugging statement to print the fetched data
      // print("Fetched data from URL: $data");
      
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
  // print("-------------------Stored Data used: $data");
  return data.map((json) => EachDetails.fromJson(json)).toList();
}