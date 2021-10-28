import 'package:burnet_stack/presentations/constant/constant.dart';
import 'package:burnet_stack/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:burnet_stack/presentations/services/screen_messages_service.dart';
import 'package:burnet_stack/presentations/ui/poll/poll_cubit/poll_cubit.dart';
import 'package:burnet_stack/presentations/ui/poll/view/poll_antro_view.dart';
import 'package:burnet_stack/presentations/ui/poll/widgets/button_plus.dart';
import 'package:burnet_stack/presentations/ui/widgets/buttons/app_button.dart';
import 'package:burnet_stack/presentations/ui/widgets/fields/app_field.dart';
import 'package:burnet_stack/presentations/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/iterables.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PollView extends StatefulWidget {
  static final String routeName = 'poll_View';
  const PollView({Key? key}) : super(key: key);

  @override
  _PollViewState createState() => _PollViewState();
}

class _PollViewState extends State<PollView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                      'BIENVENIDO, CUÉNTANOS ACERCA DE TÍ',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Quicksand',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '''Por favor responde la siguientes preguntas para preparar para tu programa nutricional de la forma más preciosa posible con calorías exactas, cantidad de proteína, grasas y carbohidratos.''',
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
                            createAgeDialog(context);
                          },
                          text: 'EDAD' +
                              context.select((PollCubit b) {
                                return b.state.edad.isNotEmpty
                                    ? ": " + b.state.edad
                                    : "";
                              }),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ButtonPlus(
                          onPressed: () {
                            showGeneroDialog(context);
                          },
                          text: 'GENERO' +
                              context.select((PollCubit b) {
                                return b.state.genero.isNotEmpty
                                    ? ": " + b.state.genero
                                    : "";
                              }),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ButtonPlus(
                          onPressed: () {
                            showWeightBottomModal(context);
                          },
                          text: 'ESTATURA' +
                              context.select((PollCubit b) {
                                return b.state.altura.isNotEmpty
                                    ? ": " + b.state.altura + "cm"
                                    : "";
                              }),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ButtonPlus(
                          onPressed: () {
                            createWeightDialog(context);
                          },
                          text: 'PESO' +
                              context.select((PollCubit b) {
                                return b.state.peso.isNotEmpty
                                    ? ": " + b.state.peso + "Kg"
                                    : "";
                              }),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ButtonPlus(
                          onPressed: () {
                            showActividadFisicaDialog(context);
                          },
                          text: context.select((PollCubit b) {
                            return b.state.nivelActividadFisica.isEmpty
                                ? 'NIVEL DE ACTIVIDAD FISICA'
                                : b.state.nivelActividadFisica;
                          }),
                        )),
                      ],
                    ),
                    context.select((PollCubit b) =>
                                b.state.nivelActividadFisica) !=
                            "SEDENTARIO"
                        ? Row(
                            children: [
                              Expanded(
                                  child: ButtonPlus(
                                onPressed: () {
                                  showTiempoEntrenoDialog(context);
                                },
                                text: context.select((PollCubit b) {
                                  return b.state.tiempoEntreno.isEmpty
                                      ? 'TIEMPO DE ENTRENO'
                                      : b.state.tiempoEntreno;
                                }),
                              )),
                            ],
                          )
                        : Container(),
                    Row(
                      children: [
                        Expanded(
                            child: ButtonPlus(
                          onPressed: () => showVegetarianoDialog(context),
                          text: context.select((PollCubit b) {
                            return b.state.vegetariano.isEmpty
                                ? "VEGETARIANO"
                                : b.state.vegetariano;
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
                                    .nextOne()) {
                                  Navigator.pushNamed(
                                      context, PollAntroView.routeName);
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
            Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                        ),
            _buildLoading(context)
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext contextDialogo) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == StatusAuthentication.loading
            ? LoadingIndicator()
            : Container();
      },
    );
  }

  createAgeDialog(BuildContext context) async {
    //var edad= context.select((PollCubit b)=> b.state.edad);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          FormGroup buildForm() => fb.group({
                'edad': FormControl<String>(
                    value: "", validators: [Validators.required]),
              });
          return AlertDialog(
            title: Text(
              'Ingresa tu edad',
              style: TextStyle(color: Colors.black),
            ),
            content: Container(
              height: 200,
              child: Column(
                children: [
                  ReactiveFormBuilder(
                      form: buildForm,
                      builder: (context, form, child) {
                        return Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  child: Column(
                                    children: [
                                      AppField(
                                        keyboardType: TextInputType.number,
                                        form: form,
                                        formControlName: "edad",
                                        labelText: "edad",
                                        onTap: () => {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: AppButton(
                                      label: 'Cancelar',
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    child: AppButton(
                                      label: 'Enviar',
                                      onPressed: () async {
                                        if (form.valid) {
                                          await BlocProvider.of<PollCubit>(
                                                  context)
                                              .newAge(
                                            form.control("edad").value,
                                          );

                                          Navigator.of(context).pop();
                                        } else {
                                          ScreenMessagesService()
                                              .toast("Verificar formulario");

                                          form.markAllAsTouched();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      })
                ],
              ),
            ),
          );
        });
  }

  createWeightDialog(BuildContext context) async {
    //var edad= context.select((PollCubit b)=> b.state.edad);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          FormGroup buildForm() => fb.group({
                'peso': FormControl<String>(
                    value: "", validators: [Validators.required]),
              });
          return AlertDialog(
            title: Text(
              'Ingresa tu peso',
              style: TextStyle(color: Colors.black),
            ),
            content: Container(
              height: 200,
              child: Column(
                children: [
                  ReactiveFormBuilder(
                      form: buildForm,
                      builder: (context, form, child) {
                        return Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Container(
                                  child: Column(
                                    children: [
                                      AppField(
                                        keyboardType: TextInputType.number,
                                        form: form,
                                        formControlName: "peso",
                                        labelText: "Kg",
                                        onTap: () => {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: AppButton(
                                      label: 'Cancelar',
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    child: AppButton(
                                      label: 'Aceptar',
                                      onPressed: () async {
                                        if (form.valid) {
                                          await BlocProvider.of<PollCubit>(
                                                  context)
                                              .peso(
                                            form.control("peso").value,
                                          );

                                          Navigator.of(context).pop();
                                        } else {
                                          ScreenMessagesService()
                                              .toast("Verificar formulario");

                                          form.markAllAsTouched();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      })
                ],
              ),
            ),
          );
        });
  }

  showGeneroDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: SimpleDialog(
            title: Text('Por favor selecciona tu género'),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  BlocProvider.of<PollCubit>(context).genero("MASCULINO");
                  Navigator.pop(context);
                },
                child: const Text("MASCULINO"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  BlocProvider.of<PollCubit>(context).genero("FEMENINO");
                  Navigator.pop(context);
                },
                child: const Text("FEMENINO"),
              ),
            ],
            elevation: 10,
            //backgroundColor: Colors.green,
          ),
        );
      },
    );
  }

  showActividadFisicaDialog(BuildContext context) async {
    List<String> activida = [
      "SEDENTARIO",
      "ENTRENO OCASIONAL Y LIGERO",
      "ENTRENA 3-4 VECES POR SEMANA",
      "ENTRENA FUERTE 5 VECES POR SEMANA",
      "ALTO RENDIMIENTO"
    ];
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: SimpleDialog(
            title: Text('Selecciona el nivel de actividad física'),
            children: activida
                .map((e) => SimpleDialogOption(
                      onPressed: () {
                        BlocProvider.of<PollCubit>(context)
                            .nivelActividadFisica(e);
                        Navigator.pop(context);
                      },
                      child: Text(e),
                    ))
                .toList(),
            elevation: 10,
            //backgroundColor: Colors.green,
          ),
        );
      },
    );
  }

  showTiempoEntrenoDialog(BuildContext context) async {
    List<String> activida = [
      "45 minutos",
      "1 hora",
      "1 hora y media",
      "2 horas",
      "2 Más de dos  horas"
    ];
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: SimpleDialog(
            title: Text('Selecciona el tiempo de entreno'),
            children: activida
                .map((e) => SimpleDialogOption(
                      onPressed: () {
                        BlocProvider.of<PollCubit>(context).tiempoEntreno(e);
                        Navigator.pop(context);
                      },
                      child: Text(e),
                    ))
                .toList(),
            elevation: 10,
            //backgroundColor: Colors.green,
          ),
        );
      },
    );
  }

  showVegetarianoDialog(BuildContext context) async {
    List<String> activida = [
      AppConstant.VEGETARIANO_NO,
      AppConstant.VEGETARIANO_SI
    ];
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: SimpleDialog(
            title: Text('¿Eres vegetariano?'),
            children: activida
                .map((e) => SimpleDialogOption(
                      onPressed: () {
                        BlocProvider.of<PollCubit>(context).vegetariano(e);
                        Navigator.pop(context);
                      },
                      child: Text(e),
                    ))
                .toList(),
            elevation: 10,
            //backgroundColor: Colors.green,
          ),
        );
      },
    );
  }

  void showWeightBottomModal(
    BuildContext context,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 1,
              child: SingleChildScrollView(
                child: Column(
                    children: range(150, 200)
                        .map((e) => GestureDetector(
                            onTap: () {
                              BlocProvider.of<PollCubit>(context)
                                  .altura(e.toString());
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text(e.toString() + " cm")),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )))
                        .toList()),
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

class ListarEstaturas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: range(150, 200)
              .map((e) => GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Text(e.toString() + "cm"),
                  )))
              .toList()),
    );
  }
}
    
/**
 * .map((e) => ItemCategoria(
                        listaReproduccion: e,
                      ))
                  .toList(),
 */
