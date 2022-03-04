import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/drop_down_input.dart';
import 'package:restobuy_supplier_flutter/presentation/themes/theme_color.dart';

import 'txt.dart';

Future showDropDownDialogRequisition(context, Function(String value) onClose) async {
  String userInput = 'Available';
  return await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: AppDropdownInput(
                      hintText: "Choose",
                      options: const ['Available', "Unavailable", "Partially Available"],
                      value: userInput,
                      onChanged: (String? value) {
                        setState(() {
                          userInput = value!;
                        });
                      },
                      getLabel: (String value) => value,
                    ),
                  ),

                  InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 5, top: 24,),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Colors.grey, width: 0.5),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.shade300,
                              blurRadius: 6,
                            )
                          ]
                      ),

                      child: const Txt(
                        txt: 'Submit',
                        txtColor: AppColor.grey,
                        txtSize: 14,
                        fontWeight: FontWeight.normal,
                        padding: 3,
                      ),
                    ),

                    onTap: (){
                      onClose(userInput);
                      Navigator.of(context).pop();
                    },
                  ),

                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 5, top: 24,),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Colors.grey, width: 0.5),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.shade100,
                              blurRadius: 6,
                            )
                          ]
                      ),

                      alignment: Alignment.center,
                      child: const Txt(
                        txt: 'Cancel',
                        txtColor: AppColor.grey,
                        txtSize: 14,
                        fontWeight: FontWeight.normal,
                        padding: 3,
                      ),
                    ),

                    onTap: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ]
            );
          },
        ),
      );
    },
  );
}