import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/data/models/ProductDetailsApiResModel.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/cached_net_img_radius.dart';

final List<String> imgList = [];

class ImageSliderCarouselWithIndicator extends StatefulWidget {
  final ProductDetailsApiResModel model;

  const ImageSliderCarouselWithIndicator({Key? key, required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<ImageSliderCarouselWithIndicator> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();

    imgList.clear();
    for(int i =0; i<widget.model.response!.image!.length; i++){
      imgList.add(widget.model.response!.multipleImage![i].image?? '');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            CarouselSlider(
              items: imgList
                  .map((item) => cachedNetImgWithRadius(item, double.infinity, double.infinity, 0, BoxFit.cover),
              ).toList(),
              carouselController: _controller,
              options: CarouselOptions(
                  //aspectRatio: 3/2,
                  viewportFraction: 1,
                  initialPage: 0,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 6),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(_current == entry.key ? 1.0 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ),

      ]),
    );
  }
}
