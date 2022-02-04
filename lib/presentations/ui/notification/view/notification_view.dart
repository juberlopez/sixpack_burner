import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class NotificatioView extends StatefulWidget {
  static final String routeName = 'notification_View';
  const NotificatioView({ Key? key }) : super(key: key);

  @override
  _NotificatioViewState createState() => _NotificatioViewState();
}

class _NotificatioViewState extends State<NotificatioView> {
  @override
  Widget build(BuildContext context) {
     
     final ChallengeModel challengeModel  =
        ModalRoute.of(context)!.settings.arguments! as ChallengeModel;
 
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: FractionallySizedBox(
                  child: FadeInImage(
                image: NetworkImage(challengeModel.image.toString()),
                placeholder: AssetImage('assets/images/logo_reto.png'),
                fit: BoxFit.cover,
                width: double.infinity,
              )),
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 15),
              child: Text(challengeModel.title.toString(),style: AppTheme.text15,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 15),
              child: Text(challengeModel.body.toString(),style: AppTheme.text14),
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
                    "Información",
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
                padding: const EdgeInsets.only(top:15,left: 20,right: 20),
                child: Column(
                  children: [Text(challengeModel.data.toString())],
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

 