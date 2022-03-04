import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:restobuy_supplier_flutter/common/constants/strings.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/CategoryApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/MultiImgModel.dart';
import 'package:restobuy_supplier_flutter/data/models/ProductDetailsApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/VariantModel.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/drop_down_input.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/drop_down_with_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/multi_img_picker/pic_muti_img.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/button.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_top_radius.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/product_add_if.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/review_txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_input_field.dart';

class EditUpdateProduct extends StatefulWidget{
  final String productId;

  const EditUpdateProduct({Key? key, required this.productId}) : super(key: key);

  @override
  State<EditUpdateProduct> createState() => _EditUpdateProductState();
}

class _EditUpdateProductState extends State<EditUpdateProduct> {
  final _formKey = GlobalKey<FormState>();
  late bool isApiDataAvailable = false;

  TextEditingController productNameController = TextEditingController();
  TextEditingController specialNoteController = TextEditingController();
  TextEditingController descController = TextEditingController();

  String categoryId = '';
  String productStatus = 'Active';
  late File? xFile = File('');
  String featureImageBase64 = '';
  late Future<bool> _future;
  ProductDetailsApiResModel model = ProductDetailsApiResModel();

  DropListModel dropDownList = DropListModel([]);
  OptionItem optionItemSelected = OptionItem(id: '0', title: "* Select category");

  List<MultiImgModel> base64ImageList = [];
  List<dynamic> multipleImageList = [];
  List<VariantModel> variantList = [];


  Future<bool> getDataFromApi() async {
    try{
      Map<String, dynamic> body = {};
      body['product_id'] = widget.productId;
      await ApiFun.apiPostWithBody(ApiConstants.productDetails, body).then((jsonDecodeData){
        model = ProductDetailsApiResModel.fromJson(jsonDecodeData);
      });

      if(model.status == 1) {

        productNameController.text = model.response!.productName ?? '';
        specialNoteController.text = parseHtmlString(model.response!.specialNotes ?? '');
        descController.text = parseHtmlString(model.response!.description ?? '');

        categoryId = model.response!.categoryId.toString();

        dropDownList = DropListModel([]);
        optionItemSelected = OptionItem(id: model.response!.categoryId.toString(), title: model.response!.categoryName!);

        for(int i = 0; i<model.response!.category!.length; i++){
          dropDownList.listOptionItems.add(
            OptionItem(
              id: model.response!.category![i].categoryId!.toString(),
              title: model.response!.category![i].categoryName!,
            ),
          );
        }

        variantList = [];
        for(int i = 0; i<model.response!.variant!.length; i++){
          variantList.add(VariantModel(
            model.response!.variant![i].unit!,
            model.response!.variant![i].qty!,
            model.response!.variant![i].price!,),
          );
        }

        multipleImageList = [];
        for(int i = 0; i<model.response!.multipleImage!.length; i++){
          multipleImageList.add(model.response!.multipleImage![i].image);
        }

        isApiDataAvailable = true;
      }
    } catch(error){
      print("Error: $error");
    }
    return isApiDataAvailable;
  }

  @override
  void initState() {
    super.initState();
    _future = getDataFromApi();
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    specialNoteController.dispose();
    descController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarIcBack(context, 'Edit Product'),
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder(
          future: _future,
          builder: (context, snapShot){
            if(snapShot.hasData && snapShot.connectionState == ConnectionState.done && isApiDataAvailable){
              if(isApiDataAvailable){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                      child: DropDownWithModel(
                        ic: Icons.category,
                        icColor: Colors.black54,
                        itemSelected: optionItemSelected,
                        onOptionSelected: (OptionItem optionItem) {
                          //print('----categoryId: ${optionItem.id}');
                          setState(() {
                            optionItemSelected.title = optionItem.title;
                            categoryId = optionItem.id;
                          });
                        },
                        dropListModel: dropDownList,
                      ),
                    ),

                    TxtIf(
                      txt: '* Product name',
                      initialTxtValue: productNameController.text,
                      hint: productNameController.text.isEmpty? 'Enter name here': productNameController.text,
                      icon: Icons.shopping_basket_rounded,
                      isReadOnly: false,
                      textInputType: TextInputType.text,
                      onSaved: (String value) {
                        productNameController.text = value;
                      },
                      leftPadding: 25,
                      rightPadding: 25,
                    ),

                    SizedBox(
                      height: variantList.length * 180,
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(variantList.length, (int i) => getDataUi( i, variantList)),
                        ),
                      ),
                    ),

                    ReviewTxtIf(txt: 'Special note', initialTxtValue: specialNoteController.text, hint: 'Type here...', onSaved: (value){
                      specialNoteController.text = value;
                    }, maxLine: 4,),



                    ReviewTxtIf(txt: '* Description', initialTxtValue: descController.text, hint: 'Type here...', maxLine: 7,
                      onSaved: (value){
                        descController.text = value;
                    }, ),

                    const Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 16, 20.0, 0),
                      child: Txt(
                        txt: '* Upload feature image',
                        txtColor: Colors.black54,
                        txtSize: 14,
                        fontWeight: FontWeight.bold,
                        padding: 3,
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        getImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 0),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 5),
                              child: setImage(xFile!.path, model.response!.image!),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 12, right: 8),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 12, 20.0, 0),
                      child: TextButton(
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(
                            BorderSide.lerp(
                                BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.grey.shade300,
                                  width: 1.0,
                                ),
                                BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.grey.shade300,
                                  width: 1.0,
                                ),
                                1.0),
                          ),
                        ),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              'Upload multiple image + ',
                              style: TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PicMultipleImage(getImgList: (List<MultiImgModel> imgList, List<Asset> imgAssetList) {
                                setState(() {
                                  base64ImageList.addAll(imgList);
                                  multipleImageList.addAll(imgAssetList);
                                  print('----base64ImageList.length: ${base64ImageList.length}');

                                  /*for(int i = 0; i<base64ImageList.length; i++){
                                    print('----base64ImageList: ${base64ImageList[i].image}');
                                  }*/
                                });
                            },),),
                          );
                        },
                      ),
                    ),

                    Visibility(
                      visible: multipleImageList.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.count(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 5,
                          childAspectRatio: 1,
                          // crossAxisSpacing: 1.0,
                          mainAxisSpacing: 4.0,
                          children: List.generate(multipleImageList.length, (index) {
                            return InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    getImgViewer(multipleImageList[index]),

                                    const Icon(
                                      Icons.cancel,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  if (multipleImageList[index].toString().contains('http')) {
                                    deleteProductImg(model.response!.multipleImage![index].imgId.toString());
                                    multipleImageList.removeAt(index);
                                  } else {
                                    base64ImageList.removeAt(index);
                                    multipleImageList.removeAt(index);
                                  }
                                });
                              },
                            );
                          }),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 36, 20.0,0),
                      child: AppDropdownInput(
                        hintText: "* Select product status",
                        options: const ['Active', "Inactive"],
                        value: productStatus,
                        onChanged: (String? value) {
                          setState(() {
                            productStatus = value!;
                            // state.didChange(newValue);
                          });
                        },
                        getLabel: (String value) => value,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 8),
                      child: Button(text: 'Update', onPressed: () {
                        if(categoryId.isEmpty) {
                          edgeAlert(context, title: 'Warning', description: 'Please select product category');
                        } else if(productNameController.text.isEmpty) {
                          edgeAlert(context, title: 'Warning', description: 'Please enter product name');
                        } else if(descController.text.isEmpty) {
                          edgeAlert(context, title: 'Warning', description: 'Please enter product description');
                        } else if(productStatus.isEmpty) {
                          edgeAlert(context, title: 'Warning', description: 'Please select product status');
                        } else if(!_formKey.currentState!.validate()) {
                          edgeAlert(context, title: 'Warning', description: 'Please enter all fields');
                        } else if (_formKey.currentState!.validate()) {
                          updateProduct(categoryId, (){
                            WidgetsBinding.instance?.addPostFrameCallback((_) {
                              Navigator.of(context).pop();
                            });
                          });
                        }
                      },),
                    ),

                  ],
                );
              }
              else {return NoDataFound(txt: 'No product found', onRefresh: (){});}
            } else {
              return const LottieLoading();
            }
          },
        ),

      ),
    );
  }


  Future getImage() async {
    try {
      final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        xFile = File(imageFile!.path);
        //print('Image Path $xFile');
      });
    } catch (e) {
      //print(e);
    }
  }

  setImage(String path, String imgUrl) {
    try {
      //print('----path: $path');
      if (path.isEmpty) {
        return cachedNetImgWithRadius(
            imgUrl,
            double.infinity,
            150, 6, BoxFit.cover
        );
      } else {
        final bytes = File(path).readAsBytesSync();
        featureImageBase64 = base64Encode(bytes);
        //print('-----featureImageBase64:  $base64Image');

        return  SizedBox(
          width: double.infinity,
          height: 150,
          child: Image.file(
            File(xFile!.path),
            fit: BoxFit.fill,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void updateProduct(String ticketId, Function() onClose) async {
    try{
      setState(() {
        isApiDataAvailable = false;
      });

      String? userId = await MySharedPreferences().getUserId();

      Map<String, dynamic> body = {};
      body['user_id'] = userId;
      body['product_id'] = widget.productId;
      body['category_id'] = categoryId;
      body['product_name'] = productNameController.text;
      body['image'] = featureImageBase64;
      body['special_notes'] = specialNoteController.text;
      body['description'] = descController.text;
      body['status'] = productStatus == "Active" ? "1": "0";
      body['variant'] = convertVariantModelArrayToJson(variantList);
      body['multiple_image'] = convertMultiImgModelArrayToJson(base64ImageList);

      /*if (kDebugMode) {
        print('----ticket_id, supplier_id, disputes_reason, details_reason: $ticketId, $categoryId, ${descController.text}, ${specialNoteController.text}, ');
      }*/

      await ApiFun.apiPostWithBody(ApiConstants.updateProduct, body).then((jsonDecodeData) {
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

  Widget getDataUi(int index, List<VariantModel> variantList) {

    return Container(
      margin: const EdgeInsets.fromLTRB(20.0, 16, 20.0, 0),
      padding: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: ProductAddIf(
                  txt: '* Unit',
                  initialTxtValue: variantList[index].unit,
                  hint: '',
                  isReadOnly: false,
                  textInputType: TextInputType.text,
                  onSaved: (String unit) {
                    variantList[index].unit = unit;
                  },
                  leftPadding: 25,
                  rightPadding: 8,
                ),
              ),

              Flexible(
                child: ProductAddIf(
                  txt: '* Cost',
                  initialTxtValue: variantList[index].price,
                  hint: '',
                  isReadOnly: false,
                  textInputType: TextInputType.number,
                  onSaved: (String price) {
                    variantList[index].price = price;
                  },
                  leftPadding: 12,
                  rightPadding: 12,
                ),
              ),

              Flexible(
                child: ProductAddIf(
                  txt: '* Stock Qty',
                  initialTxtValue: variantList[index].qty,
                  hint: '',
                  isReadOnly: false,
                  textInputType: TextInputType.number,
                  onSaved: (String qty) {
                    variantList[index].qty = qty;
                  },
                  leftPadding: 8,
                  rightPadding: 25,
                ),
              )
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 24, top: 6),
                  child: TextButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        BorderSide.lerp(
                            BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                            BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                            1.0),
                      ),
                    ),
                    child: const Text(
                      'Add +',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    onPressed: (){
                      setState(() {
                        variantList.add(VariantModel('', '', ''));
                      });
                    },
                  ),

                ),
              ),

              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 3),
                  child: TextButton(style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide.lerp(
                          BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                          BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                          1.0),
                    ),
                  ),
                    child: const Text(
                      'Delete -',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    onPressed: (){
                      if (variantList.length > 1) {
                        setState(() {
                          variantList.removeAt(index);
                        });
                      } else {
                        edgeAlert(context, title: 'Warning', description: 'You can not delete this variant. There should be one variant');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void deleteProductImg(String imgId) async {
    try{
      //showLoadingDialog(context);

      Map<String, dynamic> body = {};
      body['img_id'] = imgId;
      await ApiFun.apiPostWithBody(ApiConstants.deleteIamge, body).then((jsonDecodeData) {
        StatusMessageApiResModel statusMessageApiResModel = StatusMessageApiResModel.fromJson(jsonDecodeData);
        edgeAlert(context, title: 'Message', description: statusMessageApiResModel.message!);
      });

      /*setState(() {
        isApiDataAvailable = false;
        _future = getDataFromApi();
      });*/
    } catch(error){
      print("Error: $error");
    }
  }

  Widget getImgViewer(dynamic imagePath) {
    Widget view = const SizedBox();
    try {
      if (imagePath.toString().contains('http')) {
        view = cachedNetImage(imagePath);
      } else {
        view = AssetThumb(
              asset: imagePath,
              width: 80,
              height: 80,
              spinner : const Center(child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator(color: Colors.orange,))),
            );
          }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return view;
  }

  String convertVariantModelArrayToJson(List<VariantModel> modelDataList) {
    List<Map<String, dynamic>> jsonData =
    modelDataList.map((word) => word.toMap()).toList();
    return jsonEncode(jsonData);
  }

  String convertMultiImgModelArrayToJson(List<MultiImgModel> modelDataList) {
    List<Map<String, dynamic>> jsonData =
    modelDataList.map((word) => word.toMap()).toList();
    return jsonEncode(jsonData);
  }
}