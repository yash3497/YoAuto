import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class GradButton extends StatefulWidget {
  List<Color>? enableColors;
  List<Color>? disableColors;
  String? title;
  bool? isCorrect = false;
  GradButton(
      {super.key,
      this.isCorrect,
      this.title,
      this.enableColors,
      this.disableColors});

  @override
  State<GradButton> createState() => _GradButtonState();
}

class _GradButtonState extends State<GradButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      height: context.screenHeight / 15,
      width: context.screenWidth / 2,
      decoration: BoxDecoration(
          gradient: widget.isCorrect!
              ? LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.center,
                  tileMode: TileMode.mirror,
                  colors: widget.enableColors ??
                      [Colors.green.shade500, Colors.amber.shade500])
              : LinearGradient(
                  colors: widget.disableColors ??
                      [
                        Colors.grey.shade200,
                        Colors.grey.shade300,
                      ]),
          color: Colors.blue,
          borderRadius: BorderRadius.circular(18)),
      child: Center(
        child: Text(
          widget.title ?? 'Continue',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: widget.isCorrect! ? Colors.black : Colors.grey),
        ),
      ),
    );
  }
}
