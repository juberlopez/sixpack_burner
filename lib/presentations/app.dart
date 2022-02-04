import 'package:sixpackburner/device/repositories/device_repository.dart';
import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/ui/home/ajustes/cubit/ajustes_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/dietas/cubit/dieta_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/mi_progreso/cubit/mi_progreso_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/profile/cubit/profile_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/profile/view/profile_view.dart';
import 'package:sixpackburner/presentations/ui/home/recordatorio/view/recordatorio_view.dart';
import 'package:sixpackburner/presentations/ui/home/retos/cubit/retos_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/view/home_view.dart';
import 'package:sixpackburner/presentations/ui/login/view/login_view.dart';
import 'package:sixpackburner/presentations/ui/notification/view/notification_view.dart';
import 'package:sixpackburner/presentations/ui/poll/poll_cubit/poll_cubit.dart';
import 'package:sixpackburner/presentations/ui/poll/view/poll_antro_view.dart';
import 'package:sixpackburner/presentations/ui/poll/view/poll_horas_view.dart';
import 'package:sixpackburner/presentations/ui/poll/view/poll_info_view.dart';
import 'package:sixpackburner/presentations/ui/poll/view/poll_view.dart';
import 'package:sixpackburner/presentations/ui/scan_code/form_code_view.dart';
import 'package:sixpackburner/presentations/ui/welcome/view/welcome_view.dart';
import 'package:sixpackburner/presentations/ui/welcome/welcome_cubit/welcome_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';


import 'cubits/authentication_cubit/authentication_cubit.dart';
import 'ui/home/recetas/cubit/recetas_cubit.dart';
import 'ui/register/view/register_view.dart';
import 'ui/scan_code/scan_code_view.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();
String? selectedNotificationPayload;
/*const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');*/

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
final Future<FirebaseApp> _initialization = Firebase.initializeApp();
@override
Widget build(BuildContext context) {
return FutureBuilder(
// Initialize FlutterFire:
future: _initialization,
builder: (context, snapshot) {
  print("carga firebase"+ snapshot.connectionState.toString());
// Check for errors
if (snapshot.hasError) {
  return MaterialApp(
    home: Container(
      child: Text("Error"),
    ),
  );
}
// Once complete, show your application
if (snapshot.connectionState == ConnectionState.done) {
  //await _configureLocalTimeZone();

  NotificationAppLaunchDetails? notificationAppLaunchDetails;
  flutterLocalNotificationsPlugin
      .getNotificationAppLaunchDetails()
      .then((value) {
    notificationAppLaunchDetails = value;
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ??
        false) {
      selectedNotificationPayload =
          notificationAppLaunchDetails!.payload;
    }
  });

  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');


  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification: (
            int id,
            String? title,
            String? body,
            String? payload,
          ) async {
            didReceiveLocalNotificationSubject.add(
              ReceivedNotification(
                id: id,
                title: title,
                body: body,
                payload: payload,
              ),
            );
          });

  final InitializationSettings initializationSettings =
      InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: null,
  );
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    selectedNotificationPayload = payload;
    selectNotificationSubject.add(payload);
  }).then((value) => null);
  tz.initializeTimeZones();

  FlutterNativeTimezone.getLocalTimezone().then((value) {
    tz.setLocalLocation(tz.getLocation(value));
  });

  FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      )
      .then((value) => null);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging
      .requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      )
      .then((value) async {});

  FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      )
      .then((value) => null);

 /* FirebaseMessaging messaging = FirebaseMessaging.instance;
NotificationSettings settings = await messaging.requestPermission(
alert: true,
announcement: false,
badge: true,
carPlay: false,
criticalAlert: false,
provisional: false,
sound: true,
);
if (settings.authorizationStatus == AuthorizationStatus.authorized) {
print('User granted permission');
} else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
print('User granted provisional permission');
} else {
print('User declined or has not accepted permission');
}*/
  return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DeviceRepository>(
          create: (context) => DeviceRepository(),
        ),
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
        ),
        RepositoryProvider<RecipeRepository>(
          create: (context) => RecipeRepository(),
        ),
        RepositoryProvider<GeneralRepository>(
          create: (context) => GeneralRepository(),
        ),
        RepositoryProvider<DeviceRepository>(
          create: (context) => DeviceRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthenticationCubit(
                  RepositoryProvider.of<AuthenticationRepository>(
                      context),
                  RepositoryProvider.of<GeneralRepository>(context))),
          BlocProvider(create: (context) => WelcomeCubit()..init()),
          BlocProvider(
              create: (context) => PollCubit(
                  RepositoryProvider.of<GeneralRepository>(context),
                  RepositoryProvider.of<AuthenticationRepository>(
                      context))
                ..init()),
          BlocProvider(
              create: (context) => RecetasCubit(
                    RepositoryProvider.of<RecipeRepository>(context),
                  ) //..init()
              ),
          BlocProvider(
              create: (context) => RetosCubit(
                    RepositoryProvider.of<GeneralRepository>(context),
                  ) //..init()
              ),
          BlocProvider(
              create: (context) => AjustesCubit(
                    RepositoryProvider.of<GeneralRepository>(context),
                  ) //..init()
              ),
          BlocProvider(
            create: (BuildContext context) => MiProgresoCubit(
                RepositoryProvider.of<GeneralRepository>(context),
                RepositoryProvider.of<DeviceRepository>(context)),
          ),
          BlocProvider(
              create: (BuildContext context) => DietaCubit() //..init(),
              ),
          BlocProvider(
            create: (BuildContext context) => ProfileCubit(
                RepositoryProvider.of<GeneralRepository>(context),
                RepositoryProvider.of<DeviceRepository>(context)),
          ),

          /*BlocProvider(
        create: (context) => HomeCubit(
            )),*/
        ],
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'SegoeUI'),
          debugShowCheckedModeBanner: false,
          initialRoute: InitialApp.routeName,
          routes: {
            '/': (BuildContext contex) => InitialApp(),
            InitialApp.routeName: (BuildContext contex) => InitialApp(),
            RegisterView.routeName: (BuildContext contex) =>
                RegisterView(),
            LoginView.routeName: (BuildContext contex) => LoginView(),
            ScanCodeView.routeName: (BuildContext contex) =>
                ScanCodeView(),
            PollView.routeName: (BuildContext contex) => PollView(),
            PollAntroView.routeName: (BuildContext contex) =>
                PollAntroView(),
            PollHorasView.routeName: (BuildContext contex) =>
                PollHorasView(),
            HomeView.routeName: (BuildContext contex) => HomeView(),
            RecordatorioView.routeName: (BuildContext contex) =>
                RecordatorioView(),
            InfoView.routeName: (BuildContext contex) => InfoView(),
            FormCodeView.routeName: (BuildContext contex) =>
                FormCodeView(),
            ProfileView.routeName: (BuildContext contex) =>
                ProfileView(),
            WelcomeView.routeName: (BuildContext contex) =>
                WelcomeView(),
            NotificatioView.routeName: (BuildContext contex) =>
                NotificatioView(),
          },
        ),
      ));
}
// Otherwise, show something whilst waiting for initialization to complete
return MaterialApp(
home: Scaffold(
  backgroundColor: Colors.blueAccent,
body: SafeArea(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: <Widget>[
Center(
child: Container(
margin: EdgeInsets.only(bottom: 40),
child: new Image.asset(
'assets/images/logo_reto.png',
height: 160.0,
),
),
),
// Spacer(),
CircularProgressIndicator(
valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
),
],
),
),
),
);
},
);
}
}
