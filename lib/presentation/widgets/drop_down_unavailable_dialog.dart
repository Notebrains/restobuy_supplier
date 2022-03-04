import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/models/RequisitionProductApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/RequisitionVariantApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/RequsitionCategoryApiResModel.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/drop_down_with_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/themes/theme_color.dart';

import 'lottie_loading.dart';
import 'txt.dart';
import 'txt_input_field.dart';

Future showDropDownUnavailableDialog(context, Function(String categoryId, String productId, String variant, String qty) onClose) async {
  bool isApiDataAvailable = true;

  String categoryId = '';
  String productId = '';
  String variantId = '';

  TextEditingController qtyController = TextEditingController();

  DropListModel dropDownListCategory = DropListModel([]);
  OptionItem optionItemSelectedCategory = OptionItem(id: '0', title: "Select category");
  DropListModel dropDownListProduct = DropListModel([]);
  OptionItem optionItemSelectedProduct = OptionItem(id: '0', title: "Select product");
  DropListModel dropDownListVariant = DropListModel([]);
  OptionItem optionItemSelectedVariant = OptionItem(id: '0', title: "Select variant");

  getRequisitionCategory(context, (response) {
    dropDownListCategory.listOptionItems.clear();
    for(int i=0; i< response.response!.length; i++){
      dropDownListCategory.listOptionItems.add(
        OptionItem(
          id: response.response![i].categoryId.toString(),
          title: response.response![i].categoryName!,
        ),
      );
    }
    //isApiDataAvailable = true;
  });


  return await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Txt(
                      txt: 'Unavailable',
                      txtColor: AppColor.grey,
                      txtSize: 16,
                      fontWeight: FontWeight.normal,
                      padding: 3,
                    ),

                    Visibility(
                      visible: !isApiDataAvailable,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: LinearProgressIndicator(
                          color: Colors.orange,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: DropDownWithModel(
                        ic: Icons.category_outlined,
                        icColor: Colors.black54,
                        itemSelected: optionItemSelectedCategory,
                        onOptionSelected: (OptionItem optionItem) {
                          //print('----categoryId: ${optionItem.id}');
                          setState(() {
                            optionItemSelectedCategory.title = optionItem.title;
                            categoryId = optionItem.id;
                            isApiDataAvailable = false;

                            getRequisitionProduct(context, categoryId, (response) {
                              dropDownListProduct.listOptionItems.clear();
                              for(int i=0; i< response.response!.length; i++){
                                dropDownListProduct.listOptionItems.add(
                                  OptionItem(
                                    id: response.response![i].productId.toString(),
                                    title: response.response![i].productName!,
                                  ),
                                );
                              }

                              setState((){
                                isApiDataAvailable = true;
                              });
                            });
                          });
                        },
                        dropListModel: dropDownListCategory,
                      ),
                    ),


                    Container(
                      margin: const EdgeInsets.only( top: 16),
                      child: DropDownWithModel(
                        ic: Icons.shopping_cart_outlined,
                        icColor: Colors.black54,
                        itemSelected: optionItemSelectedProduct,
                        onOptionSelected: (OptionItem optionItem) {
                          //print('----supplierId: ${optionItem.id}');
                          setState(() {
                            optionItemSelectedProduct.title = optionItem.title;
                            productId = optionItem.id;
                            isApiDataAvailable = false;

                            getRequisitionVariant(context, productId, (response) async {
                              dropDownListVariant.listOptionItems.clear();
                              for(int i=0; i< response.response!.length; i++){
                                dropDownListVariant.listOptionItems.add(
                                  OptionItem(
                                    id: '', // id not required
                                    title: response.response![i].unit!,
                                  ),
                                );
                              }
                              setState((){
                                isApiDataAvailable = true;
                              });
                            });
                          });
                        },
                        dropListModel: dropDownListProduct,
                      ),
                    ),


                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: DropDownWithModel(
                        ic: Icons.format_list_numbered_rounded,
                        icColor: Colors.black54,
                        itemSelected: optionItemSelectedVariant,
                        onOptionSelected: (OptionItem optionItem) {
                          setState(() {
                            optionItemSelectedVariant.title = optionItem.title;
                            variantId = optionItem.title;
                          });
                        },
                        dropListModel: dropDownListVariant,
                      ),
                    ),


                    TxtIf(txt: 'Qty', initialTxtValue: qtyController.text, hint: 'Type here', isReadOnly: false, textInputType: TextInputType.number,
                      onSaved: (value){
                        qtyController.text = value;
                      }, leftPadding: 5,
                      rightPadding: 5,
                    ),

                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5, top: 24,),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Colors.grey, width: 0.5),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.shade300,
                                blurRadius: 6,
                              )
                            ]
                        ),

                        alignment: Alignment.center,
                        child: const Txt(
                          txt: 'Submit',
                          txtColor: AppColor.grey,
                          txtSize: 14,
                          fontWeight: FontWeight.normal,
                          padding: 3,
                        ),
                      ),

                      onTap: (){
                        if (categoryId.isEmpty) {
                          edgeAlert(context, title: 'Warning', description : 'Please select category');
                        } else if(productId.isEmpty) {
                          edgeAlert(context, title: 'Warning', description : 'Please select product');
                        } else if(variantId.isEmpty) {
                          edgeAlert(context, title: 'Warning', description : 'Please select variant');
                        }else if(qtyController.text.isEmpty) {
                          edgeAlert(context, title: 'Warning', description : 'Please enter quantity');
                        } else {
                          Navigator.pop(context);
                          onClose(categoryId, productId, variantId, qtyController.text);
                        }
                      },
                    ),

                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5, top: 24,),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Colors.grey, width: 0.5),
                            boxShadow: [
                              BoxShadow(color: Colors.grey.shade100,
                                blurRadius: 6,
                              )
                            ]
                        ),

                        alignment: Alignment.center,
                        child: const Txt(
                          txt: 'Cancel',
                          txtColor: AppColor.grey,
                          txtSize: 14,
                          fontWeight: FontWeight.normal,
                          padding: 3,
                        ),
                      ),

                      onTap: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ]
              ),
            );
          },
        ),
      );
    },
  );
}


void getRequisitionCategory(BuildContext context, Function(RequsitionCategoryApiResModel response) onResponse) async {
  try{
    //showLoadingDialog(context);

    await ApiFun.apiPostWithoutBody(ApiConstants.requisitionCategory).then((jsonDecodeData) {
      RequsitionCategoryApiResModel model = RequsitionCategoryApiResModel.fromJson(jsonDecodeData);
      //edgeAlert(context, title: 'Message', description: model.message!);
      onResponse(model);
    });

  } catch(error){
    print("Error: $error");
  }
}

void getRequisitionProduct(BuildContext context, String categoryId, Function(RequisitionProductApiResModel response) onResponse) async {
  try{
    //showLoadingDialog(context);

    Map<String, dynamic> body = {};
    body['category_id'] = categoryId;

    await ApiFun.apiPostWithBody(ApiConstants.requisitionCategoryProduct, body).then((jsonDecodeData) {
      RequisitionProductApiResModel model = RequisitionProductApiResModel.fromJson(jsonDecodeData);
      //edgeAlert(context, title: 'Message', description: model.message!);
      onResponse(model);
    });

  } catch(error){
    print("Error: $error");
  }
}

void getRequisitionVariant(BuildContext context, String productId, Function(RequisitionVariantApiResModel response) onResponse) async {
  try{
    //showLoadingDialog(context);

    Map<String, dynamic> body = {};
    body['product_id'] = productId;

    await ApiFun.apiPostWithBody(ApiConstants.requisitionProductVariant, body).then((jsonDecodeData) {
      RequisitionVariantApiResModel model = RequisitionVariantApiResModel.fromJson(jsonDecodeData);
      //edgeAlert(context, title: 'Message', description: model.message!);
      onResponse(model);
    });

  } catch(error){
    print("Error: $error");
  }
}