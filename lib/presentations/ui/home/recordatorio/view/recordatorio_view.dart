import 'package:burnet_stack/domain/domain.dart';
import 'package:burnet_stack/presentations/ui/home/dietas/cubit/dieta_cubit.dart';
import 'package:burnet_stack/presentations/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.Dart';

class RecordatorioView extends StatefulWidget {
  static final String routeName = 'recordatorio_View';

  const RecordatorioView({Key? key}) : super(key: key);

  @override
  _RecordatorioViewState createState() => _RecordatorioViewState();
}

class _RecordatorioViewState extends State<RecordatorioView> {
  @override
  void initState() {
    //BlocProvider.of<DietaCubit>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(color: Colors.white);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(stops: [
                          0.0,
                          1,
                        ], colors: AppTheme.secondarylinearGradiant),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "HORARIO DE COMIDA",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: BlocBuilder<DietaCubit, DietaState>(
                buildWhen: (previous, current) =>
                    previous.comidas != current.comidas,
                builder: (context, state) {
                  List<Widget> comidas = [];
                  state.comidas.forEach((key, value) {
                    DateTime dateTime =
                        DateTime.fromMillisecondsSinceEpoch(value[0].hora!);
                    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
                    comidas.add(
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Ink(
                          color: Colors.white,
                          child: Container(
                            height: 70,
                            child: Center(
                              child: ListTile(
                                hoverColor: Colors.white,
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(timeOfDay.format(context)),
                                    Text(key.toString())
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });

                  return ListView(
                    children: comidas,
                  );
                },
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ACTIVAR RECORDATORIOS DE COMIDAS",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Es muy importante programar las horas de comida para tener un equilibrio metabólico, la app te notofoca la hora para cada comida, puedes desactivar los recordatorios aquí",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      child: Switch(
                        value: context
                            .select((DietaCubit b) => b.state.notification),
                        onChanged: (value) {
                          context.read<DietaCubit>().initNotification(value);
                        },
                        //activeTrackColor: UiTheme.primaryColor.withOpacity(0.3),
                        //activeColor: UiTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
