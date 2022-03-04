import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/PurchaseOrderApiResModel.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/purchase_order_details/purchase_order_details.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/drop_down_statefull_dialog.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/drop_down_dialog_sort.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/filter_date_sort.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_ic_row.dart';

import 'purchase_order_list_widget.dart';


class PurchaseOrder extends StatefulWidget {
  static const String routeName = '/orders';

  const PurchaseOrder({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<PurchaseOrder> {
  TextEditingController controller = TextEditingController();
  
  late Future<bool> _future;
  late bool isApiDataAvailable = false;
  PurchaseOrderApiResModel model = PurchaseOrderApiResModel();

  @override
  void initState() {
    super.initState();

    _future = getDataFromApi('', '', '');
  }


  Future<bool> getDataFromApi(String fromDateStr, String toDateStr, String sortStr) async {
    try{
      String? userId = await MySharedPreferences().getUserId();

      Map<String, dynamic> body = {};
      body["user_id"] = userId;
      body["sort"] = sortStr == 'Ascending'? 'asc': 'desc'; //asc,desc
      body["from_date"] = fromDateStr;
      body["to_date"] = toDateStr;

      await ApiFun.apiPostWithBody(ApiConstants.purchaseOrders, body).then((jsonDecodeData) => {
        model = PurchaseOrderApiResModel.fromJson(jsonDecodeData),
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
      appBar: appBarIcBack(context, 'Purchase Order'),
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          FilterDateSort( onTap: (fromDateString, toDateString, sortString){
            if (kDebugMode) {
              print('---- 1 : $fromDateString, $toDateString, $sortString');
            }

            setState(() {
              isApiDataAvailable = false;
              _future = getDataFromApi(fromDateString, toDateString, sortString);
            });
          }),

          FutureBuilder(
            future: _future,
            builder: (context, snapShot){
              if(snapShot.hasData && snapShot.connectionState == ConnectionState.done){
                if(isApiDataAvailable){
                  return Expanded(
                    child: SlideInUp(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: model.response?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return PurchaseOrderListWidget(
                                response: model.response,
                                index: index,
                                onTapOnList: (intValue){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => PurchaseOrderDetails(
                                        orderId: model.response![index].orderId.toString(),
                                        purchaseOrderId: model.response![index].purchaseOrderId.toString(),
                                        purchaseAmount: model.response![index].purchaseAmount.toString(),
                                        supplierName: model.response![index].restaurantName.toString(),
                                        dateTime: model.response![index].datetime.toString(),
                                        totalItems: model.response![index].totalItems.toString(),
                                      ),
                                    ),
                                  );
                                },
                                onRefreshed: () {

                                },
                              );
                            }),
                      ),
                    ),
                  );
                }
                else { return NoDataFound(txt: 'No purchase order to show', onRefresh: (){});}
              } else {
                return const LottieLoading();
              }
            },
          ),
        ],
      ),
    );
  }
}
