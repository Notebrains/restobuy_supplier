import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/constants/strings.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/models/invoice_details_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/invoice/invoice_list_widget.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/cached_pdfview.dart';
import 'package:restobuy_supplier_flutter/presentation/themes/theme_color.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_back_cart.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_ic_row.dart';

class InvoiceDetails extends StatefulWidget {
  final String invoiceId;

  const InvoiceDetails({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<InvoiceDetails> createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  late Future<bool> _future;
  late bool isApiDataAvailable = false;
  InvoiceDetailsApiResModel model = InvoiceDetailsApiResModel();


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
      //String? userId = await MySharedPreferences().getUserId();

      Map<String, dynamic> body = {};
      body['id'] = widget.invoiceId;
      await ApiFun.apiPostWithBody(ApiConstants.viewInvoice, body).then((jsonDecodeData) => {
        model = InvoiceDetailsApiResModel.fromJson(jsonDecodeData),
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
      appBar: appBarIcBack(context, 'Invoice Details'),
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
                              txt: 'Order id - ${model.response!.invoiceId!}',
                              txtColor: AppColor.appTxtAmber,
                              txtSize: 14,
                              fontWeight: FontWeight.bold,
                              padding: 2,
                            ),

                            Txt(
                              txt: model.response!.restaurantName!,
                              txtColor: Colors.black54,
                              txtSize: 14,
                              fontWeight: FontWeight.bold,
                              padding: 2,
                            ),


                            TxtIcRow(
                              txt: model.response!.datetime!,
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
                                txt: 'View invoice',
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
                                  MaterialPageRoute(builder: (context) =>
                                      CachedPdfView(pdfUrl: model.response!.pdf ?? ''),
                                  ),
                                );
                              },
                            ),

                            Txt(
                              txt: 'PO id - ${model.response!.purchaseOrderId!}',
                              txtColor: Colors.black54,
                              txtSize: 14,
                              fontWeight: FontWeight.bold,
                              padding: 2,
                            ),

                            Txt(
                              txt: 'Total amount - ${model.response!.invoiceAmount!}',
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

                  buildListUi(),
                ],
              );
            }
            else {return const Center(child: Text("No Invoice Found"));}
          } else {
            return const LottieLoading();
          }
        },
      ),
    );
  }

  Widget buildListUi() {
    return Expanded(
      child: SlideInUp(
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          color: Colors.grey[100],
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: model.response!.products!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade100,
                        blurRadius: 3,
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
                          padding: const EdgeInsets.all(12.0),
                          child: cachedNetImgWithRadius(
                              model.response!.products![index].image?? '', 100, 100, 5, BoxFit.cover,
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
                              txt: model.response!.products![index].productName!,
                              txtColor: Colors.black,
                              txtSize: 16,
                              fontWeight: FontWeight.normal,
                              padding: 0,
                            ),

                            Txt(
                              txt: 'QTY - ${model.response!.products![index].qty!}',
                              txtColor: Colors.grey.shade600,
                              txtSize: 14,
                              fontWeight: FontWeight.normal,
                              padding: 0,
                            ),

                            Txt(
                              txt: 'Amount - ${model.response!.products![index].price!}',
                              txtColor: Colors.black,
                              txtSize: 14,
                              fontWeight: FontWeight.normal,
                              padding: 0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
