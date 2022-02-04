import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:rxdart/subjects.dart';
import 'presentations/app.dart';
// import 'presentations/services/notification_service.dart';
// import 'presentations/ui/notification/view/local_notification_view.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
runApp(App());
}
Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
}
