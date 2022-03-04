import 'package:flutter/material.dart';

class TxtIfPreview extends StatelessWidget {
  final String txt;
  final String ifTxt;
  final IconData? icon;
  final Function onTap;
  const TxtIfPreview({
    Key? key,
    required this.txt,
    required this.ifTxt,
    required this.icon,
    required this.onTap,
    //required this.validator,
    //required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 18, 8.0, 8),
            child: Text(
              txt,
              textAlign: TextAlign.start,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black54),
            ),
          ),

          Container(
            height: 50,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 2.0,
              ),
            ]),
            margin: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                hintText: ifTxt,
                contentPadding: const EdgeInsets.only(top: 16),
                prefixIcon: Icon(
                  icon,
                  color: Colors.black54,
                ),
                hintStyle: const TextStyle(color: Colors.black),
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
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
