import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/constants/strings.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/button.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/drop_down_input.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_input_field.dart';

class RaiseInvoice extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, 'Raise Invoice'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 18),
              child: AppDropdownInput(
                hintText: "Select Restaurant",
                options: ["Choose Option", "Restaurant One", "Restaurant Two"],
                value: 'Choose Option',
                onChanged: (String? value) {
                  /*setState(() {
                    gender = value;
                    // state.didChange(newValue);
                  });*/
                },
                getLabel: (String value) => value,
              ),
            ),

            TxtIf(
              txt: 'Select PO',
              initialTxtValue: '',
              hint: '',
              icon: null,
              isReadOnly: false,
              textInputType: TextInputType.text,
              //validator: validator,
              //onSaved: onSaved,
            ),

            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 18),
              child: AppDropdownInput(
                hintText: "Select PO",
                options: ["Choose Option", "PO One", "PO Two"],
                value: 'Choose Option',
                onChanged: (String? value) {
                  /*setState(() {
                    gender = value;
                    // state.didChange(newValue);
                  });*/
                },
                getLabel: (String value) => value,
              ),
            ),


            TxtIf(
              txt: 'Invoice ID',
              initialTxtValue: '',
              hint: '',
              icon: null,
              isReadOnly: false,
              textInputType: TextInputType.text,
              //validator: validator,
              //onSaved: onSaved,
            ),

            TxtIf(
              txt: 'Date and Time',
              initialTxtValue: '',
              hint: '',
              icon: null,
              isReadOnly: false,
              textInputType: TextInputType.text,
              //validator: validator,
              //onSaved: onSaved,
            ),

            TxtIf(
              txt: 'Amount',
              initialTxtValue: '',
              hint: '',
              icon: null,
              isReadOnly: false,
              textInputType: TextInputType.text,
              //validator: validator,
              //onSaved: onSaved,
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 24, 20.0, 8),
              child: Button(text: 'Generate Invoice', onPressed: () {  },),
            ),
          ],
        ),
      ),
    );
  }
}