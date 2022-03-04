import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/constants/strings.dart';
import 'package:restobuy_supplier_flutter/common/extensions/common_fun.dart';
import 'package:restobuy_supplier_flutter/data/core/api_constants.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/api_functions.dart';
import 'package:restobuy_supplier_flutter/data/data_sources/local_data_source_shared_preferences.dart';
import 'package:restobuy_supplier_flutter/data/models/ReviewApiResModel.dart';
import 'package:restobuy_supplier_flutter/data/models/status_message_api_res_model.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/edge_alerts/edge_alerts.dart';
import 'package:restobuy_supplier_flutter/presentation/libraries/star_rating.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_if_preview.dart';

class Review extends StatefulWidget {
  static const String routeName = '/review';

  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {

  late Future<bool> _future;
  late bool isApiDataAvailable = false;
  ReviewApiResModel model = ReviewApiResModel();
  StatusMessageApiResModel statusMsgModel = StatusMessageApiResModel();


  @override
  void initState() {
    super.initState();

    //_future = getDataFromApi();
  }


  Future<bool> getDataFromApi() async {
    try{
      String? userId = await MySharedPreferences().getUserId();

      Map<String, dynamic> body = {};
      body["user_id"] = userId;

      await ApiFun.apiPostWithBody(ApiConstants.review, body).then((jsonDecodeData) => {
        model = ReviewApiResModel.fromJson(jsonDecodeData),
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
    _future = getDataFromApi();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: appBarIcBack(context, 'Reviews'),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapShot){
          if(snapShot.hasData){
            if(isApiDataAvailable && snapShot.connectionState == ConnectionState.done && model.response != null){
              return buildUi(model.response?? []);
            }
            else { return NoDataFound(txt: "Review or rating is not given yet", onRefresh: (va){

            });}
          } else {
            return const LottieLoading();
          }
        },
      ),
    );
  }

  Widget buildUi(List<Response> response) {
    return FadeInUpBig(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, top: 8),
        //color: Colors.white,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: response.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5, bottom: 3),
                          child: cachedNetImgWithRadius(response[index].productImage?? Strings.imgUrlNotFoundYellowAvatar, 50,
                              50, 3, BoxFit.cover),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(6, 5, 5, 0),
                              child: Text(
                                response[index].productName?? '',
                                style: const TextStyle( fontSize: 14, color: Colors.black87, letterSpacing: 0.5),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(5, 3, 8, 0),
                                  child: StarRating(
                                    rating: double.parse(response[index].rating.toString()),
                                    color: Colors.amber,
                                    iconSize: 20,
                                    onRatingChanged: (double rating) {  },
                                  ),
                                ),

                                Text(
                                  response[index].rating!.toString(),
                                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 12, left: 3),
                      child: Text(
                        response[index].review?? '',
                        style: const TextStyle( fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
                      ),
                    ),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          response[index].reviewBy!,
                          style: const TextStyle( fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black54),
                        ),

                        /*const Text(
                                '25 jan, 2021',
                                style: TextStyle( fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black54),
                              ),*/
                      ],
                    ),

                    /*InkWell(
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.only(top: 8, left: 4,),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent.withOpacity(0.1),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        alignment: Alignment.center,
                        child: const Txt(
                          txt: 'Delete',
                          txtColor: Colors.black,
                          txtSize: 14,
                          fontWeight: FontWeight.normal,
                          padding: 3,
                        ),
                      ),
                      onTap: () async {
                        deleteReview(response[index].reviewId.toString());
                      },
                    ),*/
                  ],
                ),
              );
            }),
      ),
    );
  }



  void deleteReview(String reviewId) async {
    try{
      showLoadingDialog(context);

      Map<String, dynamic> body = {};
      body["review_id"] = reviewId;

      await ApiFun.apiPostWithBody(ApiConstants.deleteReview, body).then((jsonDecodeData) => {
        statusMsgModel = StatusMessageApiResModel.fromJson(jsonDecodeData),
        edgeAlert(context, title: 'Message', description: statusMsgModel.message!),
      });

      if (statusMsgModel.status == 1) {
        setState(() {
          _future = getDataFromApi();
        });
      }
    } catch(error){
      print("Error: $error");
    }
  }
}
