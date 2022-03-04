import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/RequisitionApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/requisitions_details/requisation_details.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';

import 'requisition_list_widget.dart';

class Requisition extends StatefulWidget {
  const Requisition({Key? key}) : super(key: key);

  @override
  _RequisitionsState createState() => _RequisitionsState();
}

class _RequisitionsState extends State<Requisition> {
  TextEditingController controller = TextEditingController();
  String? userId = '';
  String fromDateStr = '', toDateStr = '';
  late DateTime fromDate;
  late DateTime toDate;
  late List<String> listData = [];

  late Future<bool> _future;
  late bool isApiDataAvailable = false;
  RequisitionApiResModel model = RequisitionApiResModel();
  StatusMessageApiResModel statusMessageApiResModel = StatusMessageApiResModel();


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
      userId = await MySharedPreferences().getUserId();

      Map<String, dynamic> body = {};
      body['user_id'] = userId;

      await ApiFun.apiPostWithBody(ApiConstants.requisitions, body).then((jsonDecodeData) => {
        model = RequisitionApiResModel.fromJson(jsonDecodeData),
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
      appBar: appBarIcBack(context, 'Requisition'),
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(snapShot.hasData && snapShot.connectionState == ConnectionState.done){
            if(isApiDataAvailable){
              return SlideInUp(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12, top: 10),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: model.response!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RequisitionListWidget(
                          response: model.response!,
                          index: index,
                          onTapOnList: (intValue){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  RequisitionDetails(
                                    requisitionId: model.response![index].requisitionId.toString(),
                                    userId: userId ?? '',
                                    qty: model.response![index].items.toString(),
                                    orderId: model.response![index].orderId ??'',
                                    restaurantName: model.response![index].restaurantName ??'',
                                    dateTime: model.response![index].datetime ??'',
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
            else {return NoDataFound(txt: 'No Requisition To Show', onRefresh:(){});}
          } else {
            return const LottieLoading();
          }
        },
      ),
    );
  }
}
