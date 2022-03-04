import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';

PreferredSizeWidget appBarNotification (BuildContext context,  Function() onTapOnPositiveBtn){
  return AppBar(
    centerTitle: false,
    elevation: 0,
    title: const Text(
      'Notification', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
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
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: IconButton(
          icon: const Icon(
            Icons.clear_all,
            color: Colors.black,
            size: 28,
          ),
          onPressed: () {
            showIosDialog(
                context,
                'Notification',
                'Are you sure you want to clear all notifications?',
                'No',
                'Confirm', (){
                  onTapOnPositiveBtn();
            }
            );
          },
        ),
      ),
    ],
  );
}