import 'dart:async';

import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService {
  // Create a location object
  final Location location = Location();

  // Create a stream controller to emit location updates
  final StreamController<LocationData> _locationStreamController =
      StreamController<LocationData>();

  // Firestore collection reference to store location data
  final CollectionReference<Map<String, dynamic>> _locationCollectionReference =
      FirebaseFirestore.instance.collection('locations');

  // Start listening to location updates
  void start() {
    location.onLocationChanged.listen((locationData) {
      // Add the location data to the stream controller
      _locationStreamController.add(locationData);

      // Store the location data in Firestore
      _locationCollectionReference.add({
        'latitude': locationData.latitude,
        'longitude': locationData.longitude,
        'timestamp': Timestamp.now(),
      });
    });
  }

  // Stop listening to location updates
  void stop() {
    _locationStreamController.close();
  }

  // Get the location stream to listen for updates
  Stream<LocationData> get locationStream => _locationStreamController.stream;
}
