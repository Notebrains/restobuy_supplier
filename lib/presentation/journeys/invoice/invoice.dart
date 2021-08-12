import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/invoice_details/invoice_details.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_ic_row.dart';

import 'invoice_list_widget.dart';

class Invoice extends StatefulWidget {
  static const String routeName = '/orders';

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Invoice> {
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
      appBar: appBarIcBack(context, 'Invoice'),
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SlideInLeft(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(bottom: 5, top: 8, left: 16, right: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      alignment: Alignment.center,
                      child: TxtIcRow(
                          txt: fromDateStr.isEmpty ? '  From' : fromDateStr,
                          txtColor: Colors.black54,
                          txtSize: 14,
                          fontWeight: FontWeight.normal,
                          icon: Icons.date_range_outlined,
                          icColor: Colors.grey,
                          isCenter: true,
                      ),
                    ),
                    onTap: () {
                      pickDateFromDatePicker();
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(bottom: 5, top: 8, left: 4, right: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      alignment: Alignment.center,
                      child: TxtIcRow(
                        txt: toDateStr.isEmpty ? '  To' : toDateStr,
                        txtColor: Colors.black54,
                        txtSize: 14,
                        fontWeight: FontWeight.normal,
                        icon: Icons.date_range_outlined,
                        icColor: Colors.grey,
                        isCenter: true,
                      ),
                    ),
                    onTap: () {
                      pickToDatePicker();
                    },
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(bottom: 5, top: 8, left: 4, right: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      alignment: Alignment.center,
                      child: TxtIcRow(
                        txt: toDateStr.isEmpty ? '  Sort' : toDateStr,
                        txtColor: Colors.black54,
                        txtSize: 14,
                        fontWeight: FontWeight.normal,
                        icon: Icons.sort_rounded,
                        icColor: Colors.grey,
                        isCenter: true,
                      ),
                    ),
                    onTap: () {
                      pickToDatePicker();
                    },
                  ),
                ),

                InkWell(
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 5, top: 3, left: 4, right: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_right_alt_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    if (fromDateStr.isNotEmpty && toDateStr.isNotEmpty) {
                      //showSnackBar(context, 'Loading data...');
                      setState(() {
                        //apiBloc.fetchOrdersApi(formatDateForServer(fromDate), formatDateForServer(toDate));
                      });
                    } else {
                      //showSnackBar(context, 'Please select both dates!');
                    }
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
        onPressed: () {
          Navigator.of(context).pushNamed(RouteList.invoice_raise);
        },
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
            itemCount: _searchResult.length != 0 || controller.text.isNotEmpty ? _searchResult.length : 10,
            itemBuilder: (BuildContext context, int index) {
              if (_searchResult.length != 0 || controller.text.isNotEmpty) {
                return InvoiceListWidget(
                  //response: _searchResult,
                  index: index,
                  onTapOnList: (intValue){},
                  onRefreshed: () {
                    print('---- : onRefresh order');
                    fromDateStr = '';
                    toDateStr = '';
                    //showSnackBar(context, 'Loading data...');
                    setState(() {
                      //apiBloc.fetchOrdersApi('', '');
                    });
                  },
                );
              } else {
                //listData = response;
                return InvoiceListWidget(
                  //response: listData,
                  index: index,
                  onTapOnList: (index) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => InvoiceDetails(),
                      ),
                    );
                  },
                  onRefreshed: () {
                    print('---- : onRefresh order');
                    fromDateStr = '';
                    toDateStr = '';
                    //showSnackBar(context, 'Loading data...');
                    setState(() {
                      //apiBloc.fetchOrdersApi('', '');
                    });
                  },
                );
              }
            }),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    listData.forEach((model) {
     /* if (model.orderId.toLowerCase().contains(text.toLowerCase()) || model.customerName.toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(model);
        print('----Search List: ${_searchResult.length}');
      }*/
    });

    setState(() {});
  }

  void pickDateFromDatePicker() {
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      fromDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 0);
      DateTime? picked = await showDatePicker(
          context: context,
          initialEntryMode: DatePickerEntryMode.calendar,
          firstDate: DateTime.now().subtract(Duration(days: 15000)),
          lastDate: DateTime(DateTime.now().year + 1),
          initialDate: fromDate,
          currentDate: fromDate,
          helpText: 'SELECT DATE',
          // Can be used as title
          cancelText: 'NOT NOW',
          confirmText: 'CONFIRM',
          builder: (context, child) {
            return Theme(
              data: ThemeData(
                textTheme: TextTheme(bodyText2: TextStyle(color: Colors.green)),
              ),
              child: child!,
            );
          });

      if (picked != null && picked != fromDate)
        setState(() {
          fromDate = picked;
          fromDateStr = formatDateForUs(fromDate);
        });
    });
  }

  void pickToDatePicker() {
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      toDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 0);
      DateTime? picked = await showDatePicker(
          context: context,
          initialEntryMode: DatePickerEntryMode.calendar,
          firstDate: DateTime.now().subtract(Duration(days: 15000)),
          lastDate: DateTime(DateTime.now().year + 1),
          initialDate: toDate,
          currentDate: toDate,
          helpText: 'SELECT DATE',
          // Can be used as title
          cancelText: 'NOT NOW',
          confirmText: 'CONFIRM',
          builder: (context, child) {
            return Theme(
              data: ThemeData(
                textTheme: TextTheme(bodyText2: TextStyle(color: Colors.green)),
              ),
              child: child!,
            );
          });

        if (picked != null && picked != toDate)
          setState(() {
            toDate = picked;
            toDateStr = formatDateForUs(toDate);
          });
    });
  }
}
