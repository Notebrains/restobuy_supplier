import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/InvIdApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/RaiseInvoiceApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/TransactionPriceIdApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/drop_down_input.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/drop_down_with_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/button.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_if_preview.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_input_field.dart';

class ViewTransaction extends StatefulWidget {
  final bool isViewTransaction;
  final String transactionId;
  final String invoiceId;
  final String amount;
  final String date;
  final String paymentMode;
  final String transactionStatus;
  final String transactionDetails;
  final String restaurantName;

  const ViewTransaction({Key? key, required this.isViewTransaction, required this.transactionId,
    required this.invoiceId, required this.amount, required this.date, required this.paymentMode,
    required this.transactionStatus, required this.transactionDetails, required this.restaurantName}) : super(key: key);


  @override
  _ViewTransactionState createState() => _ViewTransactionState();
}

class _ViewTransactionState extends State<ViewTransaction> {
  String restaurantId = '';
  String invId = '';
  String transactionStatus = 'Success';
  String dateStr = '';
  DropListModel dropDownRestaurantList = DropListModel([]);
  OptionItem optionItemSelectedRestaurant = OptionItem(id: '0', title: "Select restaurant");
  DropListModel dropDownInvoiceList = DropListModel([]);
  OptionItem optionItemSelectedInvoice = OptionItem(id: '0', title: "Select invoice");

  TextEditingController restaurantNameController = TextEditingController();
  TextEditingController paymentModeController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController transactionIdController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    transactionStatus = widget.transactionStatus;
    transactionIdController.text = widget.transactionId;
    amountController.text = widget.amount;
    restaurantNameController.text = widget.restaurantName;
    paymentModeController.text = widget.paymentMode;
    detailsController.text = widget.transactionDetails;

    if (!widget.isViewTransaction) {
      dateStr = "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}    "
          "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
    } else {
      dateStr = widget.date;
      transactionStatus = widget.transactionStatus;
    }

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
  }

  @override
  void dispose() {
    super.dispose();

    restaurantNameController.dispose();
    paymentModeController.dispose();
    detailsController.dispose();
    transactionIdController.dispose();
    amountController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack( context, widget.isViewTransaction ? 'View Transaction' : 'Add Transaction'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: !widget.isViewTransaction,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 24),
                child: DropDownWithModel(
                  ic: Icons.restaurant,
                  icColor: Colors.black54,
                  itemSelected: optionItemSelectedRestaurant,
                  onOptionSelected: (OptionItem optionItem) {
                    //print('----supplierId: ${optionItem.id}');
                    setState(() {
                      optionItemSelectedRestaurant.title = optionItem.title;
                      restaurantId = optionItem.id;

                      getInvIdList(context, optionItem.id, (response) {
                        dropDownInvoiceList.listOptionItems.clear();
                        for(int i=0; i< response.response!.length; i++){
                          dropDownInvoiceList.listOptionItems.add(
                            OptionItem(
                              id: response.response![i].invoiceId.toString(),
                              title: response.response![i].invoiceId ??'',
                            ),
                          );
                        }
                      });
                    });
                  },
                  dropListModel: dropDownRestaurantList,
                ),
              ),
            ),

            Visibility(
              visible: !widget.isViewTransaction,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 24),
                child: DropDownWithModel(
                  ic: Icons.list_alt_sharp,
                  icColor: Colors.black54,
                  itemSelected: optionItemSelectedInvoice,
                  onOptionSelected: (OptionItem optionItem){
                    optionItemSelectedInvoice.title = optionItem.title;
                    invId = optionItem.title;
                    getTransactionPriceId(context, invId, (model){
                      Future.delayed(const Duration(microseconds: 300)).then((value) {
                        setState(() {
                          transactionIdController.text = model.response!.transactionId!;
                          amountController.text = model.response!.transactionAmount!;
                        });
                      });
                    });
                  },
                  dropListModel: dropDownInvoiceList,
                ),
              ),
            ),

            Visibility(
              visible: widget.isViewTransaction,
              child: TxtIf(
                txt: 'Restaurant name', //change
                initialTxtValue: restaurantNameController.text,
                hint: 'Type here',
                isReadOnly: true,
                textInputType: TextInputType.text,
                onSaved: (value){},
                leftPadding: 25,
                rightPadding: 25,
              ),
            ),

            Visibility(
              visible: widget.isViewTransaction,
              child: TxtIf(
                txt: 'Invoice id',
                initialTxtValue: widget.invoiceId,
                hint: '',
                isReadOnly: true,
                textInputType: TextInputType.text,
                onSaved: (value){},
                leftPadding: 25,
                rightPadding: 25,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: TxtIfPreview(txt: 'Transaction id', ifTxt: transactionIdController.text, icon: null, onTap: (){}),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: TxtIfPreview(txt: 'Transaction amount', ifTxt: amountController.text, icon: null, onTap: (){}),
            ),

            TxtIf(
              txt: 'Date & time',
              initialTxtValue: dateStr,
              hint: '',
              isReadOnly: true,
              textInputType: TextInputType.text,
              onSaved: (value){},
              leftPadding: 25,
              rightPadding: 25,
            ),

            TxtIf(
              txt: 'Mode of payment',
              initialTxtValue: paymentModeController.text,
              hint: 'Type here',
              isReadOnly: false,
              textInputType: TextInputType.text,
              onSaved: (value){
                paymentModeController.text = value;
              },
              leftPadding: 25,
              rightPadding: 25,
            ),


            TxtIf(
              txt: 'Transaction details',
              initialTxtValue: detailsController.text,
              hint: 'Type here',
              isReadOnly: widget.isViewTransaction,
              textInputType: TextInputType.text,
              onSaved: (value){
                detailsController.text = value;
              },
              leftPadding: 25,
              rightPadding: 25,
            ),

            Visibility(
              visible: widget.isViewTransaction,
              child: TxtIf(
                txt: 'Transaction status',
                initialTxtValue: transactionStatus,
                hint: 'Type here',
                isReadOnly: true,
                textInputType: TextInputType.text,
                onSaved: (value){},
                leftPadding: 25,
                rightPadding: 25,
              ),
            ),

            Visibility(
              visible: !widget.isViewTransaction,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 24),
                child: AppDropdownInput(
                  hintText: "Transaction status",
                  options: const ["Success", "Failed"],
                  value: transactionStatus,
                  onChanged: (String? value) {
                    setState(() {
                      transactionStatus = value!;
                    });
                  },
                  getLabel: (String value) => value,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Button(text: 'Submit', onPressed: () {
                if (transactionIdController.text.isEmpty) {
                  edgeAlert(context, title: 'Warning', description : 'Please select transaction id');
                } else if (invId.isEmpty) {
                  edgeAlert(context, title: 'Warning', description : 'Please select invoice id');
                } else if (paymentModeController.text.isEmpty) {
                  edgeAlert(context, title: 'Warning', description : 'Please enter payment mode');
                } else if (detailsController.text.isEmpty) {
                  edgeAlert(context, title: 'Warning', description : 'Please enter transaction details');
                } else if (transactionStatus.isEmpty) {
                  edgeAlert(context, title: 'Warning', description : 'Please select transaction status');
                } else {
                   doSubmit((){
                     WidgetsBinding.instance?.addPostFrameCallback((_) {
                       Navigator.of(context).pop();
                     });
                   });
                }
              }),
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

  void getInvIdList(BuildContext context, String email, Function(InvIdApiResModel response) onResponse) async {
    try{
      String? userId = await MySharedPreferences().getUserId();

      Map<String, dynamic> body = {};
      body["user_id"] = userId;
      body["email"] = email;

      await ApiFun.apiPostWithBody(ApiConstants.getInvoice, body).then((jsonDecodeData) {
        InvIdApiResModel model = InvIdApiResModel.fromJson(jsonDecodeData);
        onResponse(model);

        if (model.status == 0) {
          edgeAlert(context, title: 'Message' , description: 'No purchase order found');
        }
      });

    } catch(error){
      print("Error: $error");
    }
  }

  void getTransactionPriceId(BuildContext context, String invoiceId, Function(TransactionPriceIdApiResModel response) onResponse) async {
    try{
      Map<String, dynamic> body = {};
      body["invoice_id"] = invoiceId;

      await ApiFun.apiPostWithBody(ApiConstants.viewTransactionPriceTransactionId, body).then((jsonDecodeData) {
        TransactionPriceIdApiResModel model = TransactionPriceIdApiResModel.fromJson(jsonDecodeData);
        onResponse(model);
        if (model.status == 0) {
          edgeAlert(context, title: 'Message' , description: 'No purchase order found');
        }
      });

    } catch(error){
      print("Error: $error");
    }
  }

  void doSubmit( Function() onClose) async {
    if (kDebugMode) {
      //print('---- Name, Image, DOB, gender: ${nameController.text}, $gender, $dob, $base64Image');
    }
    showLoadingDialog(context);

    String? userId = await MySharedPreferences().getUserId();
    Map<String, dynamic> data = {};
    data["user_id"] = userId;
    data["invoice_id"] = invId;
    data["transaction_date"] = dateStr;
    data["transaction_amount"] = amountController.text;
    data["transaction_details"] = detailsController.text;
    data["payment_mode"] = paymentModeController.text;
    data["transaction_status"] = transactionStatus;

    await ApiFun.apiPostWithBody(ApiConstants.addTransaction, data).then((jsonDecodeData){
      StatusMessageApiResModel model = StatusMessageApiResModel.fromJson(jsonDecodeData);
      edgeAlert(context, title: 'Message', description: model.message!);
      if (model.status == 1) {
        onClose();
      }
    });
  }

}