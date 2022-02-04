import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/ui/home/dietas/cubit/dieta_cubit.dart';
import 'package:sixpackburner/presentations/ui/theme/app_theme.dart';
import 'package:sixpackburner/presentations/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DietasView extends StatefulWidget {
  const DietasView({Key? key}) : super(key: key);

  @override
  _DietasViewState createState() => _DietasViewState();
}

class _DietasViewState extends State<DietasView> {
@override
void initState() {
BlocProvider.of<DietaCubit>(context).init();

print("mostrarPupop_init");

/*showDialog(
barrierColor: Colors.transparent,
context: context,
builder: (context) => new AlertDialog(
backgroundColor: Colors.transparent,
content: GestureDetector(
onTap: (){
Navigator.of(context).pop();
},
child: Container(
height: 156,
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Image.asset(
'assets/images/POPUP.png',
//width: 325,
),
],
),
),
)),
).then((value) => {});*/
// BlocProvider.of<DietaCubit>(context).mostrarPupop().then((value) {
//   if (value) {
//     showDialog(
//       barrierColor: Colors.transparent,
//       context: context,
//       builder: (context) => new AlertDialog(
//           backgroundColor: Colors.transparent,
//           content: GestureDetector(
//             onTap: (){
//               Navigator.of(context).pop();
//             },
//             child: Container(
//               height: 156,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/images/POPUP.png',
//                     //width: 325,
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     ).then((value) => {});
//   }else{
//   }
// });
super.initState();
}

@override
Widget build(BuildContext context) {
TextStyle style = TextStyle(color: Colors.white);
return Scaffold(
body: Stack(
children: [
BlocBuilder<DietaCubit, DietaState>(
buildWhen: (previous, current) =>
previous.listaDietas != current.listaDietas ||
previous.totalCalorias != current.totalCalorias,
builder: (context, state) {
return state.listaDietas.isNotEmpty
? Column(
children: [
Container(
height: 195,
width: double.infinity,
color: Colors.blue,
child: Column(
children: [
SizedBox(
height: 15,
),
Text("CALORÍAS DIARIAS RECOMENDADAS",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold)),
Padding(
padding: const EdgeInsets.only(
left: 20.0, top: 10, right: 20),
child: Row(
children: [
Column(
children: [
Container(
decoration: BoxDecoration(
border: Border.all(
width: 5.0,
color: Colors.white),
borderRadius: BorderRadius.all(
Radius.circular(
50.0) //                 <--- border radius here
),
),
height: 100,
width: 100,
child: Column(
mainAxisAlignment:
MainAxisAlignment.center,
children: [
Text(
state.totalCalorias
.toInt()
.toString(),
style: TextStyle(
color: Colors.white,
fontSize: 25),
),
Text("Kcal", style: style)
],
),
),
SizedBox(height: 5,),
Text("Menú " + state.menu.toString(),
style: style)
],
),
SizedBox(
width: 40,
),
Expanded(
child: Container(
child: Column(
children: [
Padding(
padding:
const EdgeInsets.only(bottom:2),
child: Row(
children: [
Text("Proteínas",
style: style),
Expanded(
child: Container(),
),
Text(
state.totalProteinas
.toInt()
.toString() +
"gr",
style: style),
],
),
),
Padding(
padding:
const EdgeInsets.only(bottom:2),
child: Row(
children: [
Text("Carbohidratos",
style: style),
Expanded(
child: Container(),
),
Text(
state.totalCarbohidratos
.toInt()
.toString() +
"gr",
style: style),
],
),
),
Padding(
padding:
const EdgeInsets.all(1.0),
child: Row(
children: [
Text("Grasas", style: style),
Expanded(
child: Container(),
),
Text(
state.totalGrasas
.toInt()
.toString() +
"gr",
style: style),
],
),
),
// Padding(
// padding: const EdgeInsets.only(
// top: 0.0),
// child: Row(
                      Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Row(
                        children: [
                          Expanded( child: Container(), ),
                 TextButton(
                         onPressed: () async {
                              await launch(
                                  'https://reto30.fit/blog/');
                            },
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text("Fuente de información",
                                        style: style),
                                    // Text("informacion",
                                    //     style: style),
                                  ],
                                ),
                                Icon(
                                  Icons.info,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
    Row(
children: [
Expanded(
child: Container(),
),
TextButton(
          style: TextButton.styleFrom( primary: Colors.white),
onPressed: (){_changeMenu();},
                            child: Row(
                              children: [
                                Text("Más Menús",
                                    style: style),
                                Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    // ),

                  ],
                ),
              ),
            )
          ],
        ),
      )
    ],
  ),
),
Expanded(
  child: SingleChildScrollView(
    child: BlocBuilder<DietaCubit, DietaState>(
      buildWhen: (previous, current) =>
          previous.comidas != current.comidas,
      builder: (context, state) {
        List<Widget> comidas = [];
        state.comidas.forEach((key, value) {
          comidas.add(DietaCard(
            nombre: key.toString(),
            listaAlimentos: value,
          ));
        });

        return Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Column(children: comidas),
        );
      },
    ),
  ),
)
],
)
: Container();
},
),
_buildLoading(context)
],
),
);
}
Widget _buildLoading(BuildContext contextDialogo) {
return BlocBuilder<DietaCubit, DietaState>(
buildWhen: (previous, current) => previous.status != current.status,
builder: (context, state) {
return state.status == StatusDieta.loading
? LoadingIndicator()
: Container();
},
);
}
_changeMenu() {
showDialog(
barrierDismissible: false,
builder: (ctx) {
return Center(
  child: CircularProgressIndicator(
    strokeWidth: 2,
  ),
);
},
context: context,
);
pause(500).then((value) {
BlocProvider.of<
DietaCubit>(
context)
.masOpciones();
Navigator.of(context).pop();
});
}
Future pause(int delay)=> Future.delayed( Duration( milliseconds: delay ) );
}

class DietaCard extends StatelessWidget {
final String nombre;
final List<AlimentoModel> listaAlimentos;
//final AlimentoModel alimentoModel;
const DietaCard({Key? key, this.nombre = "", required this.listaAlimentos})
: super(key: key);

@override
Widget build(BuildContext context) {
DateTime dateTime =
DateTime.fromMillisecondsSinceEpoch(listaAlimentos[0].hora!);
TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
return Padding(
padding: const EdgeInsets.all(8.0),
child: Card(
elevation: 5,
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
children: [
Text(toBeginningOfSentenceCase(listaAlimentos[0].comida)
.toString()),
Expanded(child: Container()),
Text(timeOfDay.format(context))
],
),
SizedBox(
height: 10,
),
Column(
children: listaAlimentos.map(
(e) {
var cantidad = "";
if (e.cantidad == 0.5) {
cantidad = "1/2";
} else if (e.cantidad == 0) {
cantidad = "-";
} else {
cantidad = e.cantidad!.toInt().toString();
}

return Row(
children: [
SizedBox(
width: 30,
child: Text(
cantidad,
textAlign: TextAlign.justify,
style: TextStyle(color: Colors.grey),
)),
SizedBox(
width: 5,
),
Expanded(
child: Text(e.alimento.toString(),
style: TextStyle(color: Colors.grey))),
],
);
},
).toList()),
Row(
children: [
Expanded(
child: Container(),
),
Padding(
padding: const EdgeInsets.all(5.0),
child: Column(
children: [
Text(
"Proteínas",
style: AppTheme.text13,
),
Text(
BlocProvider.of<DietaCubit>(context)
.sumaProteinas(listaAlimentos) +
"gr",
style: AppTheme.text14,
)
],
),
),
Padding(
padding: const EdgeInsets.all(5.0),
child: Column(
children: [
Text(
"Carbo",
style: AppTheme.text13,
),
Text(
BlocProvider.of<DietaCubit>(context)
.sumaCarbohidratos(listaAlimentos) +
"gr",
style: AppTheme.text14,
)
],
),
),
Padding(
padding: const EdgeInsets.all(5.0),
child: Column(
children: [
Text(
"Grasas",
style: AppTheme.text13,
),
Text(
BlocProvider.of<DietaCubit>(context)
.sumaGrasas(listaAlimentos) +
"gr",
style: AppTheme.text14,
)
],
),
),
Padding(
padding: const EdgeInsets.all(5.0),
child: Column(
children: [
Text(
"Calorías",
style: AppTheme.text13,
),
Text(
BlocProvider.of<DietaCubit>(context)
.sumaCalorias(listaAlimentos) +
"Kcal",
style: AppTheme.text14,
)
],
),
)
],
)
],
),
),
),
);
}


}
