import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:pedantic/pedantic.dart';
import 'package:restobuy_supplier_flutter/common/screenutil/screenutil.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/home_screen/home_screen.dart';
import 'package:restobuy_supplier_flutter/presentation/journeys/login/login_screen.dart';
import 'package:restobuy_supplier_flutter/presentation/movie_app.dart';

import 'common/constants/route_constants.dart';
import 'data/tables/movie_table.dart';
import 'di/get_it.dart' as getIt;
import 'presentation/fade_page_route_builder.dart';
import 'presentation/journeys/home_screen/home_screen.dart';
import 'presentation/journeys/splash_screen/splash_screen.dart';
import 'presentation/routes.dart';
import 'presentation/themes/theme_color.dart';
import 'presentation/themes/theme_text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]));
  //final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  //Hive.init(appDocumentDir.path);
  //Hive.registerAdapter(MovieTableAdapter());
  unawaited(getIt.init());
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
              home: Splash(),
          );
        } else {
          ScreenUtil.init();
          // Loading is done, return the app:
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: RouteList.initial,
            onGenerateRoute: (RouteSettings settings) {
              final routes = Routes.getRoutes(settings);
              final WidgetBuilder? builder = routes[settings.name];
              return FadePageRouteBuilder(builder: builder!, settings: settings,
              );
            },

            theme: ThemeData(
              unselectedWidgetColor: AppColor.royalBlue,
              primaryColor: Colors.white,
              accentColor: AppColor.royalBlue,
              scaffoldBackgroundColor: Colors.white,
              brightness: Brightness.light,
              cardTheme: CardTheme(color: Colors.white,),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: ThemeText.getLightTextTheme(),
              appBarTheme: const AppBarTheme(elevation: 0),
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: Theme.of(context).textTheme.greySubtitle1,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            home: HomeScreen(),
          );
        }
      },
    );
  }
}

