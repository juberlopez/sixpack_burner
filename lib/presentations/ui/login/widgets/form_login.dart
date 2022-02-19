import 'package:sixpackburner/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:sixpackburner/presentations/services/screen_messages_service.dart';
import 'package:sixpackburner/presentations/ui/widgets/buttons/app_button.dart';
import 'package:sixpackburner/presentations/ui/widgets/fields/app_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'modal_form_mail.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FormGroup buildForm() => fb.group({
          'correo':
              FormControl<String>(value: "", validators: [Validators.required]),
          'contrasena':
              FormControl<String>(value: "", validators: [Validators.required]),
        });
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
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
                                keyboardType: TextInputType.text,
                                form: form,
                                formControlName: "correo",
                                labelText: "Correo",
                                onTap: () => {},
                              ),
                              AppField(
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                form: form,
                                formControlName: "contrasena",
                                labelText: "Contraseña",
                                onTap: () => {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /*Row(
                    children: [
                      Expanded(child: Container()),
                      TextButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, RegisterView.routeName);
                      },
                      child: Text(
                        '¿Has olvidado la contraseña?',
                        style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          color: Colors.grey,
                        ),
                      )),
                    ],
                  ),*/
                    ModalFormMail(),
                    Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child: RichText(
                          text: TextSpan(
                              text: 'Al iniciar sesión, aceptas la ',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Quicksand',
                                color: Color(0xffA4A4A4),
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Política de privacidad',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Quicksand',
                                        color: Color(0xffA4A4A4),
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await launch(
                                            'https://retoburnerstack.megaplexstars.com/#policy');
                                        // open desired screen
                                      }),
                                TextSpan(
                                    text: ' y los ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Quicksand',
                                      color: Color(0xffA4A4A4),
                                    )),
                                TextSpan(
                                    text: ' Términos de uso ',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Quicksand',
                                        color: Color(0xffA4A4A4),
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        await launch(
                                            'https://retoburnerstack.megaplexstars.com/#conditions');
                                        }),
                                TextSpan(
                                    text: ' de Megaplex Stars.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Quicksand',
                                      color: Color(0xffA4A4A4),
                                    ))
                              ]),
                        ))),
                    
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: AppButton(
                              label: '¡UNIRME YA!',
                              onPressed: () {
                                if (form.valid) {
                                  BlocProvider.of<AuthenticationCubit>(context)
                                      .signInwithEmail(
                                          form.control("correo").value,
                                          form.control("contrasena").value, context);
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
              }),
        ],
      ),
    );
  }
}
