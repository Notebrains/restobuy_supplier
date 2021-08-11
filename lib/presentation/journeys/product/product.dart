import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:restobuy_supplier_flutter/common/constants/strings.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_radius.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/search_bar.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/txt.dart';

class Product extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, 'Product'),
      body: Column(
        children: [
          SearchBar(),
          Expanded(
            child: SlideInUp(
              child: Container(
                margin: const EdgeInsets.all(16),
                child: GridView.count(
                  shrinkWrap: false,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 4.0,
                  physics: BouncingScrollPhysics(),
                  children: List.generate(20, (index) {
                    return InkWell(
                      child: Card(
                        elevation: 8,
                        color: Colors.white,
                        shadowColor: Colors.grey.withOpacity(0.2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            cachedNetImgWithRadius(
                                Strings.imgUrlTestSupplyProduct, 200, 130, 5),

                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Txt(
                                  txt: 'Product Title', txtColor: Colors.black, txtSize: 16, fontWeight: FontWeight.bold, padding: 0, onTap: () {}),
                            ),

                          ],
                        ),
                      ),
                      onTap: () {
                        //openPage(context, categoryList[index].category);
                      },
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}