import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/models/PurchaseOrderDetailsApiResModel.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/cached_pdfview.dart';
import 'package:restobuy_supplier_flutter/presentation/themes/theme_color.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_ic_row.dart';

class PurchaseOrderDetails extends StatefulWidget {
  final String orderId;
  final String purchaseOrderId;
  final String purchaseAmount;
  final String supplierName;
  final String dateTime;
  final String totalItems;

  const PurchaseOrderDetails({Key? key, required this.orderId, required this.purchaseOrderId, required this.purchaseAmount,
    required this.supplierName, required this.dateTime, required this.totalItems}) : super(key: key);


  @override
  State<PurchaseOrderDetails> createState() => _PurchaseOrderDetailsState();
}

class _PurchaseOrderDetailsState extends State<PurchaseOrderDetails> {

  late Future<bool> _future;
  late bool isApiDataAvailable = false;
  PurchaseOrderDetailsApiResModel model = PurchaseOrderDetailsApiResModel();

  @override
  void initState() {
    super.initState();

    _future = getDataFromApi();
  }


  Future<bool> getDataFromApi() async {
    try{

      Map<String, dynamic> body = {};
      body["purchase_order_id"] = widget.purchaseOrderId;

      await ApiFun.apiPostWithBody(ApiConstants.purchaseOrdersDetails, body).then((jsonDecodeData) => {
        model = PurchaseOrderDetailsApiResModel.fromJson(jsonDecodeData),
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
      appBar: appBarIcBack( context, 'Details'),
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(snapShot.hasData){
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
                              txt: 'PO id - ${widget.orderId}',
                              txtColor: AppColor.appTxtAmber,
                              txtSize: 14,
                              fontWeight: FontWeight.bold,
                              padding: 2,
                            ),

                            Txt(
                              txt: widget.supplierName,
                              txtColor: Colors.black,
                              txtSize: 14,
                              fontWeight: FontWeight.bold,
                              padding: 2,
                            ),

                            TxtIcRow(
                              txt: widget.dateTime,
                              txtColor: Colors.black54,
                              txtSize: 14,
                              fontWeight: FontWeight.normal,
                              icon: Icons.date_range_outlined,
                              icColor: Colors.black54,
                              isCenter: true,
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: const TxtIcRow(
                                txt: 'Download PO',
                                txtColor: Colors.red,
                                txtSize: 14,
                                fontWeight: FontWeight.bold,
                                icon: Icons.picture_as_pdf_rounded,
                                icColor: Colors.red,
                                isCenter: true,
                              ),

                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CachedPdfView(pdfUrl: model.response!.pdffile!.pdf?? ''),
                                  ),
                                );
                              },
                            ),

                            Txt(
                              txt: 'Sub Total - ${widget.purchaseAmount}',
                              txtColor: Colors.black,
                              txtSize: 14,
                              fontWeight: FontWeight.bold,
                              padding: 2,
                            ),

                            Txt(
                              txt: 'Total Item - ${widget.totalItems}',
                              txtColor: Colors.black54,
                              txtSize: 14,
                              fontWeight: FontWeight.normal,
                              padding: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  buildListUi(model.response!.products!),
                ],
              );
            }
            else { return NoDataFound(txt: 'No data found', onRefresh: (){});}
          } else {
            return const LottieLoading();
          }
        },
      ),
    );
  }

  Widget buildListUi(List<Products> response) {
    return Expanded(
      child: SlideInUp(
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          color: Colors.grey.shade100,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: response.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: cachedNetImgWithRadius(
                                response[index].image!,
                                100, 100, 5, BoxFit.cover,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                txt: response[index].productName!,
                                txtColor: Colors.black,
                                txtSize: 16,
                                fontWeight: FontWeight.bold,
                                padding: 0,
                              ),

                              Txt(
                                txt: 'Price - ${response[index].price!}     Qty - ${response[index].qty!}',
                                txtColor: Colors.grey.shade700,
                                txtSize: 14,
                                fontWeight: FontWeight.normal,
                                padding: 0,
                              ),

                              Txt(
                                txt: 'Unit - ${response[index].variant!}',
                                txtColor: Colors.grey.shade700,
                                txtSize: 14,
                                fontWeight: FontWeight.normal,
                                padding: 0,
                              ),

                              Txt(
                                txt: 'Sub total - ${response[index].subtotal!}',
                                txtColor: Colors.grey.shade700,
                                txtSize: 14,
                                fontWeight: FontWeight.normal,
                                padding: 0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  onTap: (){},
                );
              }),
        ),
      ),
    );
  }
}
