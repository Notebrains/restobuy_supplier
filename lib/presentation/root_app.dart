import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restobuy_supplier_flutter/common/constants/route_constants.dart';
import 'package:restobuy_supplier_flutter/common/screenutil/screenutil.dart';

import 'fade_page_route_builder.dart';
import 'journeys/loading/loading_screen.dart';
import 'journeys/splash_screen/splash_screen.dart';
import 'routes.dart';
import 'themes/theme_color.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  late FirebaseMessaging messaging;
  late FlutterLocalNotificationsPlugin fltNotification;

  @override
  void initState() {
    super.initState();

    // firebase notification
    messaging = FirebaseMessaging.instance;

    // request permission for notification
    notificationPermission();

    initMessaging();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getToken() async {
    if (kDebugMode) {
      print(await messaging.getToken());
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil package is init to make the app responsive
    //ScreenUtil.init();

    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Splash(),
          );
        } else {
          ScreenUtil.init();
          // Loading is done, return the app:

          return MaterialApp(
            navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              unselectedWidgetColor: AppColor.secondaryColor,
              primaryColor: AppColor.white,
              //accentColor: AppColor.app_txt_white,
              scaffoldBackgroundColor: AppColor.app_bg,
            ),
            builder: (context, child) {
              var size = MediaQuery.of(context).size;
              ScreenUtil().setWidth(size.width);
              ScreenUtil().setHeight(size.height - MediaQuery.of(context).padding.top - 65);

              return LoadingScreen(
                screen: child!,
              );

            },
            initialRoute: RouteList.initial,
            onGenerateRoute: (RouteSettings settings) {
              final routes = Routes.getRoutes(settings);
              final WidgetBuilder? builder = routes[settings.name];
              return FadePageRouteBuilder(
                builder: builder!,
                settings: settings,
              );
            },
          );
        }
      },
    );
  }


  void initMessaging() async {
    var androidInit = const AndroidInitializationSettings('ic_notification');
    var iosInit = const IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androidInit, iOS: iosInit);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'restobuy_supplier_channel_id',
      'RestoBuy Supplier', // title
      description: 'This notification is from  RestoBuy Supplier', // description
      importance: Importance.max,
    );

    fltNotification = FlutterLocalNotificationsPlugin();
    await fltNotification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    fltNotification.initialize(initSetting);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');
      }

      //Show local notification when app in foreground and message is received.
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        if (kDebugMode) {
          print('Message also contained a notification: ${message.data}');
        }
        fltNotification.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
                // other properties...
              ),
              iOS: const IOSNotificationDetails(),
            ),
            payload: message.data['notification_data'] ?? '');

        fltNotification.initialize(initSetting, onSelectNotification: onSelectNotification);
      }
    });
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null && payload.isNotEmpty) {
      //print('----payload: $payload');

      //openPageWithData(payload);
    }
  }

  void notificationPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  void initUserInteractionOnNotification() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen

    //print('----Firebase notification data onClicked 1: ${initialMessage.data}');
    //print('----Firebase notification contentAvailable onClicked 1: ${initialMessage.contentAvailable}');

    if (initialMessage != null && initialMessage.data['notification_data'] != null) {
      //print('----Firebase notification data onClicked 1: ${initialMessage.data}');
      openPageWithData(initialMessage.data['notification_data']);
    } else {
      //Open Page
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //print('----Firebase notification data onClicked 2: ${message.data}');
      if (message.data['notification_data'] != null) {
        openPageWithData(message.data['notification_data']);
      } else {
        //Open Page
      }
    });
  }

  void openPageWithData(String payload) {
    try {
      // get data from payload and navigate to screen
      //var gameNotiData = json.decode(payload);
      //print('-----openPageWithData: $gameNotiData');
      /*
      output
      {gameType: test, friendName: Imdadul, gameCat4: 1991-2000, friendId: MEM000033, playerType: bowler, friendImage:
      https://lh3.googleusercontent.com/a-/AOh14GhhY4WoN2ln1gzcQE_QSQ3tOtyjWCk3oHEniCp4=s96-c, gameCat1: sports, gameCat2: cricket,
       gameCat3: IPL, cardsToPlay: 120}
       */

      //print('----- ${gameNotiData['gameCat1']}');
      //MyRootApp.navigatorKey.currentState.push(MaterialPageRoute(builder: (_) => HomeNavigation(),),);
    } catch (e) {
      print(e);
    }
  }
}