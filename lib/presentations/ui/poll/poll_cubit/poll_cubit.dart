import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sixpackburner/data/data.dart';
import 'package:sixpackburner/device/repositories/persistent_device.dart';
import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/app.dart';
import 'package:sixpackburner/presentations/constant/constant.dart';
import 'package:sixpackburner/presentations/services/antro_service.dart';
import 'package:sixpackburner/presentations/services/screen_messages_service.dart';
import 'package:equatable/equatable.dart';
import "package:collection/collection.dart";
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
part 'poll_state.dart';

class PollCubit extends Cubit<PollState> {
PollCubit(this._generalRepository,this._authenticationRepository)
: super(PollState(body: BodyModel(), muneca: MunecaModel()));

final GeneralRepository _generalRepository;
final AuthenticationRepository _authenticationRepository;

Future<void> init() async {}

Future newAge(
String edad,
) async {
emit(state.copyWith(edad: edad.toString()));
}

Future genero(
String genero,
) async {
emit(state.copyWith(genero: genero.toString()));
}

Future altura(
String altura,
) async {
emit(state.copyWith(altura: altura.toString()));
}

Future peso(
String peso,
) async {
emit(state.copyWith(peso: peso.toString()));
}

Future nivelActividadFisica(
String nivel,
) async {
emit(state.copyWith(nivelActividadFisica: nivel.toString()));
}

Future tiempoEntreno(
String tiempo,
) async {
emit(state.copyWith(tiempoEntreno: tiempo.toString()));
}

Future vegetariano(
String vegetariano,
) async {
emit(state.copyWith(vegetariano: vegetariano.toString()));
}

bool nextOne() {
if (state.altura.isEmpty ||
state.edad.isEmpty ||
state.peso.isEmpty ||
state.genero.isEmpty ||
state.nivelActividadFisica.isEmpty ||
state.vegetariano.isEmpty) {
ScreenMessagesService()
.toast("Por favor ingresa los datos para continuar");
return false;
} else {
return true;
}
}

bool nextTwo() {
if (state.idCardBody == "0" || state.idCardMuneca == "0") {
ScreenMessagesService()
.toast("Por favor ingresa los datos para continuar");
return false;
} else {
return true;
}
}

bool nextTree() {
if (state.horaAlmuerzo.isEmpty ||
state.horaDespierta.isEmpty ||
state.horaDesayuno.isEmpty ||
state.horaCena.isEmpty) {
ScreenMessagesService()
.toast("Por favor ingresa los datos para continuar");
return false;
} else {
return true;
}
}

bool nextFinish() {
if (true) {
ScreenMessagesService()
.toast("Por favor ingresa los datos para continuar");
return false;
} else {
return true;
}
}

List<BodyModel> getBodys() {
return state.genero == "FEMENINO"
? [
BodyModel(
enable: false,
id: "1",
image:
'https://retoburnerstack.megaplexstars.com/images/mujeres/10_.jpg',
porcent: 10),
BodyModel(
enable: false,
id: "2",
image:
'https://retoburnerstack.megaplexstars.com/images/mujeres/15.jpg',
porcent: 15),
BodyModel(
enable: false,
id: "3",
image:
'https://retoburnerstack.megaplexstars.com/images/mujeres/20.jpg',
porcent: 20),
BodyModel(
enable: false,
id: "4",
image:
'https://retoburnerstack.megaplexstars.com/images/mujeres/25.jpg',
porcent: 25),
BodyModel(
enable: false,
id: "5",
image:
'https://retoburnerstack.megaplexstars.com/images/mujeres/30.jpg',
porcent: 30),
BodyModel(
enable: false,
id: "6",
image:
'https://retoburnerstack.megaplexstars.com/images/mujeres/35.jpg',
porcent: 35),
BodyModel(
enable: false,
id: "7",
image:
'https://retoburnerstack.megaplexstars.com/images/mujeres/40.jpg',
porcent: 40),
BodyModel(
enable: false,
id: "8",
image:
'https://retoburnerstack.megaplexstars.com/images/mujeres/45.jpg',
porcent: 45)
]
: [
BodyModel(
enable: false,
id: "1",
image:
'https://retoburnerstack.megaplexstars.com/images/hombres/8.jpg',
porcent: 8),
BodyModel(
enable: false,
id: "2",
image:
'https://retoburnerstack.megaplexstars.com/images/hombres/12.jpg',
porcent: 12),
BodyModel(
enable: false,
id: "3",
image:
'https://retoburnerstack.megaplexstars.com/images/hombres/15.jpg',
porcent: 15),
BodyModel(
enable: false,
id: "4",
image:
'https://retoburnerstack.megaplexstars.com/images/hombres/20.jpg',
porcent: 20),
BodyModel(
enable: false,
id: "5",
image:
'https://retoburnerstack.megaplexstars.com/images/hombres/25.jpg',
porcent: 25),
BodyModel(
enable: false,
id: "6",
image:
'https://retoburnerstack.megaplexstars.com/images/hombres/30.jpg',
porcent: 30),
BodyModel(
enable: false,
id: "7",
image:
'https://retoburnerstack.megaplexstars.com/images/hombres/35.jpg',
porcent: 35),
BodyModel(
enable: false,
id: "8",
image:
'https://retoburnerstack.megaplexstars.com/images/hombres/40.jpg',
porcent: 40)
];
}

List<MunecaModel> getMunecas() {
return [
MunecaModel(
id: "1",
image: "assets/images/muneca1.png",
enable: false,
msg: "Delgada: Si los dedos se montan uno encima del otro.",
pesoOseo: 8.5),
MunecaModel(
id: "2",
image: "assets/images/muneca2.png",
enable: false,
msg: "Normal: Si los dedos se tocan",
pesoOseo: 9.5),
MunecaModel(
id: "3",
image: "assets/images/muneca3.png",
enable: false,
msg: "Robusta: Si los dedos no llegan a tocarse.",
pesoOseo: 11),
];
}

void cardBodySelect(BodyModel body) {
emit(state.copyWith(body: body, idCardBody: body.id));
}

void cardMunecaSelect(MunecaModel muneca) {
emit(state.copyWith(muneca: muneca, idCardMuneca: muneca.id));
}

Future horaDespertar(
String hora,
) async {
emit(state.copyWith(horaDespierta: hora));
}

Future horaEntrenar(
String hora,
) async {
emit(state.copyWith(horaEntrena: hora));
}

Future horaDesayunar(
String hora,
) async {
emit(state.copyWith(horaDesayuno: hora));
}

Future horaAlmuerzo(
String hora,
) async {
emit(state.copyWith(horaAlmuerzo: hora));
}

Future horaCena(
String hora,
) async {
emit(state.copyWith(horaCena: hora));
}
Future noEntrena() async {  emit(state.copyWith(producto: "NINGUNO")); }
void next()=> _save();
Future producto(
String producto,
) async {
emit(state.copyWith(producto: producto));

_save();
}

Future<void> _save() async {
emit(state.copyWith(status: StatusPoll.loading));

String? dataUser = await PersitentDevice().getUser();
UserPlusModel user = UserPlusModel.fromRawJson(dataUser!);
DatosAntroModel datosAntroModel = AntroService().getAntro(
genero: state.genero,
peso: double.parse(state.peso),
porcentajeGrasa: state.body.porcent!.toDouble(),
pesoOseo: state.muneca.pesoOseo!.toDouble());

ImcModel imcModel = AntroService().getImc(
peso: state.edad,
estatura: state.altura,
porcentajeGrasa: state.body.porcent!.toDouble());

double grtTMB = AntroService().grtTMB(
genero: state.genero,
peso: state.peso,
estatura: state.altura,
edad: state.edad);

ReportModel reportModel = ReportModel(
usuario: UsuarioModel(idUsuario: user.id, nombres: user.usuario),
genero: state.genero,
objetivo: AppConstant.OBJETIVO_QUEMARGRASA,
vegetariano:
state.vegetariano == AppConstant.VEGETARIANO_SI ? true : false,
nutricionista: NutricionistaModel(
idUsuario: 6394880,
nombres: "STEVEN REALPE",
rol: AppConstant.ROL_ADMIN),
datosAntro: DatosAntroModel(
edad: state.edad,
estatura: int.parse(state.altura),
peso: state.peso,
frecuenciaEntreno: state.nivelActividadFisica,
porcentajeGrasa: state.body.porcent,
pesoOseo: state.muneca.pesoOseo,
pesoResidual: datosAntroModel.pesoResidual,
porcentajeResidual: datosAntroModel.pesoResidual,
pesoGrasa: datosAntroModel.pesoGrasa,
pesoMuscle: datosAntroModel.pesoMuscle,
porcentajeOseo: datosAntroModel.porcentajeOseo,
porcentajeMuscle: datosAntroModel.porcentajeMuscle,
imc: imcModel.imc.toDouble()),
panel: PanelModel(
horaEntreno: state.horaEntrena,
horaLevantarse: state.horaDespierta,
horaDesayuno: state.horaDesayuno,
horaAlmuerzo: state.horaAlmuerzo,
horaCena: state.horaCena,
horaDormir: "22:00",
minutosEntreno: AppConstant.TIEMPO_ENTRENO[state.tiempoEntreno] ?? 0
),
antro: AntroModel(
aumento:
AntroService().frecuencyTraining(state.nivelActividadFisica),
kgmuscle: datosAntroModel.pesoMuscle,
calorias: grtTMB.toInt()),
producto: state.producto == AppConstant.PRODUCTO_NINGUNO
? AppConstant.PRODUCTO_BIPRO
: state.producto,
batido: state.producto == AppConstant.PRODUCTO_NINGUNO ? false : true);

final respuesta = await _generalRepository.addDieta(reportModel);

respuesta.fold((e) {
emit(state.copyWith(status: StatusPoll.initial));
ScreenMessagesService().toast(e.message.toString());
}, (response) async {

FirebaseMessaging.instance.subscribeToTopic('burnersixpack').then((value) {
print("Subscrito a burnersixpack");
})
.catchError((onError){
print(onError);
});

await Firebase.initializeApp();
String? token= await FirebaseMessaging.instance.getToken();
print("token generado:"+ token.toString());
_authenticationRepository.updateToken(token.toString()).then((value) => null);


Info info = response.data;
emit(state.copyWith(
status: StatusPoll.finish,
totalCalorias: info.caloriasDieta,
totalCarbohidratos: info.chos,
totalGrasas: info.grasa,
totalProteinas: info.proteina));
});
}


Future<void> initNotificationTest(bool notificacion) async {

if (notificacion) {
await flutterLocalNotificationsPlugin.cancelAll();
var comidas = {
'AL DESPERTARSE':
"https://retoburnerstack.megaplexstars.com/images/comidas/despertar.jpg",
"DESAYUNO":
"https://retoburnerstack.megaplexstars.com/images/comidas/desayuno.jpg",
'MEDIA MAÑANA':
'https://retoburnerstack.megaplexstars.com/images/comidas/mediodia.jpg',
"ALMUERZO":
'https://retoburnerstack.megaplexstars.com/images/comidas/almuerzo.jpg',
'MEDIA TARDE':
'https://retoburnerstack.megaplexstars.com/images/comidas/mediatarde.jpg',
"MERIENDA":
'https://retoburnerstack.megaplexstars.com/images/comidas/comidas_media.jpg',
"CENA":
'https://retoburnerstack.megaplexstars.com/images/comidas/cena.jpg',
"POST ENTRENO":
'https://retoburnerstack.megaplexstars.com/images/comidas/cena.jpg',
};

var comidas_drawable = {
'AL DESPERTARSE':
"despertar",
"DESAYUNO":
"desayuno",
'MEDIA MAÑANA':
'comidas_media',
"ALMUERZO":
'almuerzo',
'MEDIA TARDE':
'mediatarde',
"MERIENDA":
'mediodia',
"CENA":
'cena',
};

String? data = await PersitentDevice().getDietas();
JsonDietasModel jsonDietasModel = JsonDietasModel.fromRawJson(data!);
Map<String?, List<AlimentoModel>>? comidasPlus = jsonDietasModel
.dietas![0].alimentos!
.map((e) => e)
.groupListsBy((element) => element.comida);
comidasPlus.forEach((key, value) async {
if(key.toString()!="POST ENTRENO" || key.toString()!="PRE ENTRENO" || key.toString()!="DURANTE ENTRENO"){
String img = comidas[key.toString()] as String;
String imgAndroid = comidas_drawable[key.toString()] as String;
// print("comidas ${value[0].cantidad.toString()}: ${value[0].alimento.toString()}");
final String bigPicturePath = await _downloadAndSaveFile(img, key.toString() + '.jpg');
final IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(attachments: <IOSNotificationAttachment>[
IOSNotificationAttachment(bigPicturePath)
]);
String body = "";
double proteina=0;
double chos=0;
double grasa=0; 
double calorias=0;
value.forEach((food) { 
var cantidad = "";
proteina += food.proteina!;
chos = chos+ food.chos!;
grasa = grasa + food.grasa!;
calorias =calorias+ food.calorias!;
if (food.cantidad == 0.5) {
cantidad = "1/2";
} else if (food.cantidad == 0) {
cantidad = "-";
} else {
cantidad = food.cantidad!.toInt().toString();
}
 body +=  cantidad + " " + food.alimento.toString()+" ";
});
print("Comida: ${key.toString()}: Alimentos: ${body} -Proteína: ${proteina.toInt()}, Chos:${chos.toInt()}, Grasa: ${grasa.toInt()},  Calorías: ${calorias.toInt()}");
int id = value[0].hora! ~/ 10000;
final androidPlatformChannelSpecifics = AndroidNotificationDetails(
'${value[0].cantidad.toString()}1',
'${value[0].cantidad.toString()}',
'Recordatorio de comida',
styleInformation: BigPictureStyleInformation(
DrawableResourceAndroidBitmap(imgAndroid),
largeIcon: DrawableResourceAndroidBitmap("notification"),
contentTitle: key.toString(),
summaryText: 'Aporte nutricional: Proteína: ${proteina.toInt()}gr, Chos:${chos.toInt()}gr, Grasa: ${grasa.toInt()}gr,  Calorías: ${calorias.toInt()}cal' ,
),
importance: Importance.max,
sound: RawResourceAndroidNotificationSound('alert') ,
ledColor: Colors.blueAccent,
ledOffMs: 1000,
ledOnMs: 1000,
enableLights: true,
);
final NotificationDetails notificationDetails = NotificationDetails(  iOS: iOSPlatformChannelSpecifics, android: androidPlatformChannelSpecifics );
flutterLocalNotificationsPlugin.zonedSchedule(
id,
key.toString(),
body,
_nextInstanceOfTenAM(value[0].hora!),
notificationDetails,
androidAllowWhileIdle: true,
uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
matchDateTimeComponents: DateTimeComponents.time,
).then((value) => print("programado... ${key.toString()}"));
}
});
} else await flutterLocalNotificationsPlugin.cancelAll();

PersitentDevice().setNotificacion(notificacion);
emit(state.copyWith(notification: notificacion));
}

Future<void> initNotification(bool notificacion) async {
if (notificacion) {
await flutterLocalNotificationsPlugin.cancelAll();
var comidas = {
'AL DESPERTARSE':
"https://retoburnerstack.megaplexstars.com/images/comidas/despertar.jpg",
"DESAYUNO":
"https://retoburnerstack.megaplexstars.com/images/comidas/desayuno.jpg",
'MEDIA MAÑANA':
'https://retoburnerstack.megaplexstars.com/images/comidas/mediodia.jpg',
"ALMUERZO":
'https://retoburnerstack.megaplexstars.com/images/comidas/almuerzo.jpg',
'MEDIA TARDE':
'https://retoburnerstack.megaplexstars.com/images/comidas/mediatarde.jpg',
"MERIENDA":
'https://retoburnerstack.megaplexstars.com/images/comidas/comidas_media.jpg',
"CENA":
'https://retoburnerstack.megaplexstars.com/images/comidas/cena.jpg',
"POST ENTRENO":
'https://retoburnerstack.megaplexstars.com/images/comidas/cena.jpg',
};
String? data = await PersitentDevice().getDietas();
JsonDietasModel jsonDietasModel = JsonDietasModel.fromRawJson(data!);

Map<String?, List<AlimentoModel>>? comidasPlus = jsonDietasModel
.dietas![0].alimentos!
.map((e) => e)
.groupListsBy((element) => element.comida);

/*await flutterLocalNotificationsPlugin.periodicallyShow(
0,
'repeating title',
'repeating body',
RepeatInterval.everyMinute,
notificationDetails);*/

comidasPlus.forEach((key, value) async {
String img = comidas[key.toString()] as String;

final String bigPicturePath =
await _downloadAndSaveFile(img, key.toString() + '.jpg');
final IOSNotificationDetails iOSPlatformChannelSpecifics =
IOSNotificationDetails(attachments: <IOSNotificationAttachment>[
IOSNotificationAttachment(bigPicturePath)
]);

final NotificationDetails notificationDetails = NotificationDetails(
iOS: iOSPlatformChannelSpecifics,
);

String body =
value[0].cantidad.toString() + " " + value[0].alimento.toString();
int id = value[0].hora! ~/ 10000;

flutterLocalNotificationsPlugin
.zonedSchedule(
id,
key.toString(),
body,
_nextInstanceOfTenAM(value[0].hora!),
notificationDetails,
androidAllowWhileIdle: true,
uiLocalNotificationDateInterpretation:
UILocalNotificationDateInterpretation.absoluteTime,
matchDateTimeComponents: DateTimeComponents.time,
)
.then((value) => null);
});
} else {
await flutterLocalNotificationsPlugin.cancelAll();
}

PersitentDevice().setNotificacion(notificacion);
emit(state.copyWith(notification: notificacion));
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
final Directory directory = await getApplicationDocumentsDirectory();
final String filePath = '${directory.path}/$fileName';
final http.Response response = await http.get(Uri.parse(url));
final File file = File(filePath);
await file.writeAsBytes(response.bodyBytes);
return filePath;
}

tz.TZDateTime _nextInstanceOfTenAM(int time) {
DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);

final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
tz.TZDateTime scheduledDate = tz.TZDateTime( tz.local, now.year, now.month, now.day, dateTime.hour, dateTime.minute);
// tz.TZDateTime scheduledDate = tz.TZDateTime( tz.local, now.year, now.month, now.day, 13, 22);
if (scheduledDate.isBefore(now)) {
scheduledDate = scheduledDate.add(const Duration(days: 1));
}
return scheduledDate;
}
}
