import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';
import 'package:restobuy_supplier_flutter/data/models/home_category_model.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/app_bar_home.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/search_bar.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';

class HomeScreen extends StatelessWidget {
  List<HomeCategoryModel> categoryList = [];
  @override
  Widget build(BuildContext context) {
    addDataInModel();
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
      body: Column(
        children: [
          SearchBar(),

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: GridView.count(
                  shrinkWrap: false,
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  physics: BouncingScrollPhysics(),
                  children: List.generate(categoryList.length, (index) {
                  return InkWell(
                    child: SlideInUp(
                      child: Card(
                        elevation: 8,
                        color: Colors.white,
                        shadowColor: Colors.grey.withOpacity(0.2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  child: Txt(txt: categoryList[index].count, txtColor: Colors.white, txtSize: 12, fontWeight: FontWeight.normal, padding: 0, onTap: (){})),
                            ),

                            Icon(
                              categoryList[index].icon,
                              color: Colors.amber,
                              size: 55,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 5),
                              child: Txt(
                                  txt: categoryList[index].category, txtColor: Colors.black, txtSize: 16, fontWeight: FontWeight.bold, padding: 0, onTap: () {}),
                            ),

                            SizedBox(width: double.maxFinite,),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      openPage(context, categoryList[index].category);
                    },
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openPage(BuildContext context, String category) {
    switch (category) {
      case 'PRODUCT':
        Navigator.of(context).pushNamed(RouteList.product);
        break;
      case 'REQUISITIONS':
       Navigator.of(context).pushNamed(RouteList.requisitions);
        break;
      case 'PURCHASE ORDER':
        Navigator.of(context).pushNamed(RouteList.purchase_order);
        break;
      case 'INVOICE':
        Navigator.of(context).pushNamed(RouteList.invoice);
        break;
      case 'TRANSACTION':
        Navigator.of(context).pushNamed(RouteList.transaction);
        break;
      case 'REVIEW':
        Navigator.of(context).pushNamed(RouteList.review);
        break;
    }
  }


  void addDataInModel() {
    categoryList.add(HomeCategoryModel(category: 'PRODUCT', icon: Icons.shopping_bag, count: '500'));
    categoryList.add(HomeCategoryModel(category: 'REQUISITIONS', icon: Icons.assignment_rounded, count: '10'));
    categoryList.add(HomeCategoryModel(category: 'PURCHASE ORDER', icon: Icons.account_tree_rounded, count: '15'));
    categoryList.add(HomeCategoryModel(category: 'INVOICE', icon: Icons.list_alt_rounded, count: '08'));
    categoryList.add(HomeCategoryModel(category: 'TRANSACTION', icon: Icons.account_balance_wallet_rounded, count: '08'));
    categoryList.add(HomeCategoryModel(category: 'REVIEW', icon: Icons.star_half_rounded, count: '800'));
  }
}
