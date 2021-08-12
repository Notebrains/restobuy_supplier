import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';
import 'package:restobuy_supplier_flutter/data/models/home_category_model.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/menu/menu.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/profile/profile.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/setting/setting.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/app_bar_home.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<HomeCategoryModel> categoryList = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Menu(),
    Profile(),
    Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [BoxShadow(color: Colors.grey.shade400, spreadRadius: 0, blurRadius: 8),],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            iconSize: 28,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.black,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home,), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.person, ), label: 'Profile'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
            ],

            onTap: _onItemTapped,
          ),
        )
    ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
