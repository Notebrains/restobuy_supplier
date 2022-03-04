import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/constants/strings.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/RequisitionDetailsApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/cached_pdfview.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/drop_down_statefull_dialog.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/themes/theme_color.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/drop_down_dialog_requisition.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/drop_down_unavailable_dialog.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_ic_row.dart';


class RequisitionDetails extends StatefulWidget {
  final String requisitionId;
  final String userId;
  final String orderId;
  final String restaurantName;
  final String dateTime;
  final String qty;

  const RequisitionDetails({Key? key,
    required this.requisitionId,
    required this.userId,
    required this.orderId,
    required this.restaurantName,
    required this.dateTime,
    required this.qty,
  }) : super(key: key);

  @override
  State<RequisitionDetails> createState() => _RequisitionDetailsState();
}

class _RequisitionDetailsState extends State<RequisitionDetails> {
  //List<Save_requisitions_product> savedRequisitionList = [];

  late Future<bool> _future;

  late bool isApiDataAvailable = false;

  RequisitionDetailsApiResModel model = RequisitionDetailsApiResModel();

  String variant = 'Select';

  List<String> selectedItemValue = [];

  @override
  void initState() {
    super.initState();
    _future = getDataFromApi();
  }



  Future<bool> getDataFromApi() async {
    try{
      Map<String, dynamic> body = {};
      body['user_id'] = widget.userId;
      body['requisition_id'] = widget.requisitionId;

      await ApiFun.apiPostWithBody(ApiConstants.requisitionProduct, body).then((jsonDecodeData) {
        model = RequisitionDetailsApiResModel.fromJson(jsonDecodeData);
      });

      if(model.status == 1 && model.response!.requisitionsProduct!.isNotEmpty) {
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
      appBar: appBarIcBack(context, 'Info'),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(snapShot.hasData && snapShot.connectionState == ConnectionState.done){
            if(isApiDataAvailable){
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Txt(
                              txt: 'Order id - ${widget.orderId}',
                              txtColor: AppColor.appTxtAmber,
                              txtSize: 14,
                              fontWeight: FontWeight.bold,
                              padding: 0,
                            ),

                            /*Txt(
                              txt: 'Requisition id - ${widget.requisitionId}',
                              txtColor: Colors.black54,
                              txtSize: 14,
                              fontWeight: FontWeight.normal,
                              padding: 0,
                            ),*/

                            Txt(
                              txt: widget.restaurantName,
                              txtColor: Colors.black54,
                              txtSize: 16,
                              fontWeight: FontWeight.bold,
                              padding: 0,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 5, top: 2),
                              child: TxtIcRow(
                                txt: widget.dateTime,
                                txtColor: Colors.black54,
                                txtSize: 14,
                                fontWeight: FontWeight.normal,
                                icon: Icons.date_range,
                                icColor: Colors.black54,
                                isCenter: true,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child:
                              const Padding(padding: EdgeInsets.only(right: 12),
                                child: TxtIcRow(
                                  txt: 'View',
                                  txtColor: Colors.red,
                                  txtSize: 14,
                                  fontWeight: FontWeight.bold,
                                  icon: Icons.picture_as_pdf_rounded,
                                  icColor: Colors.red,
                                  isCenter: true,
                                ),
                              ),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      CachedPdfView(pdfUrl: model.response!.pdffile!.pdf ?? ''),
                                  ),
                                );
                              },
                            ),

                            Txt(
                              txt: '${widget.qty} Items',
                              txtColor: Colors.black,
                              txtSize: 14,
                              fontWeight: FontWeight.bold,
                              padding: 0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: model.response!.requisitionsProduct?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: Colors.grey.shade300),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.shade100,
                                    blurRadius: 1,
                                  )
                                ]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 3, right: 10, top: 6),
                                  child: cachedNetImgWithRadius(model.response!.requisitionsProduct![index].image!, 80, 80, 4, BoxFit.cover),
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Txt(
                                      txt: model.response!.requisitionsProduct![index].productName!,
                                      txtColor: Colors.black,
                                      txtSize: 16,
                                      fontWeight: FontWeight.w600,
                                      padding: 0,
                                    ),

                                    Txt(
                                      txt: 'Price - ${model.response!.requisitionsProduct![index].price!}        Qty - ${model.response!.requisitionsProduct![index].qty!}',
                                      txtColor: Colors.grey.shade600,
                                      txtSize: 14,
                                      fontWeight: FontWeight.normal,
                                      padding: 0,
                                    ),

                                    Txt(
                                      txt: 'Sub total - \$${model.response!.requisitionsProduct![index].subtotal!}',
                                      txtColor: Colors.grey.shade600,
                                      txtSize: 14,
                                      fontWeight: FontWeight.normal,
                                      padding: 0,
                                    ),

                                    Txt(
                                      txt: 'Variant - ${model.response!.requisitionsProduct![index].variant!}',
                                      txtColor: Colors.grey.shade600,
                                      txtSize: 14,
                                      fontWeight: FontWeight.normal,
                                      padding: 0,
                                    ),

                                    Visibility(
                                      visible: model.response!.requisitionsProduct![index].status == null || model.response!.requisitionsProduct![index].status.toString().isEmpty,
                                      child: InkWell(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 6, bottom: 4,left: 2),
                                              child: Text(
                                                'Select',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: getColor(model.response!.requisitionsProduct![index].status??'Select')),
                                              ),
                                            ),

                                            const Icon(
                                              Icons.add_box_rounded,
                                              size: 20,
                                              color: AppColor.appTxtAmber,
                                            ),

                                          ],
                                        ),

                                        onTap: (){
                                          showDropDownDialogRequisition(context, (userInput) {
                                            if (kDebugMode) {
                                              print('----userInput 1: $userInput');
                                            }

                                            if (userInput == 'Available') {
                                              WidgetsBinding.instance?.addPostFrameCallback((_) {
                                                updateRequisitionProductStatus( 'Available', model.response!.requisitionsProduct![index].requisitionId.toString(), '' '', '', '', '',);
                                              });
                                            } else if (userInput == 'Partially Available') {
                                              WidgetsBinding.instance?.addPostFrameCallback((_) {
                                                showDropDownPartiallyAvailableDialog(context, (qty) {
                                                  if (kDebugMode) {
                                                    print('----Partially Available qty: $qty');
                                                  }
                                                  updateRequisitionProductStatus( 'Partially Available', model.response!.requisitionsProduct![index].requisitionId.toString(), '' '', '', '', qty,);
                                                });
                                              });
                                            } else if (userInput == 'Unavailable') {
                                              WidgetsBinding.instance?.addPostFrameCallback((_) {
                                                showDropDownUnavailableDialog(context, (categoryId, productId, variant, qty){
                                                  if (kDebugMode) {
                                                    print('----categoryId, productId, variantId, qty : $categoryId, $productId, $variant, $qty');
                                                  }
                                                  updateRequisitionProductStatus('Unavailable', model.response!.requisitionsProduct![index].requisitionId.toString(), categoryId, productId, variant, qty,);
                                                });
                                              });
                                            }
                                          });
                                        },
                                      ),
                                    ),

                                    Visibility(
                                      visible: model.response!.requisitionsProduct![index].status != null || model.response!.requisitionsProduct![index].status.toString().isNotEmpty,
                                      child: Txt(
                                        txt: model.response!.requisitionsProduct![index].status?? '',
                                        txtColor: getColor(model.response!.requisitionsProduct![index].status ?? 'Select'),
                                        txtSize: 14,
                                        fontWeight: FontWeight.bold,
                                        padding: 0,
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              );
            }
            else {return NoDataFound(txt: 'No data found', onRefresh: (){});}
          } else {
            return const LottieLoading();
          }
        },
      ),
    );
  }

  Color getColor(status) {
    Color color = Colors.black54;
    switch(status){
      case 'Select' :
        color = Colors.black54;
        break;
      case 'Available' :
        color = Colors.green;
        break;
      case 'Partially Available' :
        color =  Colors.orange;
        break;
      case 'Unavailable' :
        color =  Colors.amber.shade800;
        break;
      case 'Cancelled' :
        color =  Colors.red;
        break;
    }
    return color;
  }

  void updateRequisitionProductStatus( String status, String requisitionId, String categoryId, String productId,
      String variant, String qty,) async {
    try{
      showLoadingDialog(context);

      String? userId = await MySharedPreferences().getUserId();

      Map<String, dynamic> body = {};
      body['user_id'] = userId;
      body['requisition_id'] = requisitionId;
      body['category_id'] = categoryId;
      body['product_id'] = productId;
      body['variant'] = variant;
      body['qty'] = qty;
      body['status'] = status;

      await ApiFun.apiPostWithBody(ApiConstants.requisitionSendApproval, body).then((jsonDecodeData) {
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

