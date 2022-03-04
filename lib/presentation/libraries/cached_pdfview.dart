import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/appbar_ic_back.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/lottie_loading.dart';
import 'package:restobuy_supplier_flutter/presentation/widgets/no_data_found.dart';

class CachedPdfView extends StatelessWidget {
  final String pdfUrl;

  const CachedPdfView({
    Key? key,
    required this.pdfUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarIcBack(context, 'PDF'),
      backgroundColor: Colors.white,
      body: const PDF(
        fitPolicy : FitPolicy.BOTH,
      ).cachedFromUrl(
        pdfUrl,
        //placeholder: (progress) => Center(child: Text('$progress %')),
        placeholder: (progress) => const LottieLoading(),
        errorWidget: (error) => NoDataFound(txt: 'Unable to load pdf', onRefresh: (){}),
      )
    );
  }
}
