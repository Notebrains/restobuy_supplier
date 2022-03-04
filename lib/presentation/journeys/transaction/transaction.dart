
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/TransactionApiResModel.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/drop_down_with_model.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';

import 'view_transaction.dart';
import 'transaction_list_widget.dart';


class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Transaction> {
  late Future<bool> _future;
  late bool isApiDataAvailable = false;
  TransactionApiResModel model = TransactionApiResModel();


  @override
  void initState() {
    super.initState();

    _future = getDataFromApi();
  }


  Future<bool> getDataFromApi() async {
    try{
      String? userId = await MySharedPreferences().getUserId();
      Map<String, dynamic> body = {};
      body["user_id"] = userId;

      await ApiFun.apiPostWithBody(ApiConstants.transaction, body).then((jsonDecodeData) => {
        model = TransactionApiResModel.fromJson(jsonDecodeData),
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
      appBar: appBarIcBack(context, 'Transaction'),
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(snapShot.hasData && snapShot.connectionState == ConnectionState.done){
            if(isApiDataAvailable){
              return SlideInUp(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12, top: 8),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: model.response?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TransactionListWidget(
                          response: model.response!,
                          index: index,
                          onTapOnList: (intValue){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewTransaction(
                                  isViewTransaction: true,
                                  transactionId:  model.response![index].transactionId??'',
                                  invoiceId: model.response![index].invoiceId??'',
                                  amount: model.response![index].transactionAmount??'',
                                  date: model.response![index].datetime??'',
                                  paymentMode: model.response![index].paymentMode??'',
                                  transactionStatus: model.response![index].transactionStatus??'',
                                  transactionDetails: '',
                                  restaurantName: 'Restaurant Name',
                              ),
                              ),
                            );
                          },
                          onRefreshed: () {

                          },
                        );
                      }),
                ),
              );
            }
            else { return NoDataFound(txt: 'No Transaction To Show', onRefresh: (){});}
          } else {
            return const LottieLoading();
          }
        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ViewTransaction(
                isViewTransaction: false, transactionId: '', invoiceId: '', amount: '',
                date: '', paymentMode: '', transactionStatus: 'Success', transactionDetails: '', restaurantName: ''
            ),
            ),
          );
          setState(() {
            _future = getDataFromApi();
          });
        },
        icon: const Icon(
          Icons.account_balance_wallet_sharp,
          color: Colors.white,
          size: 20,
        ),
        backgroundColor: Colors.amber.shade700,
        tooltip: 'Add transaction',
        elevation: 5,
        label: const Text('Add Transaction', style: TextStyle(color: Colors.white, fontSize: 14),),
        isExtended: true,
        splashColor: Colors.grey,
      ),
    );
  }
}
