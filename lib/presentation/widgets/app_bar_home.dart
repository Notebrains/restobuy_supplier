import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBarHome (BuildContext context){
  return AppBar(
    title: Image.asset('assets/images/logo_horizon.png', fit: BoxFit.cover, width: 120),
    centerTitle: false,
    backgroundColor: Colors.white,
    elevation: 3,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.notifications_none_rounded,
          color: Colors.black87,
        ),
        onPressed: () {

        },
      ),
    ],
  );
}