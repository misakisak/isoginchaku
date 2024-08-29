import 'package:flutter/material.dart';

class MarkerDetailsPage extends StatelessWidget {
  final List markerData;

  // Constructor to accept marker data as a List
  MarkerDetailsPage({required this.markerData});
  // print("markerData in other page ${markerData}");

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
            Text(
              "・ ${markerData[1]}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "・ ${markerData[2]}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "・ ${markerData[3]}",
              style: TextStyle(fontSize: 18),
            ),
          ]
        )
      )
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         markerData[1] ?? 'No Title',  // Title
      //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //       ),
      //       SizedBox(height: 16),
      //       if (markerData[2] != null)  // Snippet or description
      //         Text(
      //           markerData[2],
      //           style: TextStyle(fontSize: 16),
      //         ),
      //       SizedBox(height: 16),
      //       if (markerData[3] != null && markerData[4] != null)  // Latitude and Longitude
      //         Text(
      //           'Latitude: ${markerData[3]}',
      //           style: TextStyle(fontSize: 16),
      //         ),
      //       if (markerData[3] != null && markerData[4] != null)
      //         Text(
      //           'Longitude: ${markerData[4]}',
      //           style: TextStyle(fontSize: 16),
      //         ),
      //     ],
      //   ),
      // ),
    );
  }
}
