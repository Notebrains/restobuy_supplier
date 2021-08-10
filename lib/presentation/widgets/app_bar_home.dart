import 'package:flutter/material.dart';

PreferredSizeWidget appBarHome (BuildContext context){
  return AppBar(
    title: Image.asset('assets/icons/pngs/logo.png', color: Colors.orange, fit: BoxFit.cover, width: 120),
    centerTitle: false,
    backgroundColor: Colors.white,
    elevation: 5,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.notifications_none_rounded,
          color: Colors.black54,
        ),
        onPressed: () {

        },
      ),
    ],
  );
}