import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/flutter_toast.dart';


String getFirstWordFromText(String txt) {
  return (txt + " ").split(" ")[0]; //add " " to string to be sure there is something to split
}

void showToast(BuildContext context, String message) {
  Toast.show(message, context,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      backgroundColor: Colors.black87.withOpacity(0.5),
      textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 16,
        fontFamily: 'Roboto',
        shadows: [
          Shadow(color: Colors.white),
        ],
      ),
  );
}

String convertStrToDoubleStr(String value) => value.isNotEmpty ? double.parse(value).toStringAsFixed(2).toString(): '0';

String convertStrToDoubleStrWithZeroDecimal(String value) => value.isNotEmpty ? double.parse(value).toStringAsFixed(0).toString(): '0';

String formatDateForUs(DateTime date) => new DateFormat("MM-dd-yyyy").format(date);

String formatDateForServer(DateTime date) => new DateFormat("yyyy-MM-dd").format(date);

