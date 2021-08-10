import 'package:flutter/material.dart';

class ElevatedIcon extends StatelessWidget {
  final double size;
  final double elevation;
  final IconData icon;
  final Color bgColors;
  final Color icColors;
  final Function onPressed;

  const ElevatedIcon({
    Key? key,
    required this.size,
    required this.elevation,
    required this.icon,
    required this.bgColors,
    required this.icColors,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColors,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent, // button color
          child: InkWell(
            splashColor: Colors.lightBlueAccent, // inkwell color
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                icon,
                color: icColors,
                size: size-20,
              ),
            ),
            onTap: (){
              onPressed();
            },
          ),
        ),
      ),
    );
  }
}