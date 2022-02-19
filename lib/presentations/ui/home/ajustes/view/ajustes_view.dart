import 'package:sixpackburner/domain/domain.dart';
import 'package:sixpackburner/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/ajustes/cubit/ajustes_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/profile/cubit/profile_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/profile/view/profile_view.dart';
import 'package:sixpackburner/presentations/ui/home/recetas/cubit/recetas_cubit.dart';
import 'package:sixpackburner/presentations/ui/home/recordatorio/view/recordatorio_view.dart';
import 'package:sixpackburner/presentations/ui/poll/view/poll_view.dart';
import 'package:sixpackburner/presentations/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sixpackburner/presentations/ui/welcome/view/welcome_view.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class AjustesView extends StatefulWidget {
  const AjustesView({Key? key}) : super(key: key);

  @override
  _AjustesViewState createState() => _AjustesViewState();
}

class _AjustesViewState extends State<AjustesView> {
  @override
  void initState() {
    //BlocProvider.of<RecetasCubit>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserPlusModel user = context.select((ProfileCubit b) => b.state.user);
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 140,
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
                        "CONFIGURACIONES",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Ink(
                    color: Colors.white,
                    child: ListTile(
                      focusColor: Colors.white,
                      leading: Icon(Icons.contact_phone),
                      title: Text('Contacto'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () async {
                        final link = WhatsAppUnilink(
                          phoneNumber: '573013422308',
                          text:
                              "Hola, me llamo ${user.usuario}  instalé la app reto burner stack y quiero más información",
                        );
                        await launch('$link');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Ink(
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, PollView.routeName);
                      },
                      hoverColor: Colors.white,
                      leading: Icon(Icons.restaurant),
                      title: Text('Crear nueva dieta'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Ink(
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(Icons.alarm_on),
                      title: Text('Recordatorios'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pushNamed(
                            context, RecordatorioView.routeName);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Ink(
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(Icons.camera_rear),
                      title: Text('Términos y condiciones'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () async {
                        await launch(
                            'https://retoburnerstack.megaplexstars.com/#conditions');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Ink(
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(Icons.visibility_off),
                      title: Text('Politicas de privacidad'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () async {
                        await launch(
                            'https://retoburnerstack.megaplexstars.com/#policy');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Ink(
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, ProfileView.routeName);
                      },
                      leading: Icon(Icons.person),
                      title: Text('Perfil'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Ink(
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        BlocProvider.of<AuthenticationCubit>(context).logOut();
                          // Navigator.pushNamed(context, WelcomeView.routeName);
                                 Navigator.pushNamedAndRemoveUntil(context, WelcomeView.routeName, (r) => false);
                      },
                      leading: Icon(Icons.arrow_back),
                      title: Text('Cerrar Sesion'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
