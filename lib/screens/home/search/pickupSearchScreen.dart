import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/screens/home/mainHome.dart';
import 'package:http/http.dart' as http;

class PickupSearchDelegate extends SearchDelegate {
  static String? selectedValue;

  getSuggestions() async {
    if (query.isNotEmpty) {
      String url =
          'https://atlas.mapmyindia.com/api/places/search/json?query=$query';
      String accessToken = '7b882118-827e-4edb-ba1d-49b543207ab8';
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
      var addresses = await Geocoder.local.findAddressesFromQuery(query);
      var first = addresses.first;

      return first.coordinates;
    } catch (e) {
      print(e);
    }
    return Coordinates(0, 0);
  }

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
                  prefs.setString('pickupLocation', query);
                  Coordinates coordinates = await latlongFromAddress();
                  log("Coordinates: $coordinates");
                  prefs.setDouble('pickupLat', coordinates.latitude!);
                  prefs.setDouble('pickupLong', coordinates.longitude!);
                  Get.to(HomeScreen(),
                      transition: Transition.fade,
                      duration: Duration(milliseconds: 300));
                },
                child: ListTile(
                  title: Text(result),
                  tileColor: Vx.gray100,
                  leading: Icon(Icons.location_city),
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
  getSuggestions() async {
    if (query.isNotEmpty) {
      String url =
          'https://atlas.mapmyindia.com/api/places/search/json?query=$query';
      String accessToken = '7b882118-827e-4edb-ba1d-49b543207ab8';
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
      var addresses = await Geocoder.local.findAddressesFromQuery(query);
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
            prefs.setString('dropLocation', query);
            prefs.setDouble('dropLat', coordinates.latitude);
            prefs.setDouble('dropLong', coordinates.longitude);
            Get.to(HomeScreen(),
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
