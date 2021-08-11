import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_with_width.dart';

class RequisitionListWidget extends StatelessWidget {
  final int index;
  final Function(int index) onTapOnList;
  final Function onRefreshed;

  RequisitionListWidget({
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    txt: 'ORDER ID - ID23232323',
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

                  Visibility(
                    visible: false,
                    child: Txt(
                      txt: 'Posted    Next Delivery',
                      txtColor: Colors.black54,
                      txtSize: 14,
                      fontWeight: FontWeight.normal,
                      padding: 5,
                      onTap: () {
                      },
                    ),
                  ),

                  Txt(
                    txt: '29-07-21    13.40',
                    txtColor: Colors.black54,
                    txtSize: 14,
                    fontWeight: FontWeight.normal,
                    padding: 5,
                    onTap: () {
                    },
                  ),
                ],
              ),

              Txt(
                txt: '5 Items',
                txtColor: Colors.black,
                txtSize: 14,
                fontWeight: FontWeight.normal,
                padding: 5,
                onTap: () {
                },
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
