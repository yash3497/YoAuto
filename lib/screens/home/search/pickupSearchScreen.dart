import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_geocoder/location_geocoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/constants/ids.dart';
import 'package:yoauto_task/screens/home/mainHome.dart';
import 'package:http/http.dart' as http;
import 'package:yoauto_task/screens/home/mainScreen.dart';

import '../../../constants/constant.dart';

class PickupSearchDelegate extends SearchDelegate {
  static String? selectedValue;

  getSuggestions() async {
    if (query.isNotEmpty) {
      String url =
          'https://atlas.mapmyindia.com/api/places/search/json?query=$query';
      Uri uri = Uri.parse('$url&access_token=$accessToken');
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List suggestions = data['suggestedLocations'];
        searchTerms =
            suggestions.map((e) => e['placeAddress'].toString()).toList();
        print(searchTerms);
      } else {
        print(
            "PickupSearchDelegate: Error ${response.statusCode} ${response.body}");
      }
    } else {
      print("Null");
    }
  }

  Future<Coordinates> latlongFromAddress() async {
    try {
      final LocatitonGeocoder geocoder = LocatitonGeocoder(mapApiKey);
      var addresses = await geocoder.findAddressesFromQuery(query);
      var first = addresses.first;

      return first.coordinates;
    } catch (e) {
      print(e);
    }
    return Coordinates(0, 0);
  }

  // Demo list to show querying
  List<String> searchTerms = [
    "Bandra, Railway Station West, Mumbai",
    "Colaba, Gateway Of India, Mumbai",
    "Bandstand, Bandra West, Mumbai",
    "Chatrapati Shivaji Maharaj Terminus, Fort, Mumbai",
    "Juhu Beach, Mumbai",
    "Haji Ali, Malabar Hill, Mumbai"
  ];
  List<LatLng> demoCoordinates = const [
    LatLng(19.0596, 72.8295),
    LatLng(18.9067, 72.8147),
    LatLng(19.049029, 72.820647),
    LatLng(18.9398, 72.8354),
    LatLng(19.1075, 72.8263),
    LatLng(18.9827, 72.8089)
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    // List<String> matchQuery = [];
    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    return ListView.builder(
      itemCount: searchTerms.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var result = searchTerms[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    // List<String> matchQuery = [];
    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    getSuggestions();
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.location_pin),
            minLeadingWidth: 10,
            tileColor: Vx.amber300,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(
              "Select my current location",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ).p(12),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: searchTerms.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var result = searchTerms[index];

              return InkWell(
                onTap: () async {
                  query = result;
                  var prefs = await SharedPreferences.getInstance();
                  pickupLocation = query;
                  Coordinates coordinates = await latlongFromAddress();
                  // pickupLat = coordinates.latitude!;
                  // pickupLng = coordinates.longitude!;
                  pickupLat = demoCoordinates[index].latitude;
                  pickupLng = demoCoordinates[index].longitude;
                  Get.offAll(const MainScreen(),
                      transition: Transition.fade,
                      duration: const Duration(milliseconds: 300));
                },
                child: ListTile(
                  title: Text(result),
                  tileColor: Vx.gray100,
                  leading: const Icon(Icons.location_city),
                  minLeadingWidth: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ).p(8);
            },
          ),
        ],
      ),
    );
  }
}

//---------Drop-Location------------//
class DropSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    "Terminal 2, Chatrapati Shivaji Maharaj International Airport, Mumbai",
    "Bandra, Railway Station West, Mumbai",
    "Colaba, Gateway Of India, Mumbai",
    "Bandstand, Bandra West, Mumbai",
    "Chatrapati Shivaji Maharaj Terminus, Fort, Mumbai",
    "Juhu Beach, Mumbai",
    "Lower Parel Railway Station East, Mumbai",
    "Haji Ali, Malabar Hill, Mumbai"
  ];
  List<LatLng> demoCoordinates = const [
    LatLng(19.0596, 72.8295),
    LatLng(18.9067, 72.8147),
    LatLng(19.049029, 72.820647),
    LatLng(18.9398, 72.8354),
    LatLng(19.1075, 72.8263),
    LatLng(18.9827, 72.8089)
  ];
  getSuggestions() async {
    if (query.isNotEmpty) {
      String url =
          'https://atlas.mapmyindia.com/api/places/search/json?query=$query';

      Uri uri = Uri.parse('$url&access_token=$accessToken');
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List suggestions = data['suggestedLocations'];
        searchTerms =
            suggestions.map((e) => e['placeAddress'].toString()).toList();
        print(searchTerms);
      } else {
        print(
            "PickupSearchDelegate: Error ${response.statusCode} ${response.body}");
      }
    } else {
      print("Null");
    }
  }

  Future<Coordinates> latlongFromAddress() async {
    try {
      final LocatitonGeocoder geocoder = LocatitonGeocoder(mapApiKey);
      var addresses = await geocoder.findAddressesFromQuery(query);
      var first = addresses.first;

      return first.coordinates;
    } catch (e) {
      print(e);
    }
    return Coordinates(0, 0);
  }

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: searchTerms.length,
      itemBuilder: (context, index) {
        var result = searchTerms[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    getSuggestions();
    return ListView.builder(
      itemCount: searchTerms.length,
      itemBuilder: (context, index) {
        var result = searchTerms[index];
        return InkWell(
          onTap: () async {
            query = result;
            var prefs = await SharedPreferences.getInstance();
            Coordinates coordinates = await latlongFromAddress();
            dropLocation = query;
            // dropLat = coordinates.latitude!;
            // dropLng = coordinates.longitude!;
            dropLat = demoCoordinates[index].latitude;
            dropLng = demoCoordinates[index].longitude;
            Get.offAll(MainScreen(),
                transition: Transition.fade,
                duration: Duration(milliseconds: 300));
          },
          child: ListTile(
            title: Text(result),
            tileColor: Vx.gray100,
            leading: Icon(Icons.location_city),
            minLeadingWidth: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ).p(8);
      },
    );
  }
}
