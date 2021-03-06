import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/button.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_ic_row.dart';

class Setting extends StatefulWidget{
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _isNotificationSwitchOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 22, right: 22, top: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Container(
              color: Colors.amber.withOpacity(0.1),
              margin: const EdgeInsets.only(top: 36, bottom: 18),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Txt(txt: _isNotificationSwitchOn? 'Notification On' : 'Notification Off',
                    txtColor: Colors.black,
                    txtSize: 16,
                    fontWeight: FontWeight.bold,
                    padding: 0,
                  ),

                  CustomSwitch(
                    value: _isNotificationSwitchOn,
                    onChanged: (bool val){
                      setState(() {
                        _isNotificationSwitchOn = val;
                      });
                    },
                  ),
                ],
              ),
            ),*/

            const Txt(txt: 'Contact Info',
              txtColor: Colors.black,
              txtSize: 18,
              fontWeight: FontWeight.bold,
              padding: 0,
            ),

            const TxtIcRow(txt: 'contact@restobuy.com', txtColor: Colors.black54,
                txtSize: 16, fontWeight: FontWeight.normal, icon: Icons.email, icColor: Colors.black54,
              isCenter: false,),

            const TxtIcRow(txt: '+1 993346792', txtColor: Colors.black54,
                txtSize: 16, fontWeight: FontWeight.normal, icon: Icons.call, icColor: Colors.black54,
              isCenter: false,
            ),

            Padding(
              padding: const EdgeInsets.only(top: 36),
              child: Button(text: 'Raise Dispute',
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