import 'package:sixpackburner/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:sixpackburner/presentations/services/screen_messages_service.dart';
import 'package:sixpackburner/presentations/ui/theme/app_theme.dart';
import 'package:sixpackburner/presentations/ui/widgets/buttons/app_button.dart';
import 'package:sixpackburner/presentations/ui/widgets/fields/app_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';
import 'dart:ffi';
class FormRegister extends StatefulWidget {
  const FormRegister({Key? key}) : super(key: key);

  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  late List<String> listaCiudades = [];
  late FocusNode _focusNode;
  late String ciudad;
  bool terminos = false;
 String so="IOS";
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    ciudad = "BOGOTA (CUN)";

if (Platform.isAndroid) {
  // Android-specific code
this.so="ANDROID";
} else if (Platform.isIOS) {
  // iOS-specific code
this.so="IOS";
}



  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listaCiudades =
        context.select((AuthenticationCubit b) => b.state.ciudadesPlus);

    
    FormGroup buildForm() => fb.group(
          {
            'nombre': FormControl<String>(
                value: "", validators: [Validators.required]),
            'contrasena': FormControl<String>(
                value: "", validators: [Validators.required]),
            'contrasena_confirmacion': FormControl<String>(
                value: "", validators: [Validators.required]),
            'numero_celular': FormControl<String>(
                value: "", validators: [Validators.required]),
            'correo': FormControl<String>(
                value: '', validators: [Validators.required]),
          },
          [Validators.mustMatch('contrasena', 'contrasena_confirmacion')],
        );
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
                                formControlName: "nombre",
                                labelText: "Nombre Completo",
                                onTap: () => {},
                              ),
                                        SizedBox(
                                height: 10,
                              ),
                                DropdownSearch<String>(
                                  showSearchBox: true,
                                dropdownSearchDecoration: InputDecoration(
                                    filled: true,
                                  contentPadding:EdgeInsets.fromLTRB(12, 12, 0, 0),
                                 border: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.primaryColor)), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.tertiaryColor)),
                                  fillColor: Colors.white,
                                  labelText: "Selecciona la ciudad",
                                   focusedBorder: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.blue)), 
                                   labelStyle: TextStyle(color: AppTheme.quaternaryColor),
                                  ),
                                mode: Mode.BOTTOM_SHEET,
                                showSelectedItem: true,
                                  items: listaCiudades,
                                label: "Ciudad",
                                hint: "Ciudad",
                                onChanged: (data) {
                                  setState(() {
                                    ciudad = data.toString();
                                         print(ciudad);
                                  });
                                },
                                onSaved: (data) {
                                  setState(() {
                                    ciudad = data.toString();
                                    print(ciudad);
                                  });
                                },
                                selectedItem: "BOGOTA (CUN)",
                                validator: (String? item) {
                                  if (item == null)
                                    return "Required field";
                                  else
                                    return null;
                                },
                              ),  
                                 SizedBox(height: 10,),
                                   AppField(
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                form: form,
                                formControlName: "contrasena",
                                labelText: "Ingresa una contraseña",
                                onTap: () => {},
                              ),
                              AppField(
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                form: form,
                                formControlName: "contrasena_confirmacion",
                                labelText: "Repita la contraseña",
                                onTap: () => {},
                                validationMessages: (control)=> {

                                  'mustMatch': 'Contraseña no coincide'
                                },
                              ),
                            
                                 
                                  AppField(
                                keyboardType: TextInputType.phone,
                                form: form,
                                formControlName: "numero_celular",
                                labelText: "Numero celular",
                                onTap: () => {},
                              ),
                          
                            AppField(
                                keyboardType: TextInputType.emailAddress,
                                form: form,
                                formControlName: "correo",
                                labelText: "Correo Electrónico",
                                onTap: () => {},
                              ),
                           
                              /*ReactiveDatePicker<DateTime>(
                                formControlName: 'date',
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2030),
                                builder: (context, picker, child) {
                                  Widget suffix = InkWell(
                                    onTap: () {
                                      _focusNode.unfocus();

                                      _focusNode.canRequestFocus = false;

                                      picker.control.value = null;

                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        _focusNode.canRequestFocus = true;
                                      });
                                    },
                                    child: const Icon(Icons.clear),
                                  );

                                  if (picker.value == null) {
                                    suffix = const Icon(Icons.calendar_today);
                                  }

                                  return ReactiveTextField(
                                      onTap: () {
                                        if (_focusNode.canRequestFocus) {
                                          _focusNode.unfocus();
                                          picker.showPicker();
                                        }
                                      },
                                      valueAccessor: DateTimeValueAccessor(
                                        dateTimeFormat:
                                            DateFormat('dd MMM yyyy'),
                                      ),
                                      focusNode: _focusNode,
                                      formControlName: 'date',
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppTheme.primaryColor)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppTheme.tertiaryColor)),
                                        fillColor: AppTheme.secondaryColor,
                                        labelText: "Fecha de nacimiento",
                                        focusedBorder: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.blue)),
                                        labelStyle: TextStyle(
                                            color: AppTheme.quaternaryColor),
                                      ));
                                },
                              )*/
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Checkbox(value: terminos, onChanged: (data){

                          setState(() {
                            terminos=data!;
                          });

                        }),
                         Expanded(
                           child: Center(
                                  child: RichText(
                                text: TextSpan(
                                    text: 'Al crear tu cuenta, aceptas la ',
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
                                                  'https://sixpackburner.megaplexstars.com/#policy');
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
                                                  'https://sixpackburner.megaplexstars.com/#conditions');
                                              print("data"); // open desired screen
                                            }),
                                      TextSpan(
                                          text: ' de Megaplex Stars.',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Quicksand',
                                            color: Color(0xffA4A4A4),
                                          ))
                                    ]),
                              )),
                         ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: Center(
                    //     child: Text(
                    //       "Consigue una recompensa especial de Megaplex Stars cada año por tu cumpleaños",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         //fontWeight: FontWeight.w300,
                    //         fontFamily: 'Quicksand',
                    //         color: Color(0xffA4A4A4),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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

                                if(terminos){
                                  if (form.valid && ciudad.isNotEmpty) {
                                  BlocProvider.of<AuthenticationCubit>(context)
                                      .registerUser(form, ciudad, so);
                                } else {
                                  ScreenMessagesService()
                                      .toast("Verificar formulario");

                                  form.markAllAsTouched();
                                }

                                }else{
                                  ScreenMessagesService()
                                      .toast(" Debes aceptar términos y condiciones de uso");
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
