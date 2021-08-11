import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/invoice_details/invoice_details.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_ic_row.dart';

import 'requisition_list_widget.dart';


class Requisition extends StatefulWidget {

  @override
  _RequisitionsState createState() => _RequisitionsState();
}

class _RequisitionsState extends State<Requisition> {
  TextEditingController controller = TextEditingController();
  String fromDateStr = '', toDateStr = '';
  late DateTime fromDate;
  late DateTime toDate;
  late List<String> _searchResult = [];
  late List<String> listData = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, 'Requisition'),
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SlideInLeft(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 5, top: 8, left: 16, right: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.amber),
                    ),
                    alignment: Alignment.center,
                    child:
                    Txt(
                      txt: 'Requisition',
                      txtColor: Colors.amber,
                      txtSize: 14,
                      fontWeight: FontWeight.bold,
                      padding: 6,
                      onTap: (){},
                    ),
                  ),
                  onTap: () {
                  },
                ),
                InkWell(
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 5, top: 8, left: 4, right: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.grey.shade50),
                    ),
                    alignment: Alignment.center,
                    child:
                    Txt(
                      txt: 'Recurring Requisition',
                      txtColor: Colors.black,
                      txtSize: 14,
                      fontWeight: FontWeight.normal,
                      padding: 6,
                      onTap: (){},
                    ),
                  ),
                  onTap: () {

                  },
                ),

              ],
            ),
          ),
          Expanded(
            child: LiquidPullToRefresh(
              backgroundColor: Colors.blueAccent,
              color: Colors.white,
              onRefresh: () {
                return Future.delayed(
                  Duration(milliseconds: 700), () {
                  buildUi();
                },
                );
              },
              child: buildUi(),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white, size: 29,),
        backgroundColor: Colors.amber,
        tooltip: 'Pressed',
        elevation: 5,
        splashColor: Colors.grey,
      ),
    );
  }

  Widget buildUi() {
    //print('----${offerList.length}');
    return SlideInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        child: ListView.builder(
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return RequisitionListWidget(
                //response: _searchResult,
                index: index,
                onTapOnList: (intValue){
                  Navigator.of(context).pushNamed(RouteList.requisitions_details);
                },
                onRefreshed: () {
                },
              );
            }),
      ),
    );
  }
}
