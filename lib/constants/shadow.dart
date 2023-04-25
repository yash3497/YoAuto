import 'package:flutter/material.dart';

customShadow() => BoxShadow(
      color: Colors.black.withOpacity(0.25),
      spreadRadius: 0,
      blurRadius: 4,
      offset: const Offset(0, 4), // changes position of shadow
    );
