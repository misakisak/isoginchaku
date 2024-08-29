import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;
part 'kitsuenjoLoc2.g.dart';

//SAMPLE DATA !!!
//      {
//         "kitsuenjoTown": "東京都江東区",
//         "kitsuenjoTitle": "東陽二丁目駐車場",
//         "kitsuenjoLatitude": 35.66746,
//         "kitsuenjoLongitude": 139.8171,
//         "kitsuenjoPlace": "月極駐車場に空きがある場合、申込受付を随時行っています。月極利用条件：（1）東陽二丁目駐車場から半径2km以内にお住まいの区民の方（2）車の名義人が本人であること（法人契約は不可、ローンは可）（3）車の大きさが全長5m、全幅2m、全高2m以内",
//         "kitsuenjoStartTime": "普通自動車・小型自動車・軽自動車（二輪車・トラックは除く）",
//         "kitsuenjoEndTime": null
//     },

@JsonSerializable()
class LatLng {
  LatLng({
    required this.kitsuenjoLatitude,
    required this.kitsuenjoLongitude,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double kitsuenjoLatitude;
  final double kitsuenjoLongitude;
}

@JsonSerializable()
class Details {
  Details({
    required this.coords,
    required this.kitsuenjoTitle,
  });

  factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsToJson(this);

  final LatLng coords;
  final String kitsuenjoTitle;
}

@JsonSerializable()
class EachDetails {
  EachDetails({
    required this.kitsuenjoTown,
    required this.kitsuenjoTitle,
    required this.kitsuenjoLatitude,
    required this.kitsuenjoLongitude,
    required this.kitsuenjoPlace,
    required this.kitsuenjoStartTime,
    required this.kitsuenjoEndTime,
    required this.kitsuenjoNote,
  });

  // factory EachDetails.fromJson(Map<String, dynamic> json) => _$EachDetailsFromJson(json);　//下のやつに変えることで、もし中身がnullであっても動く
  factory EachDetails.fromJson(Map<String, dynamic> json) {
    //nullだとエラー出るので、ここでnullの場合をunKnownとかにしてる
    //もしかしたらkitsuenjoPlaceとか0, 1, にしてるからnullの場合を0にしたら困るかも　(確認中)  
    return EachDetails(
      kitsuenjoTown: json['kitsuenjoTown'] ?? 'Unknown',
      kitsuenjoTitle: json['kitsuenjoTitle'] ?? 'Unknown',
      kitsuenjoLatitude: (json['kitsuenjoLatitude'] ?? 0.0).toDouble(),
      kitsuenjoLongitude:(json['kitsuenjoLongitude'] ?? 0.0).toDouble(),
      kitsuenjoPlace: (json['kitsuenjoPlace'] ?? 'Unknown'),
      kitsuenjoStartTime: (json['kitsuenjoStartTime'] ?? 'Unknown'),
      kitsuenjoEndTime: (json['kitsuenjoEndTime'] ?? 'Unknown'),
      kitsuenjoNote: (json['kitsuenjoNote'] ?? 'Unknown'),
    );
  }

  Map<String, dynamic> toJson() => _$EachDetailsToJson(this);

  final String kitsuenjoTown;
  final String kitsuenjoTitle;
  final double kitsuenjoLatitude;
  final double kitsuenjoLongitude;
  final String kitsuenjoPlace;
  final String kitsuenjoStartTime;
  final String kitsuenjoEndTime;
  final String kitsuenjoNote;
}


@JsonSerializable()
class KitsuenjoList {
  KitsuenjoList({
    required this.details,
    required this.eachDetails,
  });

  factory KitsuenjoList.fromJson(Map<String, dynamic> json) =>
    _$KitsuenjoListFromJson(json);
  Map<String, dynamic> toJson() => _$KitsuenjoListToJson(this);

  final List<Details> details;
  final List<EachDetails> eachDetails;
}

Future<List<EachDetails>> fetchKitsuenjoData() async {
  const url = 'https://raw.githubusercontent.com/isoginchakus/data_set/main/kitsuenjoFinal.json';

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