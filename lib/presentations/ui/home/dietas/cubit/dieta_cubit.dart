import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:sixpackburner/device/device.dart';
import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/app.dart';
import 'package:equatable/equatable.dart';
import "package:collection/collection.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

part 'dieta_state.dart';

class DietaCubit extends Cubit<DietaState> {
  int? indexmenu=0;
  DietaCubit()
      : super(DietaState(
            listaDietas: [],
            info: InfoModel(),
            dieta: DietaModel(alimentos: []),
            comidas: {}));

  Future<void> init() async {
    emit(state.copyWith(status: StatusDieta.loading));
   this.indexmenu= await PersitentDevice().getMenu();
    String? data = await PersitentDevice().getDietas();
    double calorias = 0;
    double carbohidratos = 0;
    double grasas = 0;
    double proteinas = 0;
    int menu = indexmenu!;
    int index = 0;
 print("index stars $this.indexmenu");
    // print(data);
    JsonDietasModel jsonDietasModel = JsonDietasModel.fromRawJson(data!);

   
    jsonDietasModel.dietas![menu].alimentos!.sort((a, b) {
      return (a.hora! - b.hora!);
    });

    // menu = jsonDietasModel.dietas![0].menu!;
// menu= indexmenu!;
    jsonDietasModel.dietas![menu].alimentos!.forEach((element) {
      calorias = calorias + element.calorias!;
      carbohidratos = carbohidratos + element.chos!;
      grasas = grasas + element.grasa!;
      proteinas = proteinas + element.proteina!;

      index = index + 1;

      if (index == jsonDietasModel.dietas![menu].alimentos!.length) {
        emit(
          state.copyWith(
              menu: menu+1,
              totalCalorias: calorias,
              totalCarbohidratos: carbohidratos,
              totalGrasas: grasas,
              totalProteinas: proteinas,
              listaDietas: jsonDietasModel.dietas,
              info: jsonDietasModel.info,
              dieta: jsonDietasModel.dietas![menu],
              comidas: jsonDietasModel.dietas![menu].alimentos!
                  .map((e) => e)
                  .groupListsBy((element) => element.comida)),
        );
        setNotification();
        emit(state.copyWith(status: StatusDieta.initial));
      }
    });
  }

  Future<void> registerCode(
    String code,
  ) async {
    emit(state.copyWith(status: StatusDieta.autenticado));

    print(code);
  }

  Future<void> masOpciones() async {
    double calorias = 0;
    double carbohidratos = 0;
    double grasas = 0;
    double proteinas = 0;

    int menu = (indexmenu) ?? 0;
// menu=menu+1;
    print("menú opciones: $menu");

    if (state.listaDietas.length != state.menu) {
      state.listaDietas[state.menu].alimentos!.sort((a, b) {
        return (a.hora! - b.hora!);
      });
      state.listaDietas[state.menu].alimentos!.forEach((element) {
        calorias = calorias + element.calorias!;
        carbohidratos = carbohidratos + element.chos!;
        grasas = grasas + element.grasa!;
        proteinas = proteinas + element.proteina!;
      });
      menu = state.menu + 1;
    } else {

      state.listaDietas[0].alimentos!.sort((a, b) {
        return (a.hora! - b.hora!);
      });

      state.listaDietas[0].alimentos!.forEach((element) {
        calorias = calorias + element.calorias!;
        carbohidratos = carbohidratos + element.chos!;
        grasas = grasas + element.grasa!;
        proteinas = proteinas + element.proteina!;
      });
      menu = 1;
    }
    emit(
      state.copyWith(
          menu: menu,
          totalCalorias: calorias,
          totalCarbohidratos: carbohidratos,
          totalGrasas: grasas,
          totalProteinas: proteinas,
          dieta: state.listaDietas[menu - 1],
          comidas: state.listaDietas[menu - 1].alimentos!
              .map((e) => e)
              .groupListsBy((element) => element.comida)),
    );
    await PersitentDevice().setMenu(menu);
  }

  Future<bool> mostrarPupop() async {
    print("mostrarPupop_1");

    try {
      print("mostrarPupop_2");
      String? dataUser = await PersitentDevice().getPupopReto();

      if (dataUser!.isEmpty) {
        PersitentDevice().setPupopReto();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("mostrarPupop_4");
      PersitentDevice().setPupopReto();
      print("mostrarPupop_5");
      return true;
    }
  }

  /*groupByMap(List<AlimentoModel>? alimentos, keyGetter) {

var map = new Map();

alimentos!.forEach((item) { 
  var key = keyGetter(item);
  var collection = map[key];
  if (!collection) {
map.update(key, (value) => null)(key, [item]);
} else {
collection.push(item);
}
});

list.forEach((item) => {
 key = keyGetter(item);
const collection = map.;
if (!collection) {
map.set(key, [item]);
} else {
collection.push(item);
}
});
return Array.from(map);
}*/

  String sumaCalorias(List<AlimentoModel> listaAlimentos) {
    double calorias = 0;
    listaAlimentos.forEach((element) {
      calorias = calorias + element.calorias!;
    });

    return calorias.toInt().toString();
  }

  String sumaCarbohidratos(List<AlimentoModel> listaAlimentos) {
    double carbohidratos = 0;
    listaAlimentos.forEach((element) {
      carbohidratos = carbohidratos + element.chos!;
    });

    return carbohidratos.toInt().toString();
  }

  String sumaGrasas(List<AlimentoModel> listaAlimentos) {
    double grasas = 0;
    listaAlimentos.forEach((element) {
      grasas = grasas + element.grasa!;
    });

    return grasas.toInt().toString();
  }

  String sumaProteinas(List<AlimentoModel> listaAlimentos) {
    double proteinas = 0;
    listaAlimentos.forEach((element) {
      proteinas = proteinas + element.proteina!;
    });

    return proteinas.toInt().toString();
  }

  Future<void> initNotification(bool notificacion) async {
    if (notificacion) {
      await flutterLocalNotificationsPlugin.cancelAll();
      var comidas = {
        'AL DESPERTARSE':
            "https://sixpackburner.megaplexstars.com/images/comidas/despertar.jpg",
        "DESAYUNO":
            "https://sixpackburner.megaplexstars.com/images/comidas/desayuno.jpg",
        'MEDIA MAÑANA':
            'https://sixpackburner.megaplexstars.com/images/comidas/mediodia.jpg',
        "ALMUERZO":
            'https://sixpackburner.megaplexstars.com/images/comidas/almuerzo.jpg',
        'MEDIA TARDE':
            'https://sixpackburner.megaplexstars.com/images/comidas/mediatarde.jpg',
        "MERIENDA":
            'https://sixpackburner.megaplexstars.com/images/comidas/comidas_media.jpg',
        "CENA":
            'https://sixpackburner.megaplexstars.com/images/comidas/cena.jpg',
        "POST ENTRENO":
            'https://sixpackburner.megaplexstars.com/images/comidas/cena.jpg',
      };

      /*await flutterLocalNotificationsPlugin.periodicallyShow(
          0,
          'repeating title',
          'repeating body',
          RepeatInterval.everyMinute,
          notificationDetails);*/

      state.comidas.forEach((key, value) async {
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

  void setNotification() {
    PersitentDevice().getnotificacion().then((value) {
      emit(state.copyWith(notification: value));
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

  tz.TZDateTime _nextInstanceOfTenAM(int time) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time);

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, now.year, now.month, now.day, dateTime.hour, dateTime.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
