import 'package:flutter/services.dart';
import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/ui/home/recetas/cubit/recetas_cubit.dart';
import 'package:sixpackburner/presentations/ui/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

class DetalleRetoWidget extends StatefulWidget {
  final ChallengeModel challengeModel;
  //final AlimentoModel alimentoModel;
  const DetalleRetoWidget({Key? key, required this.challengeModel})
      : super(key: key);

  @override
  _DetalleRetoWidgetState createState() => _DetalleRetoWidgetState();
}

class _DetalleRetoWidgetState extends State<DetalleRetoWidget> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle( statusBarColor: Colors.transparent));
  }

@override
void dispose(){
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle( statusBarColor: Colors.blueAccent));
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              child: FractionallySizedBox(
                  child: FadeInImage(
                image: NetworkImage(widget.challengeModel.image.toString()),
                placeholder: AssetImage('assets/images/logo_reto.png'),
                fit: BoxFit.cover,
                width: double.infinity,
              )),
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 15),
              child: Text(widget.challengeModel.title.toString(),style: AppTheme.text15,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 15),
              child: Text(widget.challengeModel.body.toString(),style: AppTheme.text14),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[200],
            ),
            Padding(
              padding: const EdgeInsets.only(left:15,top: 8.0, bottom: 8.0,right: 15),
              child: Row(
                children: [
                  Icon(Icons.info_sharp, color: Colors.blue),
                  Text(
                    "Informaci??n",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color:  Colors.grey[200],
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.only(top:15,left: 20,right: 20, bottom: 30),
                child: Column(
                  children: [Text(widget.challengeModel.data.toString())],
                ),
              )),
            )
          ],
        ),
          Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back_ios,color: Colors.grey,)),
                        )
        ],
        
      ),
    ));
  }
}
