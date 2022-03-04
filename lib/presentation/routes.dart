import 'package:flutter/material.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/raise_disput/raise_dispute.dart';
import 'journeys/dispute/dispute.dart';
import 'journeys/login/forgot_password.dart';
import 'journeys/notification/notifications.dart';
import 'journeys/product_details/product_details.dart';
import 'journeys/profile/profile.dart';
import 'journeys/purchase_order/purchase_order.dart';
import 'journeys/invoice/raise_invoice.dart';
import 'journeys/requisitions/requisition.dart';
import 'journeys/review/review.dart';
import 'journeys/setting/setting.dart';
import 'journeys/transaction/transaction.dart';
import 'journeys/home_screen/home_screen.dart';
import 'journeys/invoice/invoice.dart';

import '../common/constants/route_constants.dart';
import 'journeys/login/login_screen.dart';
import 'journeys/product/product.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => const LoginScreen(),
        RouteList.login: (context) => const LoginScreen(),

        RouteList.forgot_password: (context) =>  const ForgotPassword(),
        RouteList.home_screen: (context) => const HomeScreen(),
        RouteList.product: (context) => const Product(),
        RouteList.product_details: (context) => const ProductDetails(),
        RouteList.invoice: (context) => const Invoice(),
        //RouteList.invoice_details: (context) => InvoiceDetails(),
        //RouteList.invoice_raise: (context) => RaiseInvoice(),
        RouteList.dispute: (context) => const Dispute(),
        RouteList.raise_dispute: (context) => const RaiseDispute(),
        RouteList.purchase_order: (context) => const PurchaseOrder(),
        //RouteList.purchase_order_details: (context) => PurchaseOrderDetails(),
        RouteList.transaction: (context) => const Transaction(),
        RouteList.review: (context) => const Review(),
        RouteList.requisitions: (context) => const Requisition(),
        //RouteList.requisitions_details: (context) => RequisitionDetails(),
        RouteList.profile: (context) => const Profile(),
        RouteList.setting: (context) => Setting(),
        RouteList.notification: (context) => const Notifications(),
      };
}
