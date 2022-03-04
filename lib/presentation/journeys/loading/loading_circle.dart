import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';

class LoadingCircle extends StatelessWidget {
  final double size;

  const LoadingCircle({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: LottieLoading(),
    );
  }
}
