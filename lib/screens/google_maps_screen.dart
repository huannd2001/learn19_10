import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

class GoogleMapsScreen extends StatefulWidget {
  const GoogleMapsScreen({super.key});

  @override
  State<GoogleMapsScreen> createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  Completer<GoogleMapController> googleMapControler = Completer();
  // LatLng currentLocation = const LatLng(21.028511, 105.804817);
  CameraPosition locationHome = const CameraPosition(
    target: LatLng(21.13701408960285, 105.79696641932928),
    // target: LatLng(21.210912404425105, 104.95648696782617), // phu xuan
    // target: LatLng(21.03076044102241, 105.80607022563568),
    zoom: 15,
  );
  BitmapDescriptor? customIcon;

  List<Marker> listLocation = [];

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }

  void loadMarkers() async {
    // customIcon = await BitmapDescriptor.fromAssetImage(
    //   ImageConfiguration.empty,
    //   'assets/hospital.png',
    // );
    String imgurl = "https://www.fluttercampus.com/img/car.png";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
        .buffer
        .asUint8List();
    setState(() {});
    listLocation = [
      Marker(
        icon: BitmapDescriptor.fromBytes(bytes),
        markerId: const MarkerId('1'),
        position: const LatLng(21.03076044102241, 105.80607022563568),
        infoWindow: const InfoWindow(
          title: 'Thủ Lệ',
        ),
      ),
      Marker(
        icon: BitmapDescriptor.fromBytes(bytes),
        markerId: const MarkerId('2'),
        position: const LatLng(21.04243090439535, 105.83082964540735),
        infoWindow: const InfoWindow(
          title: 'Cây xăng',
        ),
      ),
      Marker(
        icon: BitmapDescriptor.fromBytes(bytes),
        markerId: const MarkerId('3'),
        position: const LatLng(21.028772376541703, 105.83530443039199),
        infoWindow: const InfoWindow(
          title: 'Văn Miếu',
        ),
      ),
    ];
  }

  String dropdownvalue = 'Select Location';
  @override
  Widget build(BuildContext context) {
    const List<String> listNames = <String>[
      'Select Location',
      'Thủ Lệ',
      'Cây xăng',
      'Văn Miếu'
    ];

    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          myLocationEnabled: true,
          markers: Set.from(listLocation),
          mapType: MapType.normal,
          initialCameraPosition: locationHome,
          onMapCreated: (GoogleMapController controller) {
            // controller.animateCamera(
            //   CameraUpdate.newLatLngBounds(
            //       LatLngBounds(
            //         southwest:
            //             const LatLng(20.973042463633096, 105.84937082523628),
            //         northeast:
            //             const LatLng(21.041936206722223, 105.7692502390739),
            //       ),
            //       0),
            // );
            print('google camera');
            googleMapControler.complete(controller);
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 220),
          child: DropdownButton<String>(
            value: dropdownvalue,
            items: listNames.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                dropdownvalue = value ?? 'Select Location';
              });
              switch (value) {
                case 'Select Location':
                  setLacation(locationHome.target);
                  break;
                case 'Thủ Lệ':
                  setLacation(listLocation[0].position);
                  break;
                case 'Cây xăng':
                  setLacation(listLocation[1].position);
                  break;
                case 'Văn Miếu':
                  setLacation(listLocation[2].position);
                  break;
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> setLacation(LatLng target) async {
    final GoogleMapController controller = await googleMapControler.future;
    var cameraPosition = CameraPosition(
      target: target,
      zoom: 15,
    );

    // controller.animateCamera(
    //   CameraUpdate.newLatLngBounds(
    //       LatLngBounds(
    //         southwest: const LatLng(20.973042463633096, 105.84937082523628),
    //         northeast: const LatLng(21.041936206722223, 105.7692502390739),
    //       ),
    //       0),
    // );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
