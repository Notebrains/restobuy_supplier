import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';

PreferredSizeWidget appBarIcBackCart (BuildContext context, String text){
  return AppBar(
    centerTitle: false,
    elevation: 0.5,
    title: Text(
      text, style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.white,
    leading: GestureDetector(
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black87,// add custom icons also
      ),
      onTap: (){
        Navigator.pop(context);
      },
    ),

    /*actions: [
      BadgeIcon(
        icon: const Icon(
          Icons.shopping_cart_rounded,
          size: 25,
          color: Colors.black87,
        ),
        badgeCount: 5,
        onTap: () {
          Navigator.of(context).pushNamed(RouteList.my_requisition);
        },
      ),
    ],*/
  );
}