// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AddonContainer extends StatefulWidget {
  Widget? Icon;
  String? title;
  String? price;
  AddonContainer({super.key, this.title, this.Icon, this.price});

  @override
  State<AddonContainer> createState() => _AddonContainerState();
}

class _AddonContainerState extends State<AddonContainer> {
  bool first = false;
  bool second = false;
  bool third = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(children: [
      ListTile(
          leading: widget.Icon ??
              Icon(
                Icons.watch,
                color: Colors.green,
              ),
          title: Text(
            widget.title ?? "Chocolate",
            style: TextStyle(fontSize: 20),
          ),
          trailing: SizedBox(
            width: 150,
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.price ?? ""),
                first
                    ? IconButton(
                        icon: Icon(
                          Icons.check_box_sharp,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          setState(() {
                            first = !first;
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.check_box_outline_blank),
                        onPressed: () {
                          setState(() {
                            first = !first;
                          });
                        },
                      ),
              ],
            ),
          ))
    ]);
  }
}
