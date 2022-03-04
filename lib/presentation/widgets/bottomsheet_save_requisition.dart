
import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';

import 'button.dart';
import 'txt_input_field.dart';

showBottomSheetUiToSaveRequisition(BuildContext context, Function(String templateName) onClose) {
  String templateName = '';
  showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
          return Container(
            height: 350,
            padding: const EdgeInsets.only(bottom: 26, left: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(35.0),
                topLeft: Radius.circular(35.0),
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 24,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 26, bottom: 16, left: 16),
                  child: Text(
                    "Save Requisition",
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey[300],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 18, 25.0, 8),
                  child: Text(
                    'Template name',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black87),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 2.0,
                    ),
                  ]),
                  margin: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                  child: TextFormField(
                    autocorrect: true,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (value){
                      templateName = value;
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Enter name here',
                      contentPadding: EdgeInsets.all(8),
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.amber, width: 1),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 32, 20.0, 0),
                  child: Button(text: 'Submit', onPressed: () {
                    if (templateName.isNotEmpty) {
                      Navigator.pop(context);
                      onClose(templateName);
                    } else {
                      edgeAlert(context, title: 'Warning!', description: 'Please select quantity');
                    }
                  },),
                ),
              ],
            ),
          );
        });
      });
}