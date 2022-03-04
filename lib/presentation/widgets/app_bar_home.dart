
import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';

PreferredSizeWidget appBarHome(BuildContext context) {
  return AppBar(
    title: Row(
      children: const [
        Text(
          'Resto',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          'Buy',
          style: TextStyle(
            fontSize: 18,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0,
    toolbarHeight: 60,
    leadingWidth: 56,
    leading: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Image.asset('assets/images/logo.png'),
    ),

    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.notifications_active,
          color: Colors.black87,
        ),
        onPressed: () {
          Navigator.pushNamed(context, RouteList.notification);
        },
      ),
    ],
  );
}
