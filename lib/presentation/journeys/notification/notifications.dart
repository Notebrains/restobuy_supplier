import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/NotificationApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';

import 'appbar_notification.dart';

// Page details: List of notification showing in this screen that has sent to user device.

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late Future<bool> _future;
  bool isApiDataAvailable = false;
  NotificationApiResModel model = NotificationApiResModel();
  

  @override
  void initState() {
    super.initState();
    _future = getDataFromApi();
  }

  Future<bool> getDataFromApi() async {
    try{
      String? userId = await MySharedPreferences().getUserId();
      Map<String, dynamic> body = {};
      body['user_id'] = userId;

      await ApiFun.apiPostWithBody(ApiConstants.notifications, body).then((jsonDecodeData) => {
        model = NotificationApiResModel.fromJson(jsonDecodeData),
      });

      if(model.status == 1) {
        isApiDataAvailable = true;
      }
    } catch(error){
      if (kDebugMode) {
        print("Error: $error");
      }
    }
    return isApiDataAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarNotification(context, (){
        clearAllNotification();
      }),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(snapShot.hasData  && snapShot.connectionState == ConnectionState.done){
            if(isApiDataAvailable){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: List.generate(model.response!.length, (index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(model.response![index].title!,
                            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black87),),

                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 8),
                            child: Text(model.response![index].body!, style: const TextStyle(color: Colors.black54),),
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(model.response![index].datetime!,
                              style: const TextStyle( fontSize: 12, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    );
                  },),
                ),
              );
            }
            else { return NoDataFound(txt: 'Notification not found', onRefresh: (){});}
          } else {return const LottieLoading();}
        },
      ),
    );
  }


  void clearAllNotification() async {
    try{
      showLoadingDialog(context);
      String? userId = await MySharedPreferences().getUserId();
      Map<String, dynamic> body = {};
      body['user_id'] = userId;

      await ApiFun.apiPostWithBody(ApiConstants.clearNotifications, body).then((jsonDecodeData) {
        StatusMessageApiResModel statusMessageApiResModel = StatusMessageApiResModel.fromJson(jsonDecodeData);
        edgeAlert(context, title: 'Message', description: statusMessageApiResModel.message!);
      });
      isApiDataAvailable = false;
      setState(() {
        _future = getDataFromApi();});
    } catch(error){
      if (kDebugMode) {
        print("Error: $error");
      }
    }
  }
}