import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/models/DisputeApiResModel.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';

class DisputeListWidget extends StatelessWidget {
  final List<Response> response;
  final int index;
  final Function(int index) onTapOnDelete;
  final Function onTapOnChatBtn;

  const DisputeListWidget({
    Key? key,
    required this.response,
    required this.index,
    required this.onTapOnDelete,
    required this.onTapOnChatBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (response.isNotEmpty) {
      return Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(
                      txt: 'Dispute Id - ${response[index].disputeId}',
                      txtColor: Colors.amber.shade600,
                      txtSize: 14,
                      fontWeight: FontWeight.bold,
                      padding: 5,
                    ),

                    Txt(
                      txt: response[index].restaurantName??'',
                      txtColor: Colors.black,
                      txtSize: 14,
                      fontWeight: FontWeight.bold,
                      padding: 5,
                    ),
                  ],
                ),


                Txt(
                  txt: 'Ticket Id - \n${response[index].ticketId}',
                  txtColor: Colors.black54,
                  txtSize: 14,
                  fontWeight: FontWeight.normal,
                  padding: 5,
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 12, left: 5),
              child: Text(
                parseHtmlString(response[index].disputesReason?? ''),
                style: const TextStyle( fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
              ),
            ),

            /*const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 12, left: 5),
                child: Text(
                  'Read More',
                  style: TextStyle( fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
                ),
              ),
            ),*/

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Container(
                      height: 35,
                      margin: const EdgeInsets.only(top: 8, right: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      alignment: Alignment.center,
                      child: const Txt(
                        txt: 'Chat',
                        txtColor: Colors.black,
                        txtSize: 14,
                        fontWeight: FontWeight.normal,
                        padding: 3,
                      ),
                    ),
                    onTap: () {
                      onTapOnChatBtn();
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Container(
                      height: 35,
                      margin: const EdgeInsets.only(top: 8, left: 4,),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
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
                    ),
                    onTap: () {
                      onTapOnDelete(index);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return NoDataFound(txt: 'No data found',
        onRefresh: (){
        },
      );
    }
  }
}
