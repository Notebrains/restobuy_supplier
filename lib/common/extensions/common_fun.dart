import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:html/parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/flutter_toast.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';


Future<bool> isInternetConnectionAvailable() async {
  bool isConnectedToInternet = false;
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      isConnectedToInternet = true;
    }
  } on SocketException catch (_) {
    isConnectedToInternet = false;
    print('not connected');
  }

  return isConnectedToInternet;
}

String getFirstWordFromText(String txt) {
  return (txt + " ").split(" ")[0]; //add " " to string to be sure there is something to split
}

void showToast(BuildContext context, String message) {
  Toast.show(message, context,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      backgroundColor: Colors.black87.withOpacity(0.5),
      textStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 16,
        fontFamily: 'Roboto',
        shadows: [Shadow(color: Colors.white),],
      ),
  );
}

String convertStrToDoubleStr(String value) => value.isNotEmpty ? double.parse(value).toStringAsFixed(2).toString(): '0';

String add0toSingleStr(String value) => value.length < 2 ? "0$value": value;

String convertStrToDoubleStrWithZeroDecimal(String value) => value.isNotEmpty ? double.parse(value).toStringAsFixed(0).toString(): '0';

String formatDateForUs(DateTime date) => DateFormat("MM-dd-yyyy").format(date);

String formatDateForServer(DateTime date) => DateFormat("yyyy-MM-dd").format(date);

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}



Future<String> pickDate(BuildContext context) async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialEntryMode: DatePickerEntryMode.calendar,
    firstDate: DateTime(1980, 1),
    lastDate: DateTime(2025),
    initialDate: DateTime.now(),
    helpText: 'SELECT DATE',
    // Can be used as title
    cancelText: 'NOT NOW',
    confirmText: 'CONFIRM',
    //selectableDayPredicate: _disableDates,
    /*builder: (context, child) {
          return Theme(
            data: ThemeData(
              primaryColor: Colors.blueAccent,
              disabledColor: Colors.redAccent,
              textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.blueAccent)),
              //accentColor: Colors.blue,
            ),
            //child: child,
          );
        },*/
  );

  if (kDebugMode) {
    print('----Picked Date : $picked');
  }

  return DateFormat("dd-MM-yyyy").format(picked!);
}


void showLoadingDialog(BuildContext context) {
  late BuildContext dialogContext;
  showDialog(
    context: context,
    barrierDismissible: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      dialogContext = context;
      return Dialog(
        backgroundColor: Colors.transparent,
        child: ZoomIn(
          child: Container(
            height: 350,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              //border: Border.all(color: Colors.grey.shade50),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/animations/lottiefiles/3_line_loading.json',
                  fit: BoxFit.cover, width: 300, height: 250,),

                const Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Txt(txt: 'Loading...', txtColor: Colors.orange, txtSize: 18, fontWeight: FontWeight.normal, padding: 0),
                )
              ],
            ),
          ),
          preferences: const AnimationPreferences(duration: Duration(milliseconds: 800), autoPlay: AnimationPlayStates.Forward),
        ),
      );
    },
  );

  Timer(const Duration(milliseconds: 2000), () {
    Navigator.pop(dialogContext);
  });
}


void showIosDialog(BuildContext context, String title, String content, String btn1Txt, String btn2Txt, Function() onTapOnPositiveBtn){
  showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            btn1Txt,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            onTapOnPositiveBtn();
          },
          child: Text(
            btn2Txt,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}

