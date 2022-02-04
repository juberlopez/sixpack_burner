import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/ui/home/mi_progreso/cubit/mi_progreso_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/mi_progreso/widgets/carrucel_control.dart';
import 'package:sixpackburner/presentations/ui/home/mi_progreso/widgets/carrusel_progreso.dart';
import 'package:sixpackburner/presentations/ui/home/mi_progreso/widgets/modal_form_control.dart';
import 'package:sixpackburner/presentations/ui/theme/app_theme.dart';
import 'package:sixpackburner/presentations/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart'; // for date format

class MiProgresoView extends StatefulWidget {
  const MiProgresoView({Key? key}) : super(key: key);

  @override
  _MiProgresoViewState createState() => _MiProgresoViewState();
}

class _MiProgresoViewState extends State<MiProgresoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es');
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
                         ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Registra tu progreso y compara tus resultados",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
                // CarouselProgreso(
                //   lista: [
                //     'assets/images/slider1.jpg',
                //     'assets/images/slider2.jpg',
                //     'assets/images/slider3.jpg',
                //   ],
                // ),
                FadeInImage(
height: 250.0,
fit: BoxFit.cover,
fadeInDuration: Duration( milliseconds: 200 ),
placeholder: AssetImage('assets/images/predeterminada.jpg'), image: AssetImage('assets/images/bannerfotos.jpg')),
// Image(image: AssetImage('assets/images/bannerfotos.jpg')),
      SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => new AlertDialog(
                                content: Container(
                              height: 156,
                              child: Column(
                                children: [
                                  Text(
                                    'Recomendaciones de como debería ser tus fotografías.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Quicksand',
                                      color: Color(0xffA4A4A4),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text:
                                            'Puede ser tipo selfi frente al espejo. ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Quicksand',
                                          color: Color(0xffA4A4A4),
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Mujeres',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Quicksand',
                                                  color: Color(0xffA4A4A4),
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text:
                                                  ' con top o blusa y licra corta. ',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Quicksand',
                                                color: Color(0xffA4A4A4),
                                              )),
                                          TextSpan(
                                              text: 'Hombres',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'Quicksand',
                                                  color: Color(0xffA4A4A4),
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                              text:
                                                  ' sin camisetas y con pantaloneta corta. Las fotos deben registrarse cada 10 dias para ver tu progreso.',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Quicksand',
                                                color: Color(0xffA4A4A4),
                                              )),
                                        ]),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      "No es obligatorio tomarse las fotos, son para tu motivación.",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Quicksand',
                                        color: Color(0xffA4A4A4),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            )),
                          );
                        },
                        child: Container(
child: Row(
                          children: [
                            Text(
                              "Informacion",
                              style: TextStyle(color: Colors.blue),
                            ),
                            Icon(
                              Icons.info,
                              color: Colors.blue,
                            )
                          ],
                        ),
height: 40,
padding:  EdgeInsets.only(right:5),
                        )
                        )
                  ],
                ),
                      SizedBox(height: 10),
                Text("MI PROCESO"),
           SizedBox(height: 20),
                   SingleChildScrollView(
                    child: BlocBuilder<MiProgresoCubit, MiProgresoState>(
                      buildWhen: (previous, current) =>
                          previous.listaProgresos != current.listaProgresos || previous.sizeListaprogreso != current.sizeListaprogreso,
                      builder: (context, state) {
                        print("estado: $state");
                        return Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: (state.listaProgresos.isNotEmpty)
                              ? CarouselControl(
                                  listaProgresos: state.listaProgresos,
                                )
                              : Center(
                                  child: Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Text(
                                    "Registra tu primer foto para que compares los cambios de tu progreso.",
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.left,
                                  ),
                                )),
                        );
                      },
                    ),
                  ),
                
                ModalFormControl(),
                Row(
                children: [
            //       Expanded(
            // child: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     height: 50,
            //     child: OutlinedButton(
            //       child: Text('Reglas del Concurso'),
            //       style: OutlinedButton.styleFrom(
            //         primary: Colors.blue,
            //         backgroundColor: Colors.white,
            //         side: BorderSide(color: Colors.blue, width: 1),
            //       ),
            //       onPressed: () async {
            //         await launch(
            //                   'https://reto30.fit/reglas');
            //       },
            //     ),
            //   ),
            // ),
            //       ),
                ],
              )
              ],
            ),
          ),
          _buildLoading(context)
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext contextDialogo) {
    return BlocBuilder<MiProgresoCubit, MiProgresoState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == StatusMiprogreso.loading
            ? LoadingIndicator()
            : Container();
      },
    );
  }
}

class ProgresoCard extends StatefulWidget {
  final MyProgressModel myProgressModel;
  //final AlimentoModel alimentoModel;
  const ProgresoCard({Key? key, required this.myProgressModel})
      : super(key: key);

  @override
  _ProgresoCardState createState() => _ProgresoCardState();
}

class _ProgresoCardState extends State<ProgresoCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: 130,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      child: FadeInImage(
                        image: NetworkImage(
                            widget.myProgressModel.fotos!.small.toString()),
                        placeholder: AssetImage('assets/images/logo_reto.png'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.myProgressModel.peso.toString(),
                      style: AppTheme.text15,
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Text(
                          widget.myProgressModel.fecha.toString(),
                          style: AppTheme.text14,
                        ),
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
