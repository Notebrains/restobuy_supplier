import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/RaiseDisputeApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/drop_down_with_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/button.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/review_txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_input_field.dart';

class RaiseDispute extends StatefulWidget{
  const RaiseDispute({Key? key}) : super(key: key);

  @override
  State<RaiseDispute> createState() => _RaiseDisputeState();
}

class _RaiseDisputeState extends State<RaiseDispute> {
  late bool isApiDataAvailable = false;

  TextEditingController messageController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  String restaurantId = '';

  late Future<bool> _future;
  RaiseDisputeApiResModel model = RaiseDisputeApiResModel();


  DropListModel dropDownList = DropListModel([]);
  OptionItem optionItemSelected = OptionItem(id: '0', title: "Select restaurant");


  @override
  void initState() {
    super.initState();
    _future = getDataFromApi();
  }

  @override
  void dispose() {
    super.dispose();

    messageController.dispose();
    reasonController.dispose();
  }


  Future<bool> getDataFromApi() async {
    try{
      await ApiFun.apiPostWithoutBody(ApiConstants.getDisputeIdAndRestaurant).then((jsonDecodeData) => {
        model = RaiseDisputeApiResModel.fromJson(jsonDecodeData),
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
      backgroundColor: Colors.white,
      appBar: appBarIcBack(context, 'Raise Dispute'),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(snapShot.hasData  && snapShot.connectionState == ConnectionState.done && isApiDataAvailable){
            if(model.response!.restaurant!.isNotEmpty){
              dropDownList.listOptionItems.clear();
              for(int i=0; i< model.response!.restaurant!.length; i++){
                dropDownList.listOptionItems.add(
                  OptionItem(
                    id: model.response!.restaurant![i].restaurantId!.toString(),
                    title: model.response!.restaurant![i].restaurantName!,
                  ),
                );
              }

              return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TxtIf(
                        txt: 'Ticket id',
                        initialTxtValue: model.response!.ticketId?? '',
                        hint: '',
                        icon: Icons.assistant_rounded,
                        isReadOnly: false,
                        textInputType: TextInputType.text,
                        //validator: validator,
                        //onSaved: onSaved,
                        onSaved: (String value) {  },
                        leftPadding: 25,
                        rightPadding: 25,
                      ),

                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 24),
                        child: DropDownWithModel(
                          ic: Icons.directions_car,
                          icColor: Colors.black54,
                          itemSelected: optionItemSelected,
                          onOptionSelected: (OptionItem optionItem) {
                            //print('----restaurantId: ${optionItem.id}');
                            setState(() {
                              optionItemSelected.title = optionItem.title;
                              restaurantId = optionItem.id;
                            });
                          },
                          dropListModel: dropDownList,
                        ),
                      ),

                      ReviewTxtIf(txt: 'Reason of dispute', initialTxtValue: reasonController.text, hint: 'Type here...', onSaved: (value){
                        reasonController.text = value;
                      }, maxLine: 2,),

                      ReviewTxtIf(txt: 'Detailed reason', initialTxtValue: messageController.text, hint: 'Type here...', onSaved: (value){
                        messageController.text = value;
                      }, maxLine: 8,),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 24, 20.0, 8),
                        child: Button(text: 'Submit', onPressed: () {
                          if(restaurantId.isEmpty) {
                            edgeAlert(context, title: 'Warning', description : 'Please select restaurant');
                          } else if(reasonController.text.isEmpty) {
                            edgeAlert(context, title: 'Warning', description : 'Please enter reason of dispute');
                          } else if(messageController.text.isEmpty) {
                            edgeAlert(context, title: 'Warning', description : 'Please enter reason in detail');
                          } else {
                            doSubmit(model.response!.ticketId!, (){
                              WidgetsBinding.instance?.addPostFrameCallback((_) {
                                Navigator.of(context).pop();
                              });
                            });
                          }
                        },),
                      ),
                    ],
                  ),
                );
            }
            else {return NoDataFound(txt: "Something went wrong!\nPlease try again", onRefresh: (){});}
          } else { return const LottieLoading();}
        },
      )
    );
  }

  void doSubmit(String ticketId, Function() onClose) async {
    try{
      setState(() {
        isApiDataAvailable = false;
      });

      String? userId = await MySharedPreferences().getUserId();
      Map<String, dynamic> body = {};
      body['user_id'] = userId;
      body['restaurant_id'] = restaurantId;
      body['ticket_id'] = ticketId;
      body['disputes_reason'] = reasonController.text;
      body['details_reason'] = messageController.text;
      body['message'] = '';

      if (kDebugMode) {
        print('----ticket_id, supplier_id, disputes_reason, details_reason: $ticketId, $restaurantId, ${reasonController.text}, ${messageController.text}, ');
      }

      await ApiFun.apiPostWithBody(ApiConstants.addDisputes, body).then((jsonDecodeData) {
        StatusMessageApiResModel statusMessageApiResModel = StatusMessageApiResModel.fromJson(jsonDecodeData);
        edgeAlert(context, title: 'Message', description: statusMessageApiResModel.message!);
        onClose();
      });

    } catch(error){
      print("Error: $error");
    }
  }
}