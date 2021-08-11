import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/constants/strings.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/invoice/invoice_list_widget.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_ic_row.dart';

class PurchaseOrderDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, 'Purchase Order Details'),
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          InkWell(
            child: Container(
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
                        txt: 'ORDER ID - 23232323',
                        txtColor: Colors.amber,
                        txtSize: 14,
                        fontWeight: FontWeight.bold,
                        padding: 5,
                        onTap:  (){},
                      ),

                      Txt(
                        txt: 'Restaurant Name',
                        txtColor: Colors.black,
                        txtSize: 16,
                        fontWeight: FontWeight.bold,
                        padding: 5,
                        onTap: () {
                        },
                      ),

                      Txt(
                        txt: '29-07-21  13.40',
                        txtColor: Colors.black54,
                        txtSize: 14,
                        fontWeight: FontWeight.normal,
                        padding: 5,
                        onTap: () {
                        },
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TxtIcRow(
                          txt: 'Download PO',
                          txtColor: Colors.red,
                          txtSize: 14,
                          fontWeight: FontWeight.bold,
                          icon: Icons.picture_as_pdf_rounded,
                          icColor: Colors.red,
                      ),

                      Txt(
                        txt: 'Total Amount: \$300',
                        txtColor: Colors.black,
                        txtSize: 14,
                        fontWeight: FontWeight.bold,
                        padding: 3,
                        onTap: (){},
                      ),
                    ],
                  ),
                ],
              ),
            ),

            onTap: (){

            },
          ),

          buildListUi(),
        ],
      ),
    );
  }

  Widget buildListUi() {
    return Expanded(
      child: SlideInUp(
        child: Container(
          margin: EdgeInsets.only(bottom: 12),
          color: Colors.grey[100],
          child: ListView.builder(
              itemCount: 3,
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
                          child: cachedNetImgWithRadius(
                              Strings.imgUrlTestSupplyProduct,
                              100, 100, 0),
                        ),

                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                txt: 'Product Name',
                                txtColor: Colors.black,
                                txtSize: 16,
                                fontWeight: FontWeight.bold,
                                padding: 3,
                                onTap:  (){},
                              ),

                              Txt(
                                txt: 'QTY-3',
                                txtColor: Colors.grey.shade600,
                                txtSize: 14,
                                fontWeight: FontWeight.normal,
                                padding: 3,
                                onTap: () {
                                },
                              ),

                              Txt(
                                txt: '\$100.00',
                                txtColor: Colors.black,
                                txtSize: 14,
                                fontWeight: FontWeight.bold,
                                padding: 3,
                                onTap: () {
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                  },
                );
              }),
        ),
      ),
    );
  }
}
