import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/common/constants/app_strings.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/LoginApiResModel.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import '../../../common/constants/route_constants.dart';
import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../widgets/button.dart';
import 'label_field_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController? _emailController, _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    //checkIfUserLogin();
  }

  @override
  void dispose() {
    _emailController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.dimen_32.w,
          vertical: Sizes.dimen_24.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LabelFieldWidget(
              label: 'Email Id',
              hintText: 'Enter email id here',
              controller: _emailController!,
              ic: Icons.email,

            ),
            LabelFieldWidget(
              label: 'Password',
              hintText:  'Enter password here',
              controller: _passwordController!,
              isPasswordField: true,
              ic: Icons.lock_rounded,
            ),


            Button(
              onPressed: (){
                if (_emailController!.text.isEmpty) {
                  edgeAlert(context, title: 'Warning', description: AppStrings.emailRequired);
                } else if (_passwordController!.text.isEmpty) {
                  edgeAlert(context, title: 'Warning', description: AppStrings.passwordRequired);
                } else {
                  doLogin();
                }
              },
              text: 'Login',
            ),
            Button(
              text: 'Forgot Password',
              onPressed: (){
                Navigator.of(context).pushNamed(RouteList.forgot_password,);
              },
            ),
          ],
        ),
      ),
    );
  }

  void checkIfUserLogin() async {
    try {
      String? userId = await MySharedPreferences().getUserId();
      if (kDebugMode) {
        print('----userId : $userId');
      }
      if (userId != '' && userId != null) {
        Navigator.of(context).pushNamedAndRemoveUntil(RouteList.home_screen,(route) => false,);
      }
    } catch (e) {
      print(e);
    }
  }

  void doLogin() async {
    showLoadingDialog(context);
    Map<String, dynamic> data = {};
    data["email"] = _emailController!.text;
    data["password"] = _passwordController!.text;

    await ApiFun.apiPostWithBody(ApiConstants.login, data).then((jsonDecodeData){
      LoginApiResModel model = LoginApiResModel.fromJson(jsonDecodeData);
      edgeAlert(context, title: 'Message', description: model.message??'');
      if (kDebugMode) {
        print('----Login Res : ${model.message}');
      }
      if (model.status == 1) {
        MySharedPreferences().saveUserId(model.response!.userId.toString());
        MySharedPreferences().saveUserDetails(model);

        Timer(const Duration(milliseconds: 2000), () {
          Navigator.pushNamed(context, RouteList.home_screen);
        });
      }
    });
  }
}
