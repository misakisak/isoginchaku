import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Future<String> getAddressFromLatLng(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude, 
      longitude,
      // localeIdentifier: 'ja'
    );
    Placemark place = placemarks[0];

    // Format the address
    // String address = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    String address = "${place.country}, ${place.administrativeArea}, ${place.locality}, ${place.street}";
    return address;
  } catch (e) {
    print(e);
    return "Address not found";
  }
}

class MarkerDetailsPage extends StatefulWidget {
  final List markerData;
  MarkerDetailsPage({required this.markerData});

  @override
  _MarkerDetailsPageState createState() => _MarkerDetailsPageState();
}

class _MarkerDetailsPageState extends State<MarkerDetailsPage> {
  String _address = "住所取得中...";
  String _googleMapsUrl = "";
  String _travelTime = "移動時間を計算中...";

  @override
  void initState() {
    super.initState();
    _getAddress();
  }

  void _getAddress() async {
    try {
      // Ensure markerData[0] and markerData[1] can be parsed as doubles
      // print(widget.markerData[0].)
      double latitude = double.tryParse(widget.markerData[1].toString()) ?? 0.0; // Default to 0.0 if parsing fails
      double longitude = double.tryParse(widget.markerData[2].toString()) ?? 0.0; // Default to 0.0 if parsing fails

      // Check if the parsed latitude and longitude are valid
      if (latitude == 0.0 && longitude == 0.0) {
        setState(() {
          _address = "Invalid coordinates provided";
        });
        return;
      }

      print("latitude: $latitude, longitude: $longitude");

      // Generate Google Maps URL
      _googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

      String address = await getAddressFromLatLng(latitude, longitude);
      setState(() {
        _address = address;
      });

      await _calculateTravelTime(latitude, longitude);
    } catch (e) {
      print("Error in getting address: $e");
      setState(() {
        _address = "Error retrieving address";
      });
    }
  }

   Future<void> _calculateTravelTime(double destinationLat, double destinationLng) async {
    final apiKey = 'AIzaSyCv2zvaPgfL23LdiomOE5knZR8qyruDbZg';  // Replace with your API key
    final origin = '35.714765,139.796655';  // Sensō-ji's coordinates

    final url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destinationLat,$destinationLng&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          String travelTime = data['routes'][0]['legs'][0]['duration']['text'];
          setState(() {
            _travelTime = "推定移動時間: $travelTime";
          });
        } else {
          setState(() {
            _travelTime = "移動距離が計算できませんでした.";
          });
        }
      } else {
        setState(() {
          _travelTime = "Error fetching data from API.";
        });
      }
    } catch (e) {
      print("Error in calculating travel time: $e");
      setState(() {
        _travelTime = "Error calculating travel time.";
      });
    }
  }

  Future<void> _openGoogleMaps() async {
    if (await canLaunchUrlString(_googleMapsUrl)) {
      await launchUrlString(_googleMapsUrl);
    } else {
      throw 'Could not launch $_googleMapsUrl';
    }
  }

  Future<void> _shareLocation() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '', // Add recipient's email here if needed
      query: _encodeQueryParameters(<String, String>{
        'subject': 'Location Share',
        'body': 'Check out this location: $_googleMapsUrl',
      }),
    );

    if (!await launchUrl(emailLaunchUri)) {
      throw 'Could not launch email app';
    }
  }

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '詳細',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),  // Title is at index 1
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "・ ${markerData[1]}",
            //   style: TextStyle(fontSize: 18),
            // ),
            Text(
              "・ ${widget.markerData[3]}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "・ ${widget.markerData[4]}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "・ ${widget.markerData[5]}",
              style: TextStyle(fontSize: 18),
            ),
            // Text(
            //   "・ ${markerData[5]}",
            //   style: TextStyle(fontSize: 18),
            // ),
            Text(
              _address,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Text(
              _travelTime,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: _openGoogleMaps,
              child: Text(
                'Googleマップで開く',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2), // Customize as needed
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _shareLocation,
              child: Text(
                'メールでシェア',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}
