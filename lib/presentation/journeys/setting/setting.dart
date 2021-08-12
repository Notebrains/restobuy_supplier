import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/button.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_ic_row.dart';

class Setting extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 22, right: 22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 36),
              child: Txt(txt: 'Contact Info',
                txtColor: Colors.black,
                txtSize: 18,
                fontWeight: FontWeight.bold,
                padding: 0,
                onTap: (){},
              ),
            ),

            TxtIcRow(txt: 'contact@restobuy.com', txtColor: Colors.black54,
                txtSize: 16, fontWeight: FontWeight.normal, icon: Icons.email, icColor: Colors.black54,
              isCenter: false,),

            TxtIcRow(txt: '+1 993346792', txtColor: Colors.black54,
                txtSize: 16, fontWeight: FontWeight.normal, icon: Icons.call, icColor: Colors.black54,
              isCenter: false,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 36),
              child: Button(text: 'RAISE DISPUTE',
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteList.raise_dispute);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}