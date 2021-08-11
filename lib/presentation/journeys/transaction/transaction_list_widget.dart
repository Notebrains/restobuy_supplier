import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_with_width.dart';

class TransactionListWidget extends StatelessWidget {
  final int index;
  final Function(int index) onTapOnList;
  final Function onRefreshed;

  TransactionListWidget({
    Key? key,
    required this.index,
    required this.onTapOnList,
    required this.onRefreshed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ('ssdsd'.isNotEmpty) {
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
                        txt: 'ORDER ID - 23232323',
                        txtColor: Colors.amber,
                        txtSize: 14,
                        fontWeight: FontWeight.bold,
                        padding: 3,
                        onTap:  (){},
                      ),

                      Txt(
                        txt: 'Restaurant Name',
                        txtColor: Colors.black,
                        txtSize: 16,
                        fontWeight: FontWeight.bold,
                        padding: 3,
                        onTap: () {
                        },
                      ),

                      Txt(
                        txt: 'INVOICE ID\nINV0453235',
                        txtColor: Colors.black54,
                        txtSize: 14,
                        fontWeight: FontWeight.normal,
                        padding: 3,
                        onTap: () {
                        },
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        txt: '29-07-21  13.40',
                        txtColor: Colors.black,
                        txtSize: 14,
                        fontWeight: FontWeight.normal,
                        padding: 5,
                        onTap: () {
                        },
                      ),
                      Txt(
                        txt: '\$100.00',
                        txtColor: Colors.black,
                        txtSize: 16,
                        fontWeight: FontWeight.bold,
                        padding: 5,
                        onTap: (){},
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.only(top: 8, right: 4),
                        decoration: BoxDecoration(
                          color: Colors.lightGreenAccent.shade100,
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        alignment: Alignment.center,
                        child: Txt(
                          txt: 'Successful',
                          txtColor: Colors.black,
                          txtSize: 14,
                          fontWeight: FontWeight.normal,
                          padding: 3,
                          onTap:  (){},
                        ),
                      ),
                      onTap: () {

                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.only(top: 8, left: 4,),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        alignment: Alignment.center,
                        child: Txt(
                          txt: 'Cash',
                          txtColor: Colors.black,
                          txtSize: 14,
                          fontWeight: FontWeight.normal,
                          padding: 3,
                          onTap:  (){},
                        ),
                      ),
                      onTap: () {

                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        onTap: (){
          onTapOnList(index);
        },
      );
    } else {
      return NoDataFound(txt: 'No data found',
        onRefresh: (){
          print('---- : -----');
          onRefreshed();
        },
      );
    }
  }
}
