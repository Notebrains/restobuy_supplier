import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/constants/strings.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt_ic_row.dart';

class ProductDetails extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: Container(width: double.infinity, color: Colors.white,
                        child: cachedNetImage(Strings.imgUrlTestSupplyProduct)),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, left: 12),
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios_rounded, color: Colors.black, size: 20,),
                      backgroundColor: Colors.white,
                      tooltip: 'Pressed',
                      elevation: 1,
                      splashColor: Colors.grey,
                      mini: true,
                    ),
                  ),
                ),
                /*Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(right: 20.0, top: 40),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProductDetails()));
                        },
                        child: Stack(
                          children: <Widget>[
                            Icon(
                              Icons.notifications,
                              size: 30,
                            ),

                          ],
                        ),
                      )),
                ),*/
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(45.0),
                  topLeft: Radius.circular(45.0),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 24,
                  ),
                ],
              ),
              padding: EdgeInsets.only(left: 32, right: 24, top: 45),
              child: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category Name',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: Colors.amber),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        'Product Name',
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black87),
                      ),
                    ),

                    Text(
                      'Product Id',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal, fontSize: 18, color: Colors.black87),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        'Unit-4',
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal, fontSize: 18, color: Colors.black87),
                      ),
                    ),

                    Text(
                      'Cost: \$100.00',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 5),
                      child: Text(
                        'Quantity Available - 15 pcs',
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal, fontSize: 18, color: Colors.black87),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}