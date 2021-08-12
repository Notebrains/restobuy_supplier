import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/constants/strings.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/invoice/invoice_list_widget.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/button.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_ic_row.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_input_field.dart';

class RequisitionDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, 'Requisition Details'),
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: Column(
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
                      txt: 'Download Requisition',
                      txtColor: Colors.red,
                      txtSize: 14,
                      fontWeight: FontWeight.bold,
                      icon: Icons.picture_as_pdf_rounded,
                      icColor: Colors.red,
                      isCenter: true,
                    ),

                    Txt(
                      txt: '5 Items',
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

          buildListUi(),
        ],
      ),
    );
  }

  Widget buildListUi() {
    String dropdownValue = 'Select';
    var items =  ['Select', 'Available','Unavailable','Partially Available',];

    return Expanded(
      child: SlideInUp(
        child: Container(
          margin: EdgeInsets.only(bottom: 12,),
          color: Colors.grey[100],
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: cachedNetImgWithRadius(
                              Strings.imgUrlTestSupplyProduct, 100, 100, 0),
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
                                  showBottomSheetUi(context);
                                },
                              ),

                              DropdownButton(
                                underline: Container(),
                                value: dropdownValue,
                                icon: Icon(Icons.keyboard_arrow_down),
                                items:items.map((String items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items)
                                  );
                                }
                                ).toList(),
                                onChanged: (String? newValue){
                                 /* setState(() {
                                    dropdownValue = newValue!;
                                  });*/
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

  showBottomSheetUi(BuildContext context) {
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
            return Container(
              height: 350,
              padding: EdgeInsets.only(bottom: 26, left: 12),
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(35.0),
                topLeft: Radius.circular(35.0),
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 24,
                ),
              ],
            ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 16),
                    child: Text(
                      "Partially Available",
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black87),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey[300],
                    ),
                  ),


                  TxtIf(
                    txt: 'Quantity',
                    initialTxtValue: '',
                    hint: 'Enter qty here',
                    icon: null,
                    isReadOnly: false,
                    textInputType: TextInputType.text,
                    //validator: validator,
                    //onSaved: onSaved,
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 32, 20.0, 0),
                    child: Button(text: 'SUBMIT', onPressed: () {

                    },),
                  ),
                ],
              ),
            );
          });
        });
  }
}
