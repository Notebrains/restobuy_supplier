import 'package:flutter/material.dart';

PreferredSizeWidget appBarIcBack (BuildContext context, String text){
  return AppBar(
    centerTitle: false,
    elevation: 0,
    title: Text(
      text, style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
    ),
    backgroundColor: Colors.white,
    leading: GestureDetector(
      child: const Icon(
        Icons.arrow_back_ios_rounded,
        color: Colors.black,
        size: 22,
      ),
      onTap: (){
        Navigator.pop(context);
      },
    ),
  );
}