import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/presentation/themes/theme_color.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/data/models/RequisitionApiResModel.dart';

class RequisitionListWidget extends StatelessWidget {
  final List<Response> response;
  final int index;
  final Function(int index) onTapOnList;
  final Function onRefreshed;

  const RequisitionListWidget({
    Key? key,
    required this.response,
    required this.index,
    required this.onTapOnList,
    required this.onRefreshed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print('----isRequisitionTabSelected : $isRequisitionTabSelected');
    if (response.isNotEmpty) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt(
                txt: 'Order id - ${response[index].orderId}',
                txtColor: AppColor.appTxtAmber,
                txtSize: 16,
                fontWeight: FontWeight.bold,
                padding: 0,
              ),

              Txt(
                  txt: response[index].restaurantName ?? '',
                  txtColor: Colors.black,
                  txtSize: 14,
                  fontWeight: FontWeight.bold,
                  padding: 0,
                ),

              Txt(
                txt: '${response[index].items!} items',
                txtColor: Colors.black,
                txtSize: 14,
                fontWeight: FontWeight.normal,
                padding: 0,
              ),

              Txt(
                txt: 'Date & time - ${response[index].datetime!}',
                txtColor: Colors.black54,
                txtSize: 14,
                fontWeight: FontWeight.normal,
                padding: 0,
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
          //print('---- : -----');
          onRefreshed();
        },
      );
    }
  }
}
