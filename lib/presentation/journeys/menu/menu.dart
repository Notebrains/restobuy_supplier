import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/DashboardApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/home_category_model.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<HomeCategoryModel> categoryList = [];

  late Future<bool> _future;
  late bool isApiDataAvailable = false;
  DashboardApiResModel model = DashboardApiResModel();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getDataFromApi() async {
    try{
      String? userId = await MySharedPreferences().getUserId();

      Map<String, dynamic> body = {};
      body['user_id'] = userId;

      await ApiFun.apiPostWithBody(ApiConstants.dashboard, body).then((jsonDecodeData) => {
        model = DashboardApiResModel.fromJson(jsonDecodeData),

        addDataInModel(model.response),
      });

      if(model.status == 1) {
        isApiDataAvailable = true;
      }
    } catch(error){
      print("Error: $error");
    }
    return isApiDataAvailable;
  }

  @override
  Widget build(BuildContext context) {
    _future = getDataFromApi();

    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(snapShot.hasData){
            if(isApiDataAvailable){
              return Container(
                padding: const EdgeInsets.only(top: 8),
                margin: const EdgeInsets.all(16),
                child: GridView.count(
                  shrinkWrap: false,
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 8,
                  physics: const BouncingScrollPhysics(),
                  children: List.generate(categoryList.length, (index) {
                    return InkWell(
                      child: SlideInUp(
                        child: Card(
                          elevation: 12,
                          color: Colors.white,
                          shadowColor: Colors.orange.withOpacity(0.2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                    width: 32,
                                    height: 18,
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(right: 5, bottom: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: BorderRadius.circular(3.0),
                                    ),
                                    child: Txt(txt: categoryList[index].count, txtColor: Colors.white, txtSize: 11, fontWeight: FontWeight.bold, padding: 0,)),
                              ),

                              Icon(
                                categoryList[index].icon,
                                color: Colors.amber.shade700,
                                size: 50,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 20, bottom: 5),
                                child: Txt(
                                  txt: categoryList[index].category, txtColor: Colors.grey.shade700, txtSize: 15, fontWeight: FontWeight.bold, padding: 0,),
                              ),

                              const SizedBox(width: double.maxFinite,),
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
              );
            }
            else {return NoDataFound(txt: 'Something went wrong! Please try again', onRefresh:(){});}
          } else {
            return const LottieLoading();
          }
        },
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
      case 'DISPUTE':
        Navigator.of(context).pushNamed(RouteList.dispute);
        break;
      case 'REVIEW':
        Navigator.of(context).pushNamed(RouteList.review);
        break;
    }
  }

  void addDataInModel(Response? response) {
    categoryList.clear();
    categoryList.add(HomeCategoryModel(category: 'PRODUCT', icon: Icons.shopping_bag_sharp, count: add0toSingleStr(response?.product.toString()?? '0')));
    categoryList.add(HomeCategoryModel(category: 'REQUISITIONS', icon: Icons.assignment_sharp, count: add0toSingleStr(response?.requisitions.toString()?? '0')));
    categoryList.add(HomeCategoryModel(category: 'PURCHASE ORDER', icon: Icons.account_tree_sharp, count: add0toSingleStr(response?.po.toString()?? '0')));
    categoryList.add(HomeCategoryModel(category: 'INVOICE', icon: Icons.list_alt_sharp, count:add0toSingleStr(response?.invoice.toString()?? '0') ));
    categoryList.add(HomeCategoryModel(category: 'TRANSACTION', icon: Icons.account_balance_wallet_sharp, count: add0toSingleStr(response?.transactions.toString()?? '0')));
    categoryList.add(HomeCategoryModel(category: 'DISPUTE', icon: Icons.contact_mail_sharp, count: add0toSingleStr(response?.disputes.toString()?? '0')));
    categoryList.add(HomeCategoryModel(category: 'REVIEW', icon: Icons.star_half_sharp, count: add0toSingleStr(response?.review.toString()?? '0')));
  }
}
