import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;
part 'parkingLoc.g.dart';

//SAMPLE DATA !!!
//      {
//         "parkingTown": "東京都江東区",
//         "parkingTitle": "東陽二丁目駐車場",
//         "parkingLatitude": 35.66746,
//         "parkingLongitude": 139.8171,
//         "parkingInfo": "月極駐車場に空きがある場合、申込受付を随時行っています。月極利用条件：（1）東陽二丁目駐車場から半径2km以内にお住まいの区民の方（2）車の名義人が本人であること（法人契約は不可、ローンは可）（3）車の大きさが全長5m、全幅2m、全高2m以内",
//         "parkingCarType": "普通自動車・小型自動車・軽自動車（二輪車・トラックは除く）",
//         "parkingPhone": null
//     },

@JsonSerializable()
class LatLng {
  LatLng({
    required this.parkingLatitude,
    required this.parkingLongitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double parkingLatitude;
  final double parkingLongitude;
}

@JsonSerializable()
class Details {
  Details({
    required this.coords,
    required this.parkingTitle,
  });

  factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsToJson(this);

  final LatLng coords;
  final String parkingTitle;
}

@JsonSerializable()
class EachDetails {
  EachDetails({
    required this.parkingTown,
    required this.parkingTitle,
    required this.parkingLatitude,
    required this.parkingLongitude,
    required this.parkingInfo,
    required this.parkingCarType,
    required this.parkingPhone,
  });

  // factory EachDetails.fromJson(Map<String, dynamic> json) => _$EachDetailsFromJson(json);　//下のやつに変えることで、もし中身がnullであっても動く
  factory EachDetails.fromJson(Map<String, dynamic> json) {
    //nullだとエラー出るので、ここでnullの場合をunKnownとかにしてる
    //もしかしたらparkingInfoとか0, 1, にしてるからnullの場合を0にしたら困るかも　(確認中)  
    return EachDetails(
      parkingTown: json['parkingTown'] ?? 'Unknown',
      parkingTitle: json['parkingTitle'] ?? 'Unknown',
      parkingLatitude: (json['parkingLatitude'] ?? 0.0).toDouble(),
      parkingLongitude:(json['parkingLongitude'] ?? 0.0).toDouble(),
      parkingInfo: (json['parkingInfo'] ?? 'Unknown'),
      parkingCarType: (json['parkingCarType'] ?? 'Unknown'),
      parkingPhone: (json['parkingPhone'] ?? 'Unknown'),
    );
  }

  Map<String, dynamic> toJson() => _$EachDetailsToJson(this);

  final String parkingTown;
  final String parkingTitle;
  final double parkingLatitude;
  final double parkingLongitude;
  final String parkingInfo;
  final String parkingCarType;
  final String parkingPhone;
}

@JsonSerializable()
class ParkingList {
  ParkingList({
    required this.details,
    required this.eachDetails,
  });

  factory ParkingList.fromJson(Map<String, dynamic> json) =>
    _$ParkingListFromJson(json);
  Map<String, dynamic> toJson() => _$ParkingListToJson(this);

  final List<Details> details;
  final List<EachDetails> eachDetails;
}

Future<List<EachDetails>> fetchParkingData() async {
  const url = 'https://raw.githubusercontent.com/isoginchakus/data_set/main/parkingFinal.json';

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