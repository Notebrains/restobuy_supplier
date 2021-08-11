import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/purchase_order/purchase_order.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/purchase_order_details/purchase_order_details.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/requisitions/requisition.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/requisitions_details/requisation_details.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/review/review.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/transaction/transaction.dart';
import 'journeys/invoice_details/invoice_details.dart';
import 'journeys/invoice/invoice.dart';
import 'journeys/movie_detail/movie_detail_arguments.dart';

import '../common/constants/route_constants.dart';
import 'journeys/favorite/favorite_screen.dart';
import 'journeys/home/home_screen.dart';
import 'journeys/login/login_screen.dart';
import 'journeys/movie_detail/movie_detail_screen.dart';
import 'journeys/product/product.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => LoginScreen(),
        RouteList.home: (context) => HomeScreen(),
        RouteList.movieDetail: (context) => MovieDetailScreen(movieDetailArguments: setting.arguments as MovieDetailArguments,),
        RouteList.favorite: (context) => FavoriteScreen(),

        RouteList.home_screen: (context) => HomeScreen(),
        RouteList.product: (context) => Product(),
        RouteList.invoice: (context) => Invoice(),
        RouteList.invoice_details: (context) => InvoiceDetails(),
        RouteList.purchase_order: (context) => PurchaseOrder(),
        RouteList.purchase_order_details: (context) => PurchaseOrderDetails(),
        RouteList.transaction: (context) => Transaction(),
        RouteList.review: (context) => Review(),
        RouteList.requisitions: (context) => Requisition(),
        RouteList.requisitions_details: (context) => RequisitionDetails(),



      };
}
