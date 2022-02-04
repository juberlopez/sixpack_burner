import 'dart:ffi';

import 'package:sixpackburner/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:sixpackburner/presentations/ui/login/view/login_view.dart';
import 'package:sixpackburner/presentations/ui/register/widgets/form_register.dart';
import 'package:sixpackburner/presentations/ui/theme/app_theme.dart';
import 'package:sixpackburner/presentations/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterView extends StatefulWidget {
  static final String routeName = 'register_View';
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  void initState() {
    super.initState();
    final d = BlocProvider.of<AuthenticationCubit>(context);
    BlocProvider.of<AuthenticationCubit>(context).initSocket();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthenticationCubit, AuthenticationState>(
        listenWhen: (previous, current) =>
            previous.statusSocket != current.statusSocket,
        listener: (context, state) {
          if (state.statusSocket == StatusAuthentication.validate_mail) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Revisa tu bandeja'),
                    content: Text(
                        "Te hemos enviado un email, por favor abrelo y sigue el link para completar tu registro."),
                    actions: <Widget>[
                      FlatButton(
                          child: Text("REVISAR CORREO"),
                          textColor: Colors.blue,
                          onPressed: () {
                            openMail(context);
                            Navigator.of(context).pop();
                          }),
                    ],
                  );
                });
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [
                        0.0,
                        1,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: AppTheme.primarylinearGradiant),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/splash/logomegaplexstars.png',
                      //width: 325,
                      height: 150,
                    ),
                    FormRegister(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 40.0),
                      child: Center(
                          child: Row(
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          Text(
                            '¿Ya eres miembro?',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Quicksand',
                              color: Color(0xff717171),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, LoginView.routeName);
                              },
                              child: Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                ),
                              )),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      )),
                    ),
                  ],
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
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == StatusAuthentication.loading
            ? LoadingIndicator()
            : Container();
      },
    );
  }

  Future<void> openMail(BuildContext context) async {
    var result = await OpenMailApp.openMailApp();

    // If no mail apps found, show error
    if (!result.didOpen && !result.canOpen) {
      showNoMailAppsDialog(context);

      // iOS: if multiple mail apps found, show dialog to select.
      // There is no native intent/default app system in iOS so
      // you have to do it yourself.
    } else if (!result.didOpen && result.canOpen) {
      showDialog(
        context: context,
        builder: (_) {
          return MailAppPickerDialog(
            mailApps: result.options,
          );
        },
      );
    }
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
