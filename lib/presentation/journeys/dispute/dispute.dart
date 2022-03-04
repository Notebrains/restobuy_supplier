
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:lottie/lottie.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/DisputeApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';

import 'chat.dart';
import 'dispute_list_widget.dart';


class Dispute extends StatefulWidget {
  const Dispute({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Dispute> {
  late Future<bool> _future;
  late bool isApiDataAvailable = false;
  DisputeApiResModel model = DisputeApiResModel();

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

      await ApiFun.apiPostWithBody(ApiConstants.disputes, body).then((jsonDecodeData) => {
        model = DisputeApiResModel.fromJson(jsonDecodeData),
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
      appBar: appBarIcBack(context, 'Dispute'),
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(snapShot.hasData && snapShot.connectionState == ConnectionState.done){
            if(isApiDataAvailable){
              return SlideInUp(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24, top: 8),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: model.response?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DisputeListWidget(
                          response: model.response!,
                          index: index,
                          onTapOnDelete: (intValue){
                            deleteDispute(model.response![index].disputeId.toString());
                          },
                          onTapOnChatBtn: () {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  ChatScreen(
                                    disputeId: model.response![index].disputeId.toString(),
                                    supplierName: model.response![index].restaurantName?? '',
                                    ticketId: model.response![index].ticketId?? '',
                                    disputeReason: model.response![index].disputesReason?? '',
                                  ),
                              ),
                            );
                          },
                        );
                      }),
                ),
              );
            }
            else { return NoDataFound(txt: 'No Dispute To Show', onRefresh: (){});}
          } else {
            return const LottieLoading();
          }
        },
      ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.of(context).pushNamed(RouteList.raise_dispute);
            setState(() {
              _future = getDataFromApi();
            });
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            size: 20,
          ),
          backgroundColor: Colors.amber.shade600,
          tooltip: 'Pressed',
          elevation: 5,
          label: const Text('Raise Dispute', style: TextStyle(color: Colors.white, fontSize: 14),),
          isExtended: true,
          splashColor: Colors.grey,
        )
    );
  }

  void deleteDispute(String id) async {
    try{
      showLoadingDialog(context);

      Map<String, dynamic> body = {};
      body['dispute_id'] = id;
      await ApiFun.apiPostWithBody(ApiConstants.deleteDisputes, body).then((jsonDecodeData) {
        StatusMessageApiResModel statusMessageApiResModel = StatusMessageApiResModel.fromJson(jsonDecodeData);
        edgeAlert(context, title: 'Message', description: statusMessageApiResModel.message!);
      });
      isApiDataAvailable = false;
      setState(() {
        _future = getDataFromApi();
      });
    } catch(error){
      print("Error: $error");
    }
  }
}
