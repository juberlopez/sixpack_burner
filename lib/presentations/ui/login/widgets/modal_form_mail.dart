import 'package:sixpackburner/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:sixpackburner/presentations/services/screen_messages_service.dart';
import 'package:sixpackburner/presentations/ui/widgets/buttons/app_button.dart';
import 'package:sixpackburner/presentations/ui/widgets/fields/app_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ModalFormMail extends StatelessWidget {
  const ModalFormMail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container()),
        TextButton(
            onPressed: () {
              forgotPasswordDialog(context);
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
    );
  }

  forgotPasswordDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          FormGroup buildForm() => fb.group({
                'correo': FormControl<String>(
                    value: "", validators: [Validators.required]),
              });
          return AlertDialog(
            title: Text(
              'Restablecer contraseña',
              style: TextStyle(color: Colors.black),
            ),
            content: Container(
              height: 200,
              child: Column(
                children: [
                  Text(
                    'Te enviaremos un correo para que restablescas tu contraseña',
                    style: TextStyle(color: Colors.black),
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
                                        keyboardType: TextInputType.text,
                                        form: form,
                                        formControlName: "correo",
                                        labelText: "Correo",
                                        onTap: () => {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: AppButton(
                                      label: 'Cancelar',
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    child: AppButton(
                                      label: 'Enviar',
                                      onPressed: () async {
                                        if (form.valid) {
                                          await BlocProvider.of<
                                                  AuthenticationCubit>(context)
                                              .restorePassword(
                                            form.control("correo").value,
                                          );

                                          openMail(context);
                                          Navigator.of(context).pop();
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
                      })
                ],
              ),
            ),
          );
        });
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
