import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/home_category_model.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/menu/menu.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/profile/profile.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/setting/setting.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/app_bar_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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

  static final List<Widget> _widgetOptions = <Widget>[
    const Menu(),
    const Profile(),
    Setting(),
  ];

  @override
  void initState() {
    super.initState();

    updateDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16,0,16,16,),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          boxShadow: [BoxShadow(color: Colors.grey.shade400, spreadRadius: 0, blurRadius: 8),],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            iconSize: 28,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.black,
            items: const <BottomNavigationBarItem>[
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

  void updateDeviceToken() async {
    try{
      String? userId = await MySharedPreferences().getUserId();
      String? firebaseToken = await FirebaseMessaging.instance.getToken();

      if (kDebugMode) {
        print('---- userId: $userId');
        print('---- firebaseToken: $firebaseToken');
      }

      Future.delayed(const Duration(microseconds: 500)).then((value) async {
        Map<String, dynamic> body = {};
        body['user_id'] = userId;
        body['device_token'] = firebaseToken;

        await ApiFun.apiPostWithBody(ApiConstants.updateDeviceToken, body);
      });

    } catch(error){
      print("Error: $error");
    }
  }
}
