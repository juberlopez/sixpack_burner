import 'package:burnet_stack/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:burnet_stack/presentations/services/screen_messages_service.dart';
import 'package:burnet_stack/presentations/ui/home/view/home_view.dart';
import 'package:burnet_stack/presentations/ui/poll/view/poll_view.dart';
import 'package:burnet_stack/presentations/ui/widgets/buttons/app_button.dart';
import 'package:burnet_stack/presentations/ui/widgets/fields/app_field.dart';
import 'package:burnet_stack/presentations/ui/widgets/loading_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'widget/scan_code_widget.dart';

class FormCodeView extends StatefulWidget {
  static final String routeName = 'form_code_View';
  const FormCodeView({Key? key}) : super(key: key);

  @override
  _FormCodeViewState createState() => _FormCodeViewState();
}

class _FormCodeViewState extends State<FormCodeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FormGroup buildForm() => fb.group({
          'code':
              FormControl<String>(value: ""),
        });
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset:false,
        body: BlocListener<AuthenticationCubit, AuthenticationState>(
          listenWhen: (previous, current) =>
              previous.statusQr != current.statusQr,
          listener: (context, state) {
            if (state.statusQr == StatusAuthentication.autenticado) {
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        'assets/images/icon_burnerstack_1.png',
                        width: 48,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Ingresa el código del cupón que está en la parte superior de la tapa",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/images/tapa_burner.png',
                        width: 224,
                      ),
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
                                            formControlName: "code",
                                            labelText: "Ingresa tu codigo",
                                            onTap: () => {},
                                            labelTextColor: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container()
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: AppButton(
                                          label: 'Continuar',
                                          onPressed: () async {
                                           // if (form.valid) {
                                              await BlocProvider.of<
                                                          AuthenticationCubit>(
                                                      context)
                                                  .registerCodePlus(form
                                                      .control("code")
                                                      .value);
                                            /*} else {
                                              ScreenMessagesService().toast(
                                                  "Verificar formulario");

                                              form.markAllAsTouched();
                                            }*/
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
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
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == StatusAuthentication.loading
            ? LoadingIndicator()
            : Container();
      },
    );
  }
}
