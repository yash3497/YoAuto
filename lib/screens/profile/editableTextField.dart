// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EditableTextField extends StatefulWidget {
  TextEditingController controller;
  String? label;
  String? initialValue;
  Widget? prefixIcon;
  bool? isEnable;
  EditableTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.initialValue,
      required this.prefixIcon,
      required this.isEnable})
      : super(key: key);

  @override
  State<EditableTextField> createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: TextFormField(
          controller: widget.controller,
          autofocus: true,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          readOnly: widget.isEnable ?? true,
          decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber, width: 3.0)),
              prefixIcon: widget.prefixIcon ?? Text("data"),
              labelText: widget.label ?? "",
              labelStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ),
    );
  }
}
