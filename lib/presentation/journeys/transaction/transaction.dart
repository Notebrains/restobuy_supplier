import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';

import 'transaction_list_widget.dart';


class Transaction extends StatefulWidget {
  static const String routeName = '/orders';

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Transaction> {
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
      appBar: appBarIcBack(context, 'Transaction'),
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: buildUi(),
    );
  }

  Widget buildUi() {
    //print('----${offerList.length}');
    return SlideInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12, top: 8),
        child: ListView.builder(
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return TransactionListWidget(
                //response: _searchResult,
                index: index,
                onTapOnList: (intValue){
                  Navigator.of(context).pushNamed(RouteList.purchase_order_details);
                },
                onRefreshed: () {

                },
              );
            }),
      ),
    );
  }
}
