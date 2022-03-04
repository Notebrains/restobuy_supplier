import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/common/screenutil/screenutil.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/ProductApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/product/AddProduct.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/product_details/product_details.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/star_rating.dart';
import 'package:restobuy_supplier_flutter/presentation/themes/theme_color.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_top_radius.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';

import 'EditProduct.dart';

class Product extends StatefulWidget{
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late Future<bool> _future;
  late bool isApiDataAvailable = false;
  ProductApiResModel model = ProductApiResModel();


  @override
  void initState() {
    super.initState();
    _future = getDataFromApi();
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

      await ApiFun.apiPostWithBody(ApiConstants.product, body).then((jsonDecodeData) => {
        model = ProductApiResModel.fromJson(jsonDecodeData),
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

    return Scaffold(
      appBar: appBarIcBack(context, 'Product'),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(snapShot.hasData && snapShot.connectionState == ConnectionState.done){
            if(isApiDataAvailable){
              return SlideInUp(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 0.802,
                    // crossAxisSpacing: 1.0,
                    mainAxisSpacing: 4.0,
                    children: List.generate(model.response!.length, (index) {
                      return InkWell(
                        child: Card(
                          elevation: 8,
                          color: Colors.white,
                          margin: const EdgeInsets.fromLTRB(6, 6, 6, 10),
                          shadowColor: Colors.grey.withOpacity(0.4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              cachedNetImgWithCustomRadius(model.response![index].image!.toString(), 200, 110, 5, BoxFit.cover),

                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 8),
                                child: Txt(txt: model.response![index].productid!.toString(), txtColor: AppColor.appTxtAmber, txtSize: 12,
                                  fontWeight: FontWeight.normal, padding: 0,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 2),
                                child: Txt(txt: model.response![index].productName?? '', txtColor: Colors.black, txtSize: 14, fontWeight: FontWeight.bold,
                                  padding: 0,
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 2, bottom: 6),
                                child: Txt(txt: model.response![index].categoryName?? '', txtColor: Colors.black, txtSize: 12, fontWeight: FontWeight.normal,
                                  padding: 0,
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      child: Container(
                                        height: 30,
                                        margin: const EdgeInsets.only(right: 0.5),
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color: Colors.amberAccent,
                                          borderRadius: BorderRadius.only(bottomLeft:  Radius.circular(4)),
                                        ),
                                        child: Icon(
                                          Icons.mode_edit_rounded,
                                          size: 18,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),

                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => EditUpdateProduct( productId: model.response![index].productId.toString(),),),
                                        );
                                        setState(() {
                                          _future = getDataFromApi();
                                        });
                                      },
                                    ),
                                  ),

                                  Expanded(
                                    child: InkWell(
                                      child: Container(
                                        height: 30,
                                        margin: const EdgeInsets.only(left: 0.5),
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          color: Colors.amberAccent,
                                          borderRadius: BorderRadius.only(bottomRight:  Radius.circular(4)),
                                        ),

                                        child: Icon(
                                          model.response![index].status! == 1 ? Icons.check_circle_outline : Icons.remove_circle_outline,
                                          size: 18,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),

                                      onTap: () async {
                                        //deleteProduct(model.response![index].productId.toString());
                                        edgeAlert(context, title: 'Message',
                                            description: model.response![index].status! == 1 ?
                                            '${model.response![index].productName!} is on the active state. Edit to change the product state.' :
                                            '${model.response![index].productName!} is currently on the inactive state. Edit to change the product state.');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditUpdateProduct( productId: model.response![index].productId.toString(),),
                            ),
                          );
                          setState(() {
                            _future = getDataFromApi();
                          });
                        },
                      );
                    }),
                  ),
                ),
              );
            }
            else {return NoDataFound(txt: 'No product found', onRefresh: (){});}
          } else {
            return const LottieLoading();
          }
        },
      ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProduct(),
              ),
            );
            setState(() {
              _future = getDataFromApi();
            });
          },
          icon: const Icon(
            Icons.add,
            color: Colors.black87,
            size: 20,
          ),
          backgroundColor: Colors.amber,
          tooltip: 'Add more product',
          elevation: 4,
          label: const Text('Add Product', style: TextStyle(color: Colors.black87, fontSize: 14),),
          isExtended: true,
          splashColor: Colors.grey,
        )
    );
  }

  void deleteProduct(String productId) async {
    try{
      showLoadingDialog(context);

      Map<String, dynamic> body = {};
      body['product_id'] = productId;
      await ApiFun.apiPostWithBody(ApiConstants.deleteProduct, body).then((jsonDecodeData) {
        StatusMessageApiResModel statusMessageApiResModel = StatusMessageApiResModel.fromJson(jsonDecodeData);
        edgeAlert(context, title: 'Message', description: statusMessageApiResModel.message!);
      });
      isApiDataAvailable = false;
      setState(() {
        _future = getDataFromApi();});
    } catch(error){
      print("Error: $error");
    }
  }

}