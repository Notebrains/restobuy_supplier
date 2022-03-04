import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';
import 'package:restobuy_supplier_flutter/common/constants/strings.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/ProfileApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/login/label_field_widget.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/drop_down_with_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/themes/theme_color.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/button.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_if_preview.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_input_field.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String dob = '';
  String gender = 'Male';
  bool isChangePassword = false;

  late File? xFile = File('');
  String base64Image = '' , userImage = '';

  late Future<bool> _future;
  late bool isApiDataAvailable = false;
  ProfileApiResModel model = ProfileApiResModel();
  DropListModel dropDownList = DropListModel([]);
  OptionItem optionItemSelected = OptionItem(id: '0', title: "Select gender");

  @override
  void initState() {
    super.initState();

    _future = getDataFromApi();
  }

  Future<bool> getDataFromApi() async {
    try{
      String? userId = await MySharedPreferences().getUserId()?? '';
      print('----userId : $userId');

      Map<String, dynamic> body = {};
      body["user_id"] = userId;

      await ApiFun.apiPostWithBody(ApiConstants.profile, body).then((jsonDecodeData) {
        model = ProfileApiResModel.fromJson(jsonDecodeData);
        nameController.text = model.response!.name ?? '';
        emailController.text = model.response!.email ?? '';
        phoneController.text = model.response!.mobile ?? '';
        cityController.text = model.response!.city ?? '';
        countryController.text = model.response!.country ?? '';
        gender = model.response!.gender ?? '';
        dob = model.response!.dob ?? '';
        if (model.response!.image == null || model.response!.image!.isEmpty) {
          userImage = Strings.imgUrlNotFoundYellowAvatar;
        } else {
          userImage = model.response!.image ?? '';
        }
      });

      if(model.status == 1) {
        isApiDataAvailable = true;
      }
    } catch(error){
      print("Error: $error");
    }
    return isApiDataAvailable;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(snapShot.hasData && snapShot.connectionState == ConnectionState.done){
            if(isApiDataAvailable){

              try {
                dropDownList = DropListModel([]);
                optionItemSelected = OptionItem(id: '0', title: gender.isEmpty ? "Select gender": gender);
                dropDownList.listOptionItems.add(OptionItem(id: '0', title: 'Male',),);
                dropDownList.listOptionItems.add(OptionItem(id: '0', title: 'Female',),);
              } catch (e) {
                if (kDebugMode) {
                  print(e);
                }
              }

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    InkWell(
                      onTap: (){
                        getImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 24),
                              child: setImage(xFile!.path),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /*Padding(
                      padding: EdgeInsets.only(top: Sizes.dimen_14.h, bottom: 12),
                      child: const Logo(height: 150,),
                    ),*/

                    TxtIf(
                      txt: 'Name',
                      initialTxtValue: nameController.text,
                      hint: nameController.text.isEmpty? 'Enter full name here': nameController.text,
                      icon: Icons.person,
                      isReadOnly: false,
                      textInputType: TextInputType.text,
                      onSaved: (String value) {
                        nameController.text = value;
                      },
                      leftPadding: 25,
                      rightPadding: 25,
                    ),
                    TxtIf(
                      txt: 'Email',
                      initialTxtValue: emailController.text,
                      hint: emailController.text.isEmpty? 'Enter email id here': emailController.text,
                      icon: Icons.email,
                      isReadOnly: true,
                      textInputType: TextInputType.emailAddress,

                      onSaved: (String value) {
                        emailController.text = value;
                      },
                      leftPadding: 25,
                      rightPadding: 25,
                    ),

                    TxtIf(
                      txt: 'Phone',
                      initialTxtValue: phoneController.text,
                      hint: phoneController.text.isEmpty ? 'Enter phone number here' : phoneController.text,
                      icon: Icons.call,
                      isReadOnly: false,
                      textInputType: TextInputType.phone,
                      onSaved: (String value) {
                        phoneController.text = value;
                      },
                      leftPadding: 25,
                      rightPadding: 25,

                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 24, 20.0,0),
                      child: DropDownWithModel(
                        ic: Icons.male_rounded,
                        icColor: Colors.black54,
                        itemSelected: optionItemSelected,
                        onOptionSelected: (OptionItem optionItem) {
                          //print('----restaurantId: ${optionItem.id}');
                          setState(() {
                            optionItemSelected.title = optionItem.title;
                            gender = optionItem.title;
                          });
                        },
                        dropListModel: dropDownList,
                      ),
                    ),

                    TxtIf(
                      txt: 'City',
                      initialTxtValue: cityController.text,
                      hint: cityController.text.isEmpty ? 'Enter city here' : cityController.text,
                      icon: Icons.location_city_rounded,
                      isReadOnly: false,
                      textInputType: TextInputType.text,
                      onSaved: (String value) {
                        cityController.text = value;
                      },
                      leftPadding: 25,
                      rightPadding: 25,
                    ),

                    /*TxtIf(
                        txt: 'State',
                        initialTxtValue: stateController.text,
                        hint: stateController.text.isEmpty ? 'Enter state here' : stateController.text,
                        icon: Icons.my_location_rounded,
                        isReadOnly: false,
                        textInputType: TextInputType.text,
                      ),*/

                    TxtIf(
                      txt: 'Country',
                      initialTxtValue: countryController.text,
                      hint: countryController.text.isEmpty ? 'Enter country here' : countryController.text,
                      icon: Icons.my_location_rounded,
                      isReadOnly: false,
                      textInputType: TextInputType.text,
                      onSaved: (String value) {
                        countryController.text = value;
                      },
                      leftPadding: 25,
                      rightPadding: 25,

                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 13, right: 10),
                      child: TxtIfPreview(txt: 'DOB', ifTxt: dob.isEmpty?'Enter date of birth here': dob, icon: Icons.date_range_rounded, onTap: (){
                        pickDate(context).then((pickedDate) => {
                          setState(() {
                            dob = pickedDate;
                          }),
                        });
                      }),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: CheckboxListTile(
                        activeColor: AppColor.appTxtAmber,
                        title: const Text("Change password", style: TextStyle(color: AppColor.appTxtAmber),),
                        value: isChangePassword,
                        onChanged: (newValue) {
                          setState(() {
                            isChangePassword = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),

                    Visibility(
                      visible: isChangePassword,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0,0),
                        child: LabelFieldWidget(
                          label: 'Old password',
                          hintText:  'Enter old password here',
                          controller: oldPasswordController,
                          isPasswordField: true,
                          ic: Icons.password_rounded,
                        ),
                      ),
                    ),

                    Visibility(
                      visible: isChangePassword,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0,0),
                        child: LabelFieldWidget(
                          label: 'New password',
                          hintText:  'Enter new password here',
                          controller: newPasswordController,
                          isPasswordField: true,
                          ic: Icons.password_rounded,
                        ),
                      ),
                    ),

                    Visibility(
                      visible: isChangePassword,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0,0),
                        child: LabelFieldWidget(
                          label: 'Confirm password',
                          hintText:  'Enter confirm password here',
                          controller: confirmPasswordController,
                          isPasswordField: true,
                          ic: Icons.password_rounded,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 24, 20.0, 0),
                      child: Button(
                        text: 'UPDATE',
                        onPressed: () {
                          /*if (nameController.text.isEmpty) {
                    edgeAlert(context, title: 'Warning', description: AppStrings.inputFieldRequired);
                  } else if (emailController.text.isEmpty) {
                    edgeAlert(context, title: 'Warning', description: AppStrings.inputFieldRequired);
                  } else if (phoneController.text.isEmpty) {
                    edgeAlert(context, title: 'Warning', description: AppStrings.inputFieldRequired);
                  } else if (genderController.text.isEmpty) {
                    edgeAlert(context, title: 'Warning', description: AppStrings.inputFieldRequired);
                  } else if (dob.isEmpty) {
                    edgeAlert(context, title: 'Warning', description: AppStrings.inputFieldRequired);
                  } else */

                          if (isChangePassword && oldPasswordController.text.isEmpty) {
                            edgeAlert(context, title: 'Warning', description: 'Enter old password');
                          } else if (isChangePassword && newPasswordController.text.isEmpty) {
                            edgeAlert(context, title: 'Warning', description: 'Enter new password');
                          } else if (isChangePassword && newPasswordController.text != confirmPasswordController.text) {
                            edgeAlert(context, title: 'Warning', description: 'Old password and new password did not matched');
                          } else {
                            doUpdate();
                          }
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: Button(
                        text: 'LOGOUT',
                        onPressed: () {
                          showIosDialog(
                              context,
                              'LOGOUT ?', "Are you sure you want to logout?",
                              'Cancel',
                              'Logout',
                                  (){
                                Navigator.of(context).pushReplacementNamed(RouteList.login);
                                MySharedPreferences().clearPreferenceData();
                              }
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            else { return NoDataFound(txt: 'User not found', onRefresh: (){});}
          } else {
            return const LottieLoading();
          }
        },
      ),

    );
  }

  Future getImage() async {
    try {
      final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        xFile = File(imageFile!.path);
        //print('Image Path $xFile');
      });
    } catch (e) {
      //print(e);
    }
  }

  setImage(String path) {
    try {
      if (path.isEmpty) {
        return cachedNetImgWithRadius(
          userImage,
            140, 140, 70, BoxFit.cover
        );
      } else {
        final bytes = File(path).readAsBytesSync();
        base64Image = base64Encode(bytes);
        //print('-----base64Image:  $base64Image');

        return CircleAvatar(
          radius: 70,
          backgroundColor : Colors.amber,
          child: ClipOval(
            child: SizedBox(
              width: 140.0,
              height: 140.0,
              child: Image.file(
                File(xFile!.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void doUpdate() async {
    if (kDebugMode) {
      print('---- Name, Image, DOB, gender: ${nameController.text}, $gender, $dob, $base64Image');
    }
    String? userId = await MySharedPreferences().getUserId();
    showLoadingDialog(context);

    Map<String, dynamic> data = {};
    data["user_id"] = userId;
    data["name"] = nameController.text;
    data["mobile"] = phoneController.text;
    data["dob"] = dob;
    data["image"] = base64Image;
    data["gender"] = gender;
    data["city"] = cityController.text;
    data["country"] = countryController.text;
    data["status"] = '1';
    data["password"] = newPasswordController.text;

    await ApiFun.apiPostWithBody(ApiConstants.updateProfile, data).then((jsonDecodeData){
      StatusMessageApiResModel model = StatusMessageApiResModel.fromJson(jsonDecodeData);
      edgeAlert(context, title: 'Message', description: model.message!);
      //MySharedPreferences().saveUserDetails(model);

      if (kDebugMode) {
        print('----Login Res : ${model.message}');
      }
    });
  }
}
