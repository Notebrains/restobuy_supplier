import 'package:flutter/material.dart';

class ProductAddIf extends StatelessWidget {
  final String txt;
  final String initialTxtValue;
  final String hint;
  final bool isReadOnly;
  final TextInputType textInputType;
  final Function(String) onSaved;
  final double leftPadding;
  final double rightPadding;
  const ProductAddIf({
    Key? key,
    required this.txt,
    required this.initialTxtValue,
    required this.hint,
    required this.isReadOnly,
    required this.textInputType,
    required this.onSaved,
    required this.leftPadding,
    required this.rightPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(leftPadding, 18, rightPadding, 8),
          child: Text(
            txt,
            textAlign: TextAlign.start,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black54),
          ),
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2.0,
            ),
          ]),
          margin: EdgeInsets.fromLTRB(leftPadding - 3, 0, rightPadding - 3, 0),
          child: TextFormField(
            initialValue: initialTxtValue,
            readOnly: isReadOnly,
            autocorrect: true,
            keyboardType: textInputType,
            style: const TextStyle(color: Colors.black),
            onChanged: (value){onSaved(value);},
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Enter here';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.only(left: 16),
              hintStyle: const TextStyle(color: Colors.black54),
              filled: true,
              //fillColor: isReadOnly ? Colors.grey.shade100 : Colors.white,
              fillColor: Colors.white,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide:  BorderSide(color: Colors.white, width: 2),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.amber, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
