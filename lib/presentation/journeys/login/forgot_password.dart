import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/button.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_if_ic_round.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordState();
  }
}

class _ForgotPasswordState extends State {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarIcBack(context, 'Forgot Password'),
      body: Form(
        key: _key,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideInUp(
                child: const Padding(
                  padding: EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 24),
                  child: Text(
                    "Enter your registered email address\nto get a new password",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black),
                  ),
                ),
                preferences: const AnimationPreferences(autoPlay: AnimationPlayStates.Forward, duration: Duration(milliseconds: 700)),
              ),

              SlideInUp(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: IfIconRound(
                    hint: "Email",
                    icon: Icons.email_outlined,
                    controller: _controller,
                    textInputType: TextInputType.emailAddress,
                  ),
                ),
                preferences: const AnimationPreferences(autoPlay: AnimationPlayStates.Forward, duration: Duration(milliseconds: 750)),
              ),

              SlideInUp(
                child: Padding(
                  padding: const EdgeInsets.only(left: 36, right: 36, top: 24),
                  child: Button(
                    text: "Send",
                    //bgColor: [const Color(0xFFEFE07D), const Color(0xFFB49839)],
                    onPressed: () {
                      if (_controller.text.isEmpty) {
                        edgeAlert(context, title: 'Warning', description: 'Please enter valid email number', gravity: Gravity.top);
                      } else {
                        doSubmit();
                      }
                    },
                  ),
                ),
                preferences: const AnimationPreferences(autoPlay: AnimationPlayStates.Forward, duration: Duration(milliseconds: 800)),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void doSubmit() async {
    try{
      showLoadingDialog(context);

      Map<String, dynamic> body = {};
      body['email'] = _controller.text;

      await ApiFun.apiPostWithBody(ApiConstants.forgotPassword, body).then((jsonDecodeData) {
        StatusMessageApiResModel statusMessageApiResModel = StatusMessageApiResModel.fromJson(jsonDecodeData);
        edgeAlert(context, title: 'Message', description: statusMessageApiResModel.message!);
      });

    } catch(error){
      print("Error: $error");
    }
  }
}
