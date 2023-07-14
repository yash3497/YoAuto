import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yoauto_task/constants/colors.dart';

class GoogleMapScreen extends StatefulWidget {
  final double plat;
  final double plng;
  final double dlat;
  final double dlng;
  const GoogleMapScreen(
      {super.key,
      required this.plat,
      required this.plng,
      required this.dlat,
      required this.dlng});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Set<Marker> markers = {};
  CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(0.0, 0.0),
    zoom: 14.0,
  );
  GoogleMapController? _mapController;
  double lat = 0.0;
  double lng = 0.0;
  Set<Polyline> polylines = {};
  _setPolyLine() async {
    if (widget.dlat != 0.0 && widget.dlng != 0.0) {
      Polyline polyline = Polyline(
        polylineId: const PolylineId('polylineId'),
        color: yellow,
        width: 5,
        points: [
          LatLng(widget.plat, widget.plng),
          LatLng(widget.dlat, widget.dlng),
        ],
      );
      markers.add(
        Marker(
          markerId: const MarkerId('drop_location'),
          position: LatLng(widget.dlat, widget.dlng),
        ),
      );
      polylines.add(polyline);
    }
  }

  _updateGoogleMap() async {
    _initialPosition = CameraPosition(
      target: LatLng(widget.plat, widget.plng),
      zoom: widget.dlat != 0.0 && widget.dlng != 0.0 ? 13.5 : 14.0,
    );
    //update marker position
    markers.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(widget.plat, widget.plng),
      ),
    );
  }

  String? _mapStyle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setPolyLine();
    rootBundle.loadString('assets/jsons/map_style.json').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _updateGoogleMap(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GoogleMap(
              initialCameraPosition: _initialPosition,
              markers: markers,
              polylines: polylines,
              myLocationEnabled: true,
              onMapCreated: (controller) {
                _mapController = controller;
                controller.setMapStyle(_mapStyle);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
