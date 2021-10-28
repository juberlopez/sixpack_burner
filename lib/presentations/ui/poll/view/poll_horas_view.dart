import 'package:burnet_stack/presentations/constant/constant.dart';
import 'package:burnet_stack/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:burnet_stack/presentations/ui/poll/poll_cubit/poll_cubit.dart';
import 'package:burnet_stack/presentations/ui/poll/view/poll_info_view.dart';
import 'package:burnet_stack/presentations/ui/poll/widgets/button_plus.dart';
import 'package:burnet_stack/presentations/ui/widgets/buttons/app_button.dart';
import 'package:burnet_stack/presentations/ui/widgets/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PollHorasView extends StatefulWidget {
  static final String routeName = 'poll_horas_View';
  const PollHorasView({Key? key}) : super(key: key);

  @override
  _PollHorasViewState createState() => _PollHorasViewState();
}

class _PollHorasViewState extends State<PollHorasView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<PollCubit, PollState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == StatusPoll.finish) {
              Navigator.pushNamed(context, InfoView.routeName);
            }
            // TODO: implement listener
          },
          child: Stack(
            children: [
              _ImagenBackGround(),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/logo_reto.png',
                        width: 177,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '''HORAS COMIDAS.''',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Quicksand',
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ButtonPlus(
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return FractionallySizedBox(
                                        heightFactor: 0.5,
                                        child: TimePiker(
                                          onTimer: (data) {
                                            print(data);
                                            BlocProvider.of<PollCubit>(context)
                                                .horaDespertar(data);
                                            Navigator.of(context).pop();
                                          },
                                        ));
                                  });
                            },
                            text: context.select((PollCubit b) {
                              return b.state.horaDespierta.isNotEmpty
                                  ? "ME DESPIERTO A LAS : " +
                                      b.state.horaDespierta
                                  : '¿A QUÉ HORAS TE DESPIERTAS?';
                            }),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ButtonPlus(
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return FractionallySizedBox(
                                        heightFactor: 0.5,
                                        child: TimePiker(
                                          onTimer: (data) {
                                            print(data);
                                            BlocProvider.of<PollCubit>(context)
                                                .horaEntrenar(data);
                                            Navigator.of(context).pop();
                                          },
                                        ));
                                  });
                            },
                            text: context.select((PollCubit b) {
                              return b.state.horaEntrena.isNotEmpty
                                  ? "ENTRENO A LAS  " + b.state.horaEntrena
                                  : '¿A QUÉ HORAS ENTRENAS?';
                            }),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ButtonPlus(
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return FractionallySizedBox(
                                        heightFactor: 0.5,
                                        child: TimePiker(
                                          onTimer: (data) {
                                            print(data);
                                            BlocProvider.of<PollCubit>(context)
                                                .horaDesayunar(data);
                                            Navigator.of(context).pop();
                                          },
                                        ));
                                  });
                            },
                            text: context.select((PollCubit b) {
                              return b.state.horaDesayuno.isNotEmpty
                                  ? "DESAYUNO A LAS : " + b.state.horaDesayuno
                                  : '¿A QUÉ HORAS DESAYUNAS?';
                            }),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ButtonPlus(
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return FractionallySizedBox(
                                        heightFactor: 0.5,
                                        child: TimePiker(
                                          onTimer: (data) {
                                            print(data);
                                            BlocProvider.of<PollCubit>(context)
                                                .horaAlmuerzo(data);
                                            Navigator.of(context).pop();
                                          },
                                        ));
                                  });

                              /*
                                    horasModal(
                                        context,
                                        (data) => BlocProvider.of<PollCubit>(context)
                                            .horaAlmuerzo(data));*/
                            },
                            text: context.select((PollCubit b) {
                              return b.state.horaAlmuerzo.isNotEmpty
                                  ? "ALMUERZO A LAS : " + b.state.horaAlmuerzo
                                  : '¿A QUÉ HORAS ALMUERZAS?';
                            }),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ButtonPlus(
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return FractionallySizedBox(
                                        heightFactor: 0.5,
                                        child: TimePiker(
                                          onTimer: (data) {
                                            print(data);
                                            BlocProvider.of<PollCubit>(context)
                                                .horaCena(data);
                                            Navigator.of(context).pop();
                                          },
                                        ));
                                  });
                            },
                            text: context.select((PollCubit b) {
                              return b.state.horaCena.isNotEmpty
                                  ? "CENO A LAS : " + b.state.horaCena
                                  : '¿A QUÉ HORAS CENAS?';
                            }),
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: AppButton(
                                label: 'Siguiente',
                                onPressed: () {
                                  if (BlocProvider.of<PollCubit>(context)
                                      .nextTree()) {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return FractionallySizedBox(
                                              heightFactor: 0.5,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Text(
                                                        "Consumir un batido de proteina en dietas para perder grasa es muy importante para mantener la masa muscular. ¿Deseas tu plan nutricional con alguno de los siguientes batidos? Selecciona una opción",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              BlocProvider.of<
                                                                          PollCubit>(
                                                                      context)
                                                                  .producto(
                                                                      AppConstant
                                                                          .PRODUCTO_BIPRO);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Image.asset(
                                                                  'assets/images/bipronatural.png',
                                                                  height: 80,
                                                                ),
                                                                Text("Bipro")
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              BlocProvider.of<
                                                                          PollCubit>(
                                                                      context)
                                                                  .producto(
                                                                      AppConstant
                                                                          .PRODUCTO_MEGAPLEXLITE);
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Image.asset(
                                                                  'assets/images/megaplexlite.png',
                                                                  height: 80,
                                                                ),
                                                                Text(
                                                                    "Megaplex Life")
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              BlocProvider.of<
                                                                          PollCubit>(
                                                                      context)
                                                                  .producto(
                                                                      AppConstant
                                                                          .PRODUCTO_NINGUNO);
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Image.asset(
                                                                  'assets/images/food.png',
                                                                  height: 80,
                                                                ),
                                                                Text(
                                                                    "Sin batido")
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ));
                                        });
                                    /*Navigator.pushNamed(
                                              context, PollAntroView.routeName);*/
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _buildLoading(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext contextDialogo) {
    return BlocBuilder<PollCubit, PollState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == StatusPoll.loading) {
          return LoadingIndicator();
        } else {
          return Container();
        }
      },
    );
  }

  void horasModal(BuildContext contextHoraModel, Function data) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: contextHoraModel,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.3,
              child: TimePiker(
                onTimer: (data) {
                  print(data);
                  data(data);
                  Navigator.pop(context);
                },
              ));
        });
  }

  void horasEntrenoModal(
    BuildContext context,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.3,
              child: TimePiker(
                onTimer: (data) {
                  print(data);
                  BlocProvider.of<PollCubit>(context).horaEntrenar(data);
                  //Navigator.of(context).pop();
                },
              ));
        });
  }

  void horasDesayunoModal(
    BuildContext context,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.3,
              child: TimePiker(
                onTimer: (data) {
                  print(data);
                  BlocProvider.of<PollCubit>(context).horaDesayunar(data);
                  Navigator.of(context).pop();
                },
              ));
        });
  }

  void horasAlmuerzoModal(
    BuildContext context,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.3,
              child: TimePiker(
                onTimer: (data) {
                  print(data);
                  BlocProvider.of<PollCubit>(context).horaAlmuerzo(data);
                  Navigator.of(context).pop();
                },
              ));
        });
  }

  void horasCenaModal(
    BuildContext context,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.3,
              child: TimePiker(
                onTimer: (data) {
                  print(data);
                  BlocProvider.of<PollCubit>(context).horaCena(data);
                  Navigator.of(context).pop();
                },
              ));
        });
  }
}

class _ImagenBackGround extends StatelessWidget {
  const _ImagenBackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    return Container(
      height: data.size.height,
      width: data.size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('assets/images/andrea_back_burnerstack.png'),
            fit: BoxFit.cover),
      ),
    );
  }
}

class TimePiker extends StatefulWidget {
  final Function onTimer;
  const TimePiker({Key? key, required this.onTimer}) : super(key: key);

  @override
  _TimePikerState createState() => _TimePikerState();
}

class _TimePikerState extends State<TimePiker> {
  late TimeOfDay time;

  @override
  void initState() {
    super.initState();
    time = new TimeOfDay(hour: 00, minute: 00);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            Expanded(
              child: Container(),
            ),
            TextButton(
              onPressed: () {
                var horaPlus = time.hour.toString();
                var hora = (horaPlus.length == 1
                    ? "0" + horaPlus.toString()
                    : horaPlus.toString());

                var minutoPlus = time.minute.toString();
                var minutos = (minutoPlus.length == 1
                    ? "0" + minutoPlus.toString()
                    : minutoPlus.toString());
                widget.onTimer(hora + ":" + minutos);
                //Navigator.pop(context);
              },
              child: Text("Aceptar"),
            )
          ],
        ),
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime(1969, 1, 1, 0, 0),
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                time = TimeOfDay.fromDateTime(newDateTime);
              });

              //_updateTimeFunction(newTod);
            },
            use24hFormat: false,
            minuteInterval: 1,
          ),
        ),
      ],
    );
  }
}
