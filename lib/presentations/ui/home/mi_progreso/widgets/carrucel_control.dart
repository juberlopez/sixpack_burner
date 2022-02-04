import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/ui/home/mi_progreso/cubit/mi_progreso_cubit.dart';
import 'package:sixpackburner/presentations/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quiver/iterables.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselControl extends StatefulWidget {
  final List<MyProgressModel> listaProgresos;

  const CarouselControl({
    Key? key,
    required this.listaProgresos,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CarouselControlState();
  }
}

class _CarouselControlState extends State<CarouselControl> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> contenidoItems = widget.listaProgresos
        .map(
          (item){
           var index = widget.listaProgresos.indexOf(item)+1;
           print(index.toString());
            return Container(
            height: 150,
            width: 250,
            margin:  EdgeInsets.only(bottom:20),
               decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
                  boxShadow: const <BoxShadow>[
BoxShadow(color: Colors.black26,
blurRadius: 10.0,
spreadRadius: 2.0,
offset: Offset(2.0, 5.0)
)
]
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                         ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        child: FadeInImage(
                          image: NetworkImage(item.fotos!.small.toString()),
                          placeholder:
                              AssetImage('assets/images/load.jpg'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.peso.toString() + "Kg",
                        style: AppTheme.text16,
                      ),
                      Text(
                        "Control " + index.toString(),
                        style: AppTheme.text15,
                      ),
                      Text(
                        item.fecha.toString(),
                        style: AppTheme.text14,
                      ),
                      Expanded(child: Container()),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Desea eliminar el registro'),
                                    content: Text("Si aceptas la foto de este registro sera eliminada de nuestra base de datos."),
                                    actions: <Widget>[
                                      TextButton(
                                          child: Text("Cancelar"),
                                                 style: TextButton.styleFrom( primary: Colors.red ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                      TextButton(
                                          child: Text("Eliminar Foto"),
                                         style: TextButton.styleFrom( primary: Colors.red ),
                                          onPressed: () {
                                            context
                                                .read<MiProgresoCubit>()
                                                .deleteProgress(item.id!);
                                            Navigator.of(context).pop();
                                          }),
                                    ],
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.blue,
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
          }
        )
        .toList();
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(children: [
            CarouselSlider(
              items: contenidoItems,
              options: CarouselOptions(
                  height: 180,
                  viewportFraction: 0.8,
                  // enlargeCenterPage: true,
                  // aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: enumerate(widget.listaProgresos).map((e) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF3A3A3A), width: 1.0),
                    shape: BoxShape.circle,
                    color: _current == e.index
                        ? Color(0XFFFFFFFF)
                        : Color(0xFF3A3A3A),
                  ),
                );
              }).toList(),
            ),
          ]),
        ],
      ),
    );
  }
}
