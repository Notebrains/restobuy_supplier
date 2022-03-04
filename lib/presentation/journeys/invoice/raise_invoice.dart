import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/PoListApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/PoPriceApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/RaiseInvoiceApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/drop_down_with_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/button.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_if_preview.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_input_field.dart';

class RaiseInvoice extends StatefulWidget{
  final bool isViewInvoice;
  final String invoiceId;
  final String date;
  final String po;
  final String amount;
  final String restaurant;

  const RaiseInvoice({Key? key, required this.isViewInvoice, required this.invoiceId, required this.date, required this.po,
    required this.amount, required this.restaurant}) : super(key: key);


  @override
  State<RaiseInvoice> createState() => _RaiseInvoiceState();
}

class _RaiseInvoiceState extends State<RaiseInvoice> {
  String restaurantId = '';
  String poId = '';
  String invoiceIdStr = '';
  String dateStr = '';
  String amountStr = '';

  DropListModel dropDownRestaurantList = DropListModel([]);
  OptionItem optionItemSelectedRestaurant = OptionItem(id: '0', title: "Select restaurant");
  DropListModel dropDownPoList = DropListModel([]);
  OptionItem optionItemSelectedPo = OptionItem(id: '0', title: "Select invoice");


  @override
  void initState() {
    super.initState();

    getRestaurantNames(context, (response) {
      dropDownRestaurantList.listOptionItems.clear();
      for(int i=0; i< response.response!.length; i++){
        dropDownRestaurantList.listOptionItems.add(
          OptionItem(
            id: response.response![i].email.toString(),
            title: response.response![i].restaurantName!,
          ),
        );
      }
    });

    if (!widget.isViewInvoice) {
      dateStr = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}    "
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";

    } else {
      dateStr = widget.date;
      amountStr = widget.amount;
      invoiceIdStr = widget.invoiceId;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, 'Raise Invoice'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Visibility(
              visible: !widget.isViewInvoice,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 18),
                child: DropDownWithModel(
                  ic: Icons.restaurant,
                  icColor: Colors.black54,
                  itemSelected: optionItemSelectedRestaurant,
                  onOptionSelected: (OptionItem optionItem) {
                    //print('----supplierId: ${optionItem.id}');
                    optionItemSelectedRestaurant.title = optionItem.title;
                    restaurantId = optionItem.id;

                    getPO(context, optionItem.id, (response) {
                      dropDownPoList.listOptionItems.clear();
                      for(int i=0; i< response.response!.length; i++){
                        dropDownPoList.listOptionItems.add(
                          OptionItem(
                            id: response.response![i].purchaseOrderId.toString(),
                            title: response.response![i].purchaseOrderId ??'',
                          ),
                        );
                      }
                    });

                    setState(() {});
                  },
                  dropListModel: dropDownRestaurantList,
                ),
              ),
            ),


            Visibility(
              visible: !widget.isViewInvoice,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 18),
                child: DropDownWithModel(
                  ic: Icons.list_alt_rounded,
                  icColor: Colors.black54,
                  itemSelected: optionItemSelectedPo,
                  onOptionSelected: (OptionItem optionItem) {
                    optionItemSelectedPo.title = optionItem.title;
                    poId = optionItem.title;
                    getPoPrice(context, poId, (response) {
                      Future.delayed(const Duration(microseconds: 300)).then((value) {
                        setState(() {
                          invoiceIdStr = response.response!.invoiceId!;
                          amountStr = response.response!.purchaseAmount!;
                        });
                      });
                    });
                  },
                  dropListModel: dropDownPoList,
                ),
              ),
            ),


            Visibility(
              visible: widget.isViewInvoice,
              child: TxtIf(
                txt: 'Restaurant',
                initialTxtValue: widget.restaurant,
                hint: '',
                icon: null,
                isReadOnly: widget.isViewInvoice,
                textInputType: TextInputType.text,
                onSaved: (value) {  },
                leftPadding: 25,
                rightPadding: 25,
              ),
            ),

            Visibility(
              visible: widget.isViewInvoice,
              child: TxtIf(
                txt: 'Purchase order',
                initialTxtValue: widget.po,
                hint: '',
                icon: null,
                isReadOnly: widget.isViewInvoice,
                textInputType: TextInputType.text,
                onSaved: (value) {  },
                leftPadding: 25,
                rightPadding: 25,
                //validator: validator,
                //onSaved: onSaved,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: TxtIfPreview(txt: 'Invoice id', ifTxt: invoiceIdStr, icon: null, onTap: (){}),
            ),

            TxtIf(
              txt: 'Date and time',
              initialTxtValue: dateStr,
              hint: '',
              icon: null,
              isReadOnly: true,
              textInputType: TextInputType.text,
              onSaved: (value) { },
              leftPadding: 25,
              rightPadding: 25,
              //validator: validator,
              //onSaved: onSaved,
            ),

            Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: TxtIfPreview(txt: 'Amount (\$)', ifTxt: amountStr, icon: null, onTap: (){}),
            ),

            Visibility(
              visible: !widget.isViewInvoice,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 24, 20.0, 8),
                child: Button(text: 'Submit', onPressed: () {
                  //print('----invoiceIdStr : ${invoiceIdStr}');
                  if(restaurantId.isEmpty) {
                    edgeAlert(context, title: 'Warning', description : 'Please select restaurant name');
                  } else if(poId.isEmpty) {
                    edgeAlert(context, title: 'Warning', description : 'Please select purchase order');
                  } else if(invoiceIdStr.isEmpty) {
                    edgeAlert(context, title: 'Warning', description : "invoice id can't be empty");
                  } else if(dateStr.isEmpty) {
                    edgeAlert(context, title: 'Warning', description : "date and time can't be empty");
                  } else if(amountStr.isEmpty) {
                    edgeAlert(context, title: 'Warning', description : "Amount can't be empty");
                  } else {
                    submitInvoice(restaurantId, poId, invoiceIdStr, dateStr, amountStr, (){
                      WidgetsBinding.instance?.addPostFrameCallback((_) {
                        Navigator.of(context).pop();
                      });
                    });
                  }
                },),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getRestaurantNames(BuildContext context, Function(RaiseInvoiceApiResModel response) onResponse) async {
    try{
      await ApiFun.apiPostWithoutBody(ApiConstants.getInvoiceRestaurant).then((jsonDecodeData) {
        RaiseInvoiceApiResModel model = RaiseInvoiceApiResModel.fromJson(jsonDecodeData);
        onResponse(model);
      });

    } catch(error){
      print("Error: $error");
    }
  }

  void getPO(BuildContext context, String email, Function(PoListApiResModel response) onResponse) async {
    try{
      String? userId = await MySharedPreferences().getUserId();

      Map<String, dynamic> body = {};
      body["user_id"] = userId;
      body["email"] = email;

      await ApiFun.apiPostWithBody(ApiConstants.getPO, body).then((jsonDecodeData) {
        PoListApiResModel model = PoListApiResModel.fromJson(jsonDecodeData);
        onResponse(model);

        if (model.status == 0) {
          edgeAlert(context, title: 'Message' , description: 'No purchase order found');
        }
      });

    } catch(error){
      print("Error: $error");
    }
  }

  void getPoPrice(BuildContext context, String purchaseOrderId, Function(PoPriceApiResModel response) onResponse) async {
    try{
      Map<String, dynamic> body = {};
      body["purchase_order_id"] = purchaseOrderId;

      await ApiFun.apiPostWithBody(ApiConstants.invoicePoPrice, body).then((jsonDecodeData) {
        PoPriceApiResModel model = PoPriceApiResModel.fromJson(jsonDecodeData);
        onResponse(model);
      });

    } catch(error){
      print("Error: $error");
    }
  }

  void submitInvoice(String restaurantId, String purchaseOrderId, String invoiceId, String invoiceDate, String invoiceAmount, Function() onClose) async {
    try{
      String? userId = await MySharedPreferences().getUserId();

      Map<String, dynamic> body = {};
      body['user_id'] = userId;
      body['purchase_order_id'] = purchaseOrderId;
      body['invoice_date'] = invoiceDate;
      body['invoice_amount'] = invoiceAmount;

      await ApiFun.apiPostWithBody(ApiConstants.addInvoice, body).then((jsonDecodeData) {
        StatusMessageApiResModel statusMessageApiResModel = StatusMessageApiResModel.fromJson(jsonDecodeData);
        edgeAlert(context, title: 'Message', description: statusMessageApiResModel.message!);
        if (statusMessageApiResModel.status == 1) {
          onClose();
        }
      });

    } catch(error){
      print("Error: $error");
    }
  }

}