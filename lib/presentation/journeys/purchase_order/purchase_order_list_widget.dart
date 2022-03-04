import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/data/models/PurchaseOrderApiResModel.dart';
import 'package:restobuy_supplier_flutter/presentation/themes/theme_color.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';

class PurchaseOrderListWidget extends StatelessWidget {
  final List<Response>? response;
  final int index;
  final Function(int index) onTapOnList;
  final Function onRefreshed;

  const PurchaseOrderListWidget({
    Key? key,
    required this.response,
    required this.index,
    required this.onTapOnList,
    required this.onRefreshed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (response!.isNotEmpty) {
      return InkWell(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        txt: 'PO id - ${response![index].orderId}',
                        txtColor: AppColor.appTxtAmber,
                        txtSize: 14,
                        fontWeight: FontWeight.bold,
                        padding: 5
                      ),

                      Txt(
                        txt: response![index].restaurantName??'',
                        txtColor: Colors.black,
                        txtSize: 16,
                        fontWeight: FontWeight.bold,
                        padding: 5,
                      ),

                      Txt(
                        txt: response![index].datetime??'',
                        txtColor: Colors.black54,
                        txtSize: 14,
                        fontWeight: FontWeight.normal,
                        padding: 5,
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        txt: '${response![index].totalItems??''} Items',
                        txtColor: Colors.black,
                        txtSize: 14,
                        fontWeight: FontWeight.normal,
                        padding: 5,
                      ),
                      Txt(
                        txt: response![index].purchaseAmount??'',
                        txtColor: Colors.black,
                        txtSize: 16,
                        fontWeight: FontWeight.bold,
                        padding: 5,
                      ),
                    ],
                  ),
                ],
              ),

              /* Container(
                  height: 40,
                  margin: const EdgeInsets.only(top: 8, left: 4,),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent.withOpacity(0.1),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  alignment: Alignment.center,
                  child: const Txt(
                    txt: 'Delete',
                    txtColor: Colors.black,
                    txtSize: 14,
                    fontWeight: FontWeight.normal,
                    padding: 3,
                  ),
              ),*/
            ],
          ),
        ),

        onTap: (){
          onTapOnList(index);
        },
      );
    } else {
      return NoDataFound(txt: 'No data found!',
        onRefresh: (){
          onRefreshed();
        },
      );
    }
  }
}
