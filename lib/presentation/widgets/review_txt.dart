import 'package:flutter/material.dart';

class ReviewTxtIf extends StatelessWidget {
  final String txt;
  final String initialTxtValue;
  final String hint;
  final int maxLine;
  //final String Function(String) validator;
  final Function(String) onSaved;

  const ReviewTxtIf({
    Key? key,
    required this.txt,
    required this.initialTxtValue,
    required this.hint,
    required this.maxLine,
    //required this.validator,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 18, 25.0, 8),
          child: Text(
            txt,
            textAlign: TextAlign.start,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black54),
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
            initialValue: initialTxtValue,
            autocorrect: true,
            style: const TextStyle(color: Colors.black),
            minLines: maxLine,
            maxLines: 20,
            onChanged: (value){
              onSaved(value);
            },
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.all(16),
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.white, width: 2),
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
