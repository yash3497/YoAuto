import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yoauto_task/screens/BottomBar/master_screen.dart';
import 'package:yoauto_task/screens/home/mainHome.dart';
import 'package:yoauto_task/screens/home/mainScreen.dart';

class PickupSearchDelegate extends SearchDelegate {
  static String? selectedValue;

  // Demo list to show querying
  List<String> searchTerms = [
    "Terminal 2, Sahara International Airport",
    "Bandra, Railway Station West",
    "Andheri East, Bus Depo",
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
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
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
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return Column(
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
          itemCount: matchQuery.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var result = matchQuery[index];

            return InkWell(
              onTap: () async {
                query = result;
                var prefs = await SharedPreferences.getInstance();
                prefs.setString('pickupLocation', query);
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
    );
  }
}

//---------Drop-Location------------//
class DropSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    "Terminal 2, Sahara International Airport",
    "Bandra, Railway Station West",
    "Andheri East, Bus Depo",
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
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
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
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () async {
            query = result;
            var prefs = await SharedPreferences.getInstance();
            prefs.setString('dropLocation', query);
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
