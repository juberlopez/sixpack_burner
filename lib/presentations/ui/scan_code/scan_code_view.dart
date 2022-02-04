import 'package:sixpackburner/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:sixpackburner/presentations/ui/poll/view/poll_view.dart';
import 'package:sixpackburner/presentations/ui/scan_code/form_code_view.dart';
import 'package:sixpackburner/presentations/ui/widgets/loading_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widget/scan_code_widget.dart';

class ScanCodeView extends StatefulWidget {
  static final String routeName = 'scan_code_View';
  const ScanCodeView({Key? key}) : super(key: key);

  @override
  _ScanCodeViewState createState() => _ScanCodeViewState();
}

class _ScanCodeViewState extends State<ScanCodeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext contextScan) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthenticationCubit, AuthenticationState>(
          listenWhen: (previous, current) =>
              previous.statusQr != current.statusQr,
          listener: (context, state) {
            if (state.statusQr == StatusAuthentication.initial_save_code) {
              // Navigator.pushNamed(context, FormCodeView.routeName);
                   Navigator.pushNamed(context, PollView.routeName);
            }
          },
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment(6.123234262925839e-17, 1),
                      end: Alignment(-1, 6.123234262925839e-17),
                      colors: [
                        Color.fromRGBO(40, 73, 240, 1),
                        Color.fromRGBO(0, 170, 255, 1)
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      "¡YA CASI ESTÁS LISTO!",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/logo_reto.png',
                      width: 150,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "Por favor escanea el código QR que aparece dentro del producto Burner Stack, para validar tu registro.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'assets/images/TAPA_SCAN.png',
                        width: 300,
                      ),
                      onTap: () {
                        showBottomModal(contextScan);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "¿No has comprado aún el Burner Stack?",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () async {
                          
                           await launch(
                             'https://www.nutramerican.com/producto/burnerstack_'
                            );
                          //Navigator.pushNamed(context, RegisterView.routeName);
                        },
                        child: Text(
                          '¡Cómpralo aquí ahora mismo!',
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                          ),
                        )),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
              _buildLoading(contextScan)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext contextDialogo) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      buildWhen: (previous, current) => previous.statusQr != current.statusQr,
      builder: (context, state) {
        return state.statusQr == StatusAuthentication.loading
            ? LoadingIndicator()
            : Container();
      },
    );
  }

  void showBottomModal(
    BuildContext contextCode,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: contextCode,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 1,
              child: ScanCodeWidget(
                onTap: (code) {
                  BlocProvider.of<AuthenticationCubit>(contextCode)
                      .registerCode(code);
                  //Navigator.of(contextCode).pop();
                },
              ));
        });
  }
}
