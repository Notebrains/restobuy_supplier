import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/app_bar_home.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(context),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [BoxShadow(color: Colors.grey.shade400, spreadRadius: 0, blurRadius: 8),],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          child: BottomNavigationBar(
            currentIndex: 0,
            iconSize: 28,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: Colors.black,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home,), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.person, ), label: 'Profile'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
              BottomNavigationBarItem(icon: Icon(Icons.logout,), label: 'Logout'),
            ],
          ),
        )
    ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: GridView.count(
            shrinkWrap: false,
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            physics: BouncingScrollPhysics(),
            children: List.generate(6, (index) {
            return Center(
              child: InkWell(
                child: SlideInUp(
                  child: Card(
                    elevation: 12,
                    color: Colors.white,
                    shadowColor: Colors.grey.withOpacity(0.2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              width: 35,
                              height: 20,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 5, bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              child: Txt(txt: '150', txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal, padding: 0, onTap: (){})),
                        ),

                        Icon(
                          Icons.shopping_bag_rounded,
                          color: Colors.amber,
                          size: 45,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 18, bottom: 5),
                          child: Txt(
                              txt: 'PRODUCT', txtColor: Colors.black, txtSize: 16, fontWeight: FontWeight.bold, padding: 0, onTap: () {}),
                        ),

                        SizedBox(width: double.maxFinite,),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  openPage(context, '');
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  void openPage(BuildContext context, String category) {
    switch (category) {
      case 'Home':
        //Navigator.pushReplacementNamed(context, Routes.orders_screen);
        break;
      /*     case 'Pick Up':
        Navigator.pushReplacementNamed(context, Routes.pick_up_screen);
        break;
      case 'Drop Off':
        Navigator.pushReplacementNamed(context, Routes.drop_off_screen);
        break;
      case 'Sales':
        Navigator.pushReplacementNamed(context, Routes.sales_screen);
        break;
      case 'Products':
        Navigator.pushReplacementNamed(context, Routes.product_screen);
        break;
      case 'Offers':
        Navigator.pushReplacementNamed(context, Routes.offers_screen);
        break;*/
    }
  }
}
