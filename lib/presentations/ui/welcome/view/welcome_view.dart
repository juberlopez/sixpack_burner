import 'dart:io';

import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/app.dart';
import 'package:sixpackburner/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/view/home_view.dart';
import 'package:sixpackburner/presentations/ui/login/view/login_view.dart';
import 'package:sixpackburner/presentations/ui/notification/view/local_notification_view.dart';
import 'package:sixpackburner/presentations/ui/notification/view/notification_view.dart';
import 'package:sixpackburner/presentations/ui/poll/view/poll_view.dart';
import 'package:sixpackburner/presentations/ui/register/view/register_view.dart';
import 'package:sixpackburner/presentations/ui/scan_code/scan_code_view.dart';
import 'package:sixpackburner/presentations/ui/welcome/widgets/carrusel_welcome.dart';
import 'package:sixpackburner/presentations/ui/widgets/splash_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class InitialApp extends StatefulWidget {
  static final String routeName = 'initial_app';
  const InitialApp({Key? key}) : super(key: key);

  @override
  _InitialAppState createState() => _InitialAppState();
}

class _InitialAppState extends State<InitialApp> {
  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    Navigator.pushNamed(context, NotificatioView.routeName);
    /*if (message.data['type'] == 'chat') {
      Navigator.pushNamed(context, '/chat', 
        arguments: ChatArguments(message),
      );
    }*/
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AuthenticationCubit>(context).init();
    //setupInteractedMessage();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      print(message);
      if (message != null) {
        Navigator.pushNamed(context, NotificatioView.routeName,
            arguments: ChallengeModel(
                id: 1,
                image: message.data['image'],
                title: message.data['title'],
                fecha: message.data['fecha'],
                body: message.data['body'],
                data: message.data['description']));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message);
      /* const IOSNotificationDetails iOSPlatformChannelSpecifics =
          IOSNotificationDetails(subtitle: 'the subtitle');
      const MacOSNotificationDetails macOSPlatformChannelSpecifics =
          MacOSNotificationDetails(subtitle: 'the subtitle');
      const NotificationDetails platformChannelSpecifics = NotificationDetails(
          iOS: iOSPlatformChannelSpecifics,
          macOS: macOSPlatformChannelSpecifics);*/
      /*final String bigPicturePath = await _downloadAndSaveFile(
          'https://via.placeholder.com/600x200', 'bigPicture.jpg');
      final IOSNotificationDetails iOSPlatformChannelSpecifics =
          IOSNotificationDetails(attachments: <IOSNotificationAttachment>[
        IOSNotificationAttachment(bigPicturePath)
      ]);

      final NotificationDetails notificationDetails = NotificationDetails(
        iOS: iOSPlatformChannelSpecifics,
      );

      await flutterLocalNotificationsPlugin.periodicallyShow(
          0,
          'repeating title',
          'repeating body',
          RepeatInterval.everyMinute,
          notificationDetails);*/

      /*await flutterLocalNotificationsPlugin.show(
          0,
          'title of notification with a subtitle',
          'body of notification with a subtitle',
          platformChannelSpecifics,
          payload: 'item x');*/
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.pushNamed(context, NotificatioView.routeName,
          arguments: ChallengeModel(
              id: 1,
              image: message.data['image'],
              title: message.data['title'],
              fecha: message.data['fecha'],
              body: message.data['body'],
              data: message.data['description']));
    });

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      print(receivedNotification);
    });
    selectNotificationSubject.stream.listen((String? payload) async {
      //RecipeModel recipeModel = RecipeModel.fromRawJson(payload.toString());

      print(payload);
      //await Navigator.pushNamed(context, LocalNotificationsView.routeName,arguments: RecipeModel ());
    });
  }

   Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          // print("ingresa a la app..."+state.status.toString());
            if (state.status == StatusAuthentication.hay_token) {
          } else if (state.status == StatusAuthentication.scan_code) {
            //context.read<NutritionalPlanCubit>().init();
            Navigator.pushNamed(context, ScanCodeView.routeName);
          } else if (state.status == StatusAuthentication.autenticado) {
            //Navigator.pushNamed(context, ScanCodeView.routeName);
            Navigator.pushNamedAndRemoveUntil(context, HomeView.routeName, (r) => false);
            //context.read<NutritionalPlanCubit>().init();
            //Navigator.pushNamed(context, HomeView.routeName);
          } else if (state.status == StatusAuthentication.authenticated_without_qr_code_not_activated) {
            Navigator.pushNamed(context, ScanCodeView.routeName);
            //context.read<NutritionalPlanCubit>().init();
            //Navigator.pushNamed(context, HomeView.routeName);
          } else if (state.status == StatusAuthentication.no_autenticado) {
            Navigator.pushNamed(context, LoginView.routeName);
          } else if (state.status == StatusAuthentication.logout) {
               Navigator.pushNamed(context, WelcomeView.routeName);
          } else if (state.status == StatusAuthentication.poll) {
            Navigator.pushNamed(context, PollView.routeName);
          }
        },
        child: SplashPage(),
        );
  }
}

class WelcomeView extends StatefulWidget {
  static final String routeName = 'welcome_View';
  const WelcomeView({Key? key}) : super(key: key);

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/video/video.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);

        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state.status == StatusAuthentication.hay_token) {
          //context.read<NutritionalPlanCubit>().init();
          context.read<AuthenticationCubit>().signInwithToken();
        } else if (state.status == StatusAuthentication.autenticado) {
          //context.read<NutritionalPlanCubit>().init();
          _controller.pause();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            videoBackground(),
            SizedBox.expand(
              child: Container(
                height: data.size.height,
                width: data.size.width,
                color: Colors.black.withOpacity(0.3),
                child: Column(
                  children: [
                    SizedBox(
                      height: data.size.height * 0.1,
                    ),
                    Image.asset(
                      'assets/images/logo_reto.png',
                      width: 250,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: data.size.height * 0.38),
              child: CarouselAdvertisingBanner(),
            ),
            Padding(
              padding: EdgeInsets.only(top: data.size.height - 100),
              child: Container(
                height: 74,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(stops: [
                    0.0,
                    0.8,
                  ], colors: [
                    Color(0xFF00AAFF),
                    Color(0xFF2849F0)
                  ]),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterView.routeName);
                                  //  Navigator.pushNamedAndRemoveUntil(context, RegisterView.routeName, (r) => false);
                              _controller.pause();
                            },
                            child: Text(
                              "¡UNIRME YA!",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ))),
                    Container(
                      height: 60,
                      width: 1,
                      color: Colors.white,
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginView.routeName);
                                    //  Navigator.pushNamedAndRemoveUntil(context,  LoginView.routeName, (r) => false);
                              _controller.pause();
                            },
                            child: Text("INICIAR SESION",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16))))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox videoBackground() {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.fill,
        child: SizedBox(
          width: _controller.value.size.width,
          height: _controller.value.size.height,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }
}
