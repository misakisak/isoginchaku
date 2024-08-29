import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/post.dart';
import 'package:flutter_application_1/pages/data.dart';
import 'package:flutter_application_1/pages/notifiers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/pages/settings.dart';
import 'package:flutter_application_1/pages/FAQs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application_1/pages/markerDetailspage.dart';
import 'src/kitsuenjoLoc2.dart' as kitsuenjoLoc;
import 'src/toiletLoc.dart' as toiletLoc;
import 'src/lanLoc.dart' as lanLoc;
import 'src/libraryLoc.dart' as libraryLoc;
import 'src/parkingLoc.dart' as parkingLoc;
import 'dart:developer' as developer;

class AfterLoginPage extends StatefulWidget {
  const AfterLoginPage({Key? key}) : super(key: key);

  @override
  _AfterLoginPageState createState() => _AfterLoginPageState(); 
}

class _AfterLoginPageState extends State<AfterLoginPage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();
  final Map<String, Marker> _markers = {};

  Key _mapKey = UniqueKey();
  // Add this state variable
  bool _isButtonVisible = false;
  List markerDataList = [];
  // List<List<dynamic>> markerDataList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    final currentSize = _controller.size;
    if (currentSize <= 0.05) _collapse();
  }

  void _collapse() => _animateSheet(0.0);

  void _expandSheet() => _animateSheet(0.3);

  void _animateSheet(double size) {
    _controller.animateTo(
      size,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  DraggableScrollableSheet get sheet => (_sheet.currentWidget as DraggableScrollableSheet);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final kitsuenjoData = await kitsuenjoLoc.fetchKitsuenjoData();
    final toiletData = await toiletLoc.fetchToiletData();
    final lanData = await lanLoc.fetchLanData();
    final libraryData = await libraryLoc.fetchLibraryData();
    final parkingData = await parkingLoc.fetchParkingData();

    setState(() {
      _markers.clear();
      for (final kitsuenjo in kitsuenjoData) {
        // print("Adding marker for: ${kitsuenjo.kitsuenjoTitle}, Lat: ${kitsuenjo.kitsuenjoLatitude}, Long: ${kitsuenjo.kitsuenjoLongitude}"); // Debug statement
        final marker = Marker(
          markerId: MarkerId(kitsuenjo.kitsuenjoTitle),
          position: LatLng(kitsuenjo.kitsuenjoLatitude, kitsuenjo.kitsuenjoLongitude),
          infoWindow: InfoWindow(
            title: kitsuenjo.kitsuenjoTitle,
            snippet: kitsuenjo.kitsuenjoStartTime,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          onTap: () {
            _expandSheet(); // Expand the sheet when marker is tapped
            print("Tokyo marker tapped! ${kitsuenjo.kitsuenjoLatitude}");
            setState(() {
              _isButtonVisible = true; // Show button when marker is tapped
            });
          },
        );
        _markers[kitsuenjo.kitsuenjoTitle] = marker;
      }

      for (final toilet in toiletData) {
        // print("Adding marker for: ${toilet.toiletName}, Lat: ${toilet.toiletLatitude}, Long: ${toilet.toiletLongitude}");
        final marker = Marker(
          markerId: MarkerId(toilet.toiletName),
          position: LatLng(toilet.toiletLatitude, toilet.toiletLongitude),
          infoWindow: InfoWindow(
            title: toilet.toiletName,
            snippet: toilet.toiletInfo,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () {
            _expandSheet(); // Expand the sheet when marker is tapped
            print("Tokyo marker tapped! ${toilet.toiletLatitude}");
            setState(() {
              _isButtonVisible = true; // Show button when marker is tapped
              markerDataList.clear();
              markerDataList.add("toilet");
              // markerDataList.add(toilet.toiletLatitude);
              // markerDataList.add(toilet.toiletLongitude);
              markerDataList.add(toilet.toiletTown);
              markerDataList.add(toilet.toiletName);
              markerDataList.add(toilet.toiletInfo);
            });
            print("makerData: ${markerDataList}");
          },
        );
        _markers[toilet.toiletName] = marker;
      }

      for (final lan in lanData) {
        // print("Adding marker for: ${lan.lanName}, Lat: ${lan.lanLatitude}, Long: ${lan.lanLongitude}");
        final marker = Marker(
          markerId: MarkerId(lan.lanName),
          position: LatLng(lan.lanLatitude, lan.lanLongitude),
          infoWindow: InfoWindow(
            title: lan.lanName,
            snippet: lan.lanSSID,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          onTap: () {
            _expandSheet(); // Expand the sheet when marker is tapped
            print("Tokyo marker tapped! ${lan.lanName}");
            // print("Marker: ${lan.lanName}");
            setState(() {
              _isButtonVisible = true; // Show button when marker is tapped
              markerDataList.clear();
              markerDataList.add(lan.lanName);
              markerDataList.add(lan.lanSSID);
              markerDataList.add(lan.lanSupplyArea);
              markerDataList.add(lan.lanPhone);
              markerDataList.add(lan.lanURL);
              markerDataList.add(lan.lanNotes);
            });
            print("markerDataList: ${markerDataList}");
          },
        );
        _markers[lan.lanName] = marker;
      }

      for (final library in libraryData) {
        // print("Adding marker for: ${library.libraryName}, Lat: ${library.libraryLatitude}, Long: ${library.libraryLongitude}");
        final marker = Marker(
          markerId: MarkerId(library.libraryName),
          position: LatLng(library.libraryLatitude, library.libraryLongitude),
          infoWindow: InfoWindow(
            title: library.libraryName,
            snippet: library.libraryDate,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
          onTap: () {
            _expandSheet(); // Expand the sheet when marker is tapped
            print("Tokyo marker tapped! ${library.libraryLatitude}");
            setState(() {
              _isButtonVisible = true; // Show button when marker is tapped
            });
          },
        );
        _markers[library.libraryName] = marker;
      }

      for (final parking in parkingData) {
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
            print("Tokyo marker tapped! ${parking.parkingLatitude}");
            _expandSheet(); // Expand the sheet when marker is tapped
            setState(() {
              _isButtonVisible = true; // Show button when marker is tapped
            });
          },
        );
        _markers[parking.parkingTitle] = marker;
      }
    });
  }

  void _updateMarkers(List<String> selectedFilters) async {

    setState(() {
      _markers.clear();

      if (selectedFilters.contains("Parking space")) {
        print("Parking selected");
        _addMarkersForOption1();
      }
      if (selectedFilters.contains("Charging point")) {
        _addMarkersForOption2();
      }
      if (selectedFilters.contains("Charging point")) {
        _addMarkersForOption3();
      }
      if (selectedFilters.contains("Smoking space")) {
        _addMarkersForOption4();
      }
    });
  }

  Future<void> _addMarkersForOption1() async {
    final parkingData = await parkingLoc.fetchParkingData();
    for (final parking in parkingData) {
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
          print("Tokyo marker tapped! ${parking.parkingLatitude}");
          _expandSheet(); // Expand the sheet when marker is tapped
          setState(() {
            _isButtonVisible = true; // Show button when marker is tapped
          });
        },
      );
      _markers[parking.parkingTitle] = marker;
    }
  }

  Future<void> _addMarkersForOption2() async {
    final lanData = await lanLoc.fetchLanData();
    for (final lan in lanData) {
      // print("Adding marker for: ${lan.lanName}, Lat: ${lan.lanLatitude}, Long: ${lan.lanLongitude}");
      final marker = Marker(
        markerId: MarkerId(lan.lanName),
        position: LatLng(lan.lanLatitude, lan.lanLongitude),
        infoWindow: InfoWindow(
          title: lan.lanName,
          snippet: lan.lanSSID,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        onTap: () {
          _expandSheet(); // Expand the sheet when marker is tapped
          print("Tokyo marker tapped! ${lan.lanLatitude}");
          print("markers: ${lan.lanLatitude}");
          setState(() {
            _isButtonVisible = true; // Show button when marker is tapped
          });
        },
      );
      _markers[lan.lanName] = marker;
    }
  }

  Future<void> _addMarkersForOption3() async {
    final libraryData = await libraryLoc.fetchLibraryData();
    for (final library in libraryData) {
      // print("Adding marker for: ${library.libraryName}, Lat: ${library.libraryLatitude}, Long: ${library.libraryLongitude}");
      final marker = Marker(
        markerId: MarkerId(library.libraryName),
        position: LatLng(library.libraryLatitude, library.libraryLongitude),
        infoWindow: InfoWindow(
          title: library.libraryName,
          snippet: library.libraryDate,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        onTap: () {
          _expandSheet(); // Expand the sheet when marker is tapped
          print("Tokyo marker tapped! ${library.libraryLatitude}");
          setState(() {
            _isButtonVisible = true; // Show button when marker is tapped
          });
        },
      );
      _markers[library.libraryName] = marker;
    }
  }

  Future<void> _addMarkersForOption4() async {
    final kitsuenjoData = await kitsuenjoLoc.fetchKitsuenjoData();
    for (final kitsuenjo in kitsuenjoData) {
      // print("Adding marker for: ${kitsuenjo.kitsuenjoTitle}, Lat: ${kitsuenjo.kitsuenjoLatitude}, Long: ${kitsuenjo.kitsuenjoLongitude}"); // Debug statement
      final marker = Marker(
        markerId: MarkerId(kitsuenjo.kitsuenjoTitle),
        position: LatLng(kitsuenjo.kitsuenjoLatitude, kitsuenjo.kitsuenjoLongitude),
        infoWindow: InfoWindow(
          title: kitsuenjo.kitsuenjoTitle,
          snippet: kitsuenjo.kitsuenjoStartTime,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () {
          _expandSheet(); // Expand the sheet when marker is tapped
          print("Tokyo marker tapped! ${kitsuenjo.kitsuenjoLatitude}");
          setState(() {
            _isButtonVisible = true; // Show button when marker is tapped
          });
        },
      );
      _markers[kitsuenjo.kitsuenjoTitle] = marker;
    }
  }

  void _refreshMap() {
    setState(() {
      // The GoogleMap widget rebuilds with the updated markers
      // Any additional logic for refreshing the map can be added here
    });
  }

  _showMultiChoiceDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      final _multipleNotifier = Provider.of<MultipleNotifier>(context);
      return AlertDialog(
        title: Text("絞り込み"),
        content: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: places
                .map((e) => CheckboxListTile(
                  title: Text(e),
                  onChanged: (value) {
                    value!
                      ? _multipleNotifier.addItem(e)
                      : _multipleNotifier.removeItem(e);
                      // print("Current selected items: ${_multipleNotifier.selectedItems}"); // Debug statement
                  },
                  value: _multipleNotifier.isHaveItem(e),
                ))
                .toList(),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            child: Text("確定"),
            onPressed: () {
              // print("Current selected items: ${_multipleNotifier.selectedItems}"); // Debug statement
              Navigator.of(context).pop();
              _updateMarkers(_multipleNotifier.selectedItems);
            },
          ),
        ],
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "ホーム",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal,
        ),
        drawer: Drawer(
          backgroundColor: Colors.teal[400],
          child: Column(
            children: [
              DrawerHeader(
                  child: Icon(
                Icons.favorite,
                color: Colors.white,
              )),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text(
                  'ホーム',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AfterLoginPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  '設定',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: Colors.white,
                ),
                title: Text(
                  'よくある質問',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FaqPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            DraggableScrollableSheet(
              key: _sheet,
              initialChildSize: 0, //Start hidden
              maxChildSize: 0.7, //Max height of the sheet
              minChildSize: 0, //minimum height (hidden)
              expand: false,
              controller: _controller,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 20, // Example item count
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Item $index'),
                      );
                    },
                  ),
                );
              },
            ),
            GoogleMap(
              key: _mapKey,
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: LatLng(35.7150046548125, 139.79697716509338), // Tokyo coordinates as initial position
                zoom: 15,
              ),
              markers: _markers.values.toSet(),
            ),         
            Align(
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                child: Text(
                  '絞り込み',
                  style: TextStyle(color: Colors.teal[900]),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0), // Customize as needed
                  ),
                ),
                onPressed: () => _showMultiChoiceDialog(context),
              )
            ),
             // Conditionally show the button
            if (_isButtonVisible)
              Positioned(
                bottom: 20,
                left: 20,
                child: ElevatedButton(
                  child: Text(
                    '詳細',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0), // Customize as needed
                    ),
                  ),
                  // onPressed: () => _showMultiChoiceDialog(context),
                  onPressed: () {
                    // Navigate to the details page with the selected marker data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MarkerDetailsPage(
                          markerData: markerDataList!,
                        ),
                      ),
                    );
                  },
                ),
              ),
          ]
        ),
               
        // この下は投稿画面（postpage）に移動するボタンと動きを書いてる。
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.teal[900],
          ),
          backgroundColor: Colors.white,
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