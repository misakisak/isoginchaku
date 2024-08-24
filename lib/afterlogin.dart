import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/post.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'src/kitsuenjoLoc2.dart' as kitsuenjoLoc;
import 'src/toiletLoc.dart' as toiletLoc;
import 'src/lanLoc.dart' as lanLoc;
import 'src/libraryLoc.dart' as libraryLoc;
import 'src/parkingLoc.dart' as parkingLoc;

import 'dart:developer' as developer;

class AfterLoginPage extends StatefulWidget {
  // const AfterLoginPage({super.key});
  const AfterLoginPage({Key? key}) : super(key: key);

  @override
  _AfterLoginPageState createState() => _AfterLoginPageState();
  
}

class _AfterLoginPageState extends State<AfterLoginPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final kitsuenjoData = await kitsuenjoLoc.fetchKitsuenjoData();
    final toiletData = await toiletLoc.fetchToiletData();
    final lanData = await lanLoc.fetchLanData();
    final libraryData = await libraryLoc.fetchLibraryData();
    final parkingData = await parkingLoc.fetchParkingData();
    
    // // Debug statement to check the parsed data
    // print("Fetched kitsuenjo data: ${kitsuenjoData.length}");

    setState(() {
      _markers.clear();
      for (final kitsuenjo in kitsuenjoData) {
        print("Adding marker for: ${kitsuenjo.kitsuenjoTitle}, Lat: ${kitsuenjo.kitsuenjoLatitude}, Long: ${kitsuenjo.kitsuenjoLongitude}"); // Debug statement
        final marker = Marker(
          markerId: MarkerId(kitsuenjo.kitsuenjoTitle),
          position: LatLng(kitsuenjo.kitsuenjoLatitude, kitsuenjo.kitsuenjoLongitude),
          infoWindow: InfoWindow(
            title: kitsuenjo.kitsuenjoTitle,
            snippet: kitsuenjo.kitsuenjoStartTime,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        );
        _markers[kitsuenjo.kitsuenjoTitle] = marker;
      }

      for (final toilet in toiletData) {
        // // Log the exact latitude and longitude values
        // print("Adding marker for: ${toilet.toiletName}, Lat: ${toilet.toiletLatitude}, Long: ${toilet.toiletLongitude}");
          
        final marker = Marker(
          markerId: MarkerId(toilet.toiletName),
          position: LatLng(toilet.toiletLatitude, toilet.toiletLongitude),
          infoWindow: InfoWindow(
            title: toilet.toiletName,
            snippet: toilet.toiletInfo,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        );
        _markers[toilet.toiletName] = marker;
      }

      for (final lan in lanData) {
        // Log the exact latitude and longitude values
        // print("Adding marker for: ${lan.lanName}, Lat: ${lan.lanLatitude}, Long: ${lan.lanLongitude}");
          
        final marker = Marker(
          markerId: MarkerId(lan.lanName),
          position: LatLng(lan.lanLatitude, lan.lanLongitude),
          infoWindow: InfoWindow(
            title: lan.lanName,
            snippet: lan.lanSSID,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        );
        _markers[lan.lanName] = marker;
      }

      for (final library in libraryData) {
        // Log the exact latitude and longitude values
        // print("Adding marker for: ${library.libraryName}, Lat: ${library.libraryLatitude}, Long: ${library.libraryLongitude}");
          
        final marker = Marker(
          markerId: MarkerId(library.libraryName),
          position: LatLng(library.libraryLatitude, library.libraryLongitude),
          infoWindow: InfoWindow(
            title: library.libraryName,
            snippet: library.libraryDate,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        );
        _markers[library.libraryName] = marker;
      }

      for (final parking in parkingData) {
        // Log the exact latitude and longitude values
        // print("Adding marker for: ${parking.parkingTitle}, Lat: ${parking.parkingLatitude}, Long: ${parking.parkingLongitude}");
          
        final marker = Marker(
          markerId: MarkerId(parking.parkingTitle),
          position: LatLng(parking.parkingLatitude, parking.parkingLongitude),
          infoWindow: InfoWindow(
            title: parking.parkingTitle,
            snippet: parking.parkingPhone,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          onTap: () {
            // Your custom behavior when the marker is tapped
            print("Tokyo marker tapped! ${parking.parkingLatitude}");
            // _showMarkerDetails();
          },
        );
        _markers[parking.parkingTitle] = marker;
      }

    });
  }

  @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Maps Sample App'),
  //         backgroundColor: Colors.green[700],
  //       ),
  //       body: GoogleMap(
  //         onMapCreated: _onMapCreated,
  //         initialCameraPosition: CameraPosition(
  //           target: _center,
  //           zoom: 11.0,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return MaterialApp (
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("After login & Map"),
          actions: <Widget>[
            IconButton(
              // この下はログイン画面に戻る動きを書いてある。
              icon: Icon(Icons.close),
              onPressed: () async {
                // ログイン画面に遷移＋チャット画面を破棄
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return SignInPage();
                  }),
                );
              },
            ),
          ],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(35.7150046548125, 139.79697716509338), // Tokyo coordinates as initial position
            zoom: 15,
          ),
          markers: _markers.values.toSet(),
        ),
        // この下は投稿画面（postpage）に移動するボタンと動きを書いてる。
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            // 投稿画面に遷移
            // この下のuserにFirebaseにあるユーザー情報を入れた。ここが元のと変わったところの一つ。
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return PostPage(user);
                }),
              );
            }
          },
        ),
        
      ),
    );
  }


}