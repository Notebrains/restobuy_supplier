import 'package:flutter/material.dart';

import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/size_extensions.dart';

class LabelFieldWidget extends StatelessWidget {
  final Key? textFieldKey;
  final String label;
  final String hintText;
  final bool isPasswordField;
  final IconData ic;
  final TextEditingController controller;

  const LabelFieldWidget({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.ic,
    this.isPasswordField = false,
    this.textFieldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(color: Colors.black),
              textAlign: TextAlign.start,
            ),
          ),
          TextField(
            key: textFieldKey,
            obscureText: isPasswordField,
            obscuringCharacter: '*',
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: Icon(ic, color: Colors.grey,),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all (Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.amber, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
