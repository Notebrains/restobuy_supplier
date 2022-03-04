import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';

import 'drop_down_dialog_sort.dart';
import 'txt_ic_row.dart';

class FilterDateSort extends StatefulWidget{
  final Function(String fromDateStr, String toDateStr, String sortStr) onTap;

  const FilterDateSort({Key? key, required this.onTap}) : super(key: key);

  @override
  State<FilterDateSort> createState() => _FilterDateSortState();
}

class _FilterDateSortState extends State<FilterDateSort> {
  String fromDateStr = '', toDateStr = '', sortStr = '';

  @override
  Widget build(BuildContext context) {
    return SlideInLeft(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(bottom: 5, top: 12, left: 16, right: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                alignment: Alignment.center,
                child: TxtIcRow(
                  txt: fromDateStr.isEmpty ? '  From' : fromDateStr,
                  txtColor: Colors.black54,
                  txtSize: fromDateStr.isEmpty ? 14: 11,
                  fontWeight: FontWeight.normal,
                  icon: Icons.date_range_outlined,
                  icColor: Colors.grey,
                  isCenter: true,
                ),
              ),
              onTap: () {
                pickDate(context).then((pickedDate) => {
                  setState(() {
                    fromDateStr = pickedDate;
                  }),
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(bottom: 5, top: 12, left: 4, right: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                alignment: Alignment.center,
                child: TxtIcRow(
                  txt: toDateStr.isEmpty ? '  To' : toDateStr,
                  txtColor: Colors.black54,
                  txtSize: toDateStr.isEmpty ? 14: 11,
                  fontWeight: FontWeight.normal,
                  icon: Icons.date_range_outlined,
                  icColor: Colors.grey,
                  isCenter: true,
                ),
              ),
              onTap: () {
                pickDate(context).then((pickedDate) => {
                  setState(() {
                    toDateStr = pickedDate;
                  }),
                });
              },
            ),
          ),

          Expanded(
            flex: 1,
            child: InkWell(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(bottom: 5, top: 12, left: 4, right: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                alignment: Alignment.center,
                child: TxtIcRow(
                  txt: sortStr.isEmpty ? '  Sort' : sortStr,
                  txtColor: Colors.black54,
                  txtSize: sortStr.isEmpty ? 14 : 12,
                  fontWeight: FontWeight.normal,
                  icon: Icons.sort_rounded,
                  icColor: Colors.grey,
                  isCenter: true,
                ),
              ),
              onTap: () {
                showDropDownDialogToSort(context, (userInput){
                  if (kDebugMode) {
                    print('----userInput : $userInput');
                  }
                  setState(() {
                    sortStr = userInput;
                  });
                });
              },
            ),
          ),

          InkWell(
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(bottom: 5, top: 8, left: 4, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.grey.shade400),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.arrow_right_alt_outlined,
                color: Colors.grey,
              ),
            ),
            onTap: () {
              widget.onTap(fromDateStr, toDateStr, sortStr);
            },
          ),
        ],
      ),
    );
  }
}