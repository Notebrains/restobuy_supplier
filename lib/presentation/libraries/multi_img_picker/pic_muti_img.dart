import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restobuy_supplier_flutter/data/models/MultiImgModel.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/button.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';

import 'flutter_absolute_path.dart';
import 'modal_progress_hud.dart';


class PicMultipleImage extends StatefulWidget {
  final Function(List<MultiImgModel> imgList, List<Asset> imgAssetList) getImgList;

  const PicMultipleImage({Key? key, required this.getImgList}) : super(key: key);


  @override
  _PicMultipleImageState createState() => _PicMultipleImageState();
}

class _PicMultipleImageState extends State<PicMultipleImage> {

  List<Asset> imagesList = <Asset>[];
  List<MultiImgModel> base64ImgPathList = [];
  String _error = 'No Error Detected';

  bool showSpinner = false  ;

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(imagesList.length, (index) {
        Asset asset = imagesList[index];

        /*print('---- asset 1: ${asset}');
        print('---- asset 1: ${asset.getByteData()}');
        print('---- asset 2: ${asset.name}');*/
        //print('---- asset 2: ${asset.identifier}'); // full path

        getImageFileFromAssets(imagesList[index]).then((file) {
          final bytes = File(file.path).readAsBytesSync();
          String base64Image = base64Encode(bytes);
          //print('---- base64Image: $base64Image');
          base64ImgPathList.add(MultiImgModel(base64Image));
        });

        //print('---- base64ImgPathList.length: ${base64ImgPathList.length}');

        return InkWell(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                AssetThumb(
                  asset: asset,
                  width: 300,
                  height: 300,
                  spinner : const Center(child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator(color: Colors.orange,))),
                ),

                const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.cancel,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            setState(() {
              imagesList.removeAt(index);
            });
          },
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: imagesList,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          //actionBarColor: "#FF9B0BFF",
          actionBarTitle: "RestoBuy",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      imagesList = resultList;
      _error = error;
    });
  }

  /*Future uploadImageToServer(BuildContext context) async {

    try{
      setState(() {
        showSpinner = true ;
      });

      var uri = Uri.parse('http://18.224.86.8:4000/api/v1/posts/add');
      http.MultipartRequest request = http.MultipartRequest('POST', uri);

      request.fields['userid'] = '1';
      request.fields['food_name'] = 'piza';
      request.fields['category'] = 'piza';
      request.fields['serving_no'] = '3';
      request.fields['post_type'] = 'Global';
      request.fields['cooking_date'] = '2020-12-09';
      request.fields['exchange_for'] = 'yes';
      request.fields['spice_level'] = '2';
      request.fields['private_address'] ='yes';
      request.fields['address'] = 'nothing';
      request.fields['city'] = 'Peshawar';
      request.fields['state'] = 'KP';
      request.fields['zipcode'] = '2500';
      request.fields['allergies'] = 'No';
      request.fields['diet_specific'] = 'egg';
      request.fields['include_ingredients'] = 'egg, butter';
      request.fields['exclude_ingredients'] = 'egg butter';
      request.fields['details'] = 'nothing';

      List<http.MultipartFile> newList = [];

      for (int i = 0; i < imagesList.length; i++) {
        var path = await FlutterAbsolutePath.getAbsolutePath(imagesList[i].identifier??'');
        File imageFile =  File(path);

        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();

        var multipartFile = http.MultipartFile("pictures", stream, length,
            filename: basename(imageFile.path));
        newList.add(multipartFile);
      }



      request.files.addAll(newList);
      var response = await request.send();
      print(response.toString()) ;

      response.stream.transform(utf8.decoder).listen((value) {
        print('value') ;
        print(value);
      });

      if (response.statusCode == 200) {
        setState(() {
          showSpinner = false ;
        });

        print('uploaded');


      } else {
        setState(() {
          showSpinner = false ;
        });
        print('failed');

      }

    } catch(e){
      setState(() {
        showSpinner = false ;
      });
      print(e.toString()) ;

    }


  }*/


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      offset: const Offset(0, 0),
      child: Scaffold(
        appBar: appBarIcBack(context,''),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 32, top: 55),
              child: Lottie.asset('assets/animations/lottiefiles/pick_image.json', width: imagesList.isEmpty ? 350 : 150,),
            ),
            //const Txt(txt: 'Pick &', txtColor: Colors.black54, txtSize: 24, fontWeight: FontWeight.bold, padding: 0),

            const Txt(txt: 'Pick image', txtColor: Colors.black54, txtSize: 36, fontWeight: FontWeight.bold, padding: 3),

            //Center(child: Text('Error: $_error')),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Button(
                text: imagesList.isEmpty ? 'Continue' : 'Pick Again',
                onPressed: loadAssets,),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: buildGridView(),
              ),
            ),

            Visibility(
              visible: imagesList.isEmpty ? false : true,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Button(
                  text: 'Continue',
                  onPressed: () async {
                    widget.getImgList(base64ImgPathList, imagesList);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }

  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
    File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );
    return file;
  }
}