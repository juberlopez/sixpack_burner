import 'dart:convert';

import 'package:sixpackburner/presentations/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:sixpackburner/presentations/services/screen_messages_service.dart';
import 'package:sixpackburner/presentations/ui/home/mi_progreso/cubit/mi_progreso_cubit.dart';
import 'package:sixpackburner/presentations/ui/widgets/buttons/app_button.dart';
import 'package:sixpackburner/presentations/ui/widgets/fields/app_field.dart';
import 'package:sixpackburner/presentations/ui/widgets/type_image_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:reactive_forms/reactive_forms.dart';

class ModalFormControl extends StatelessWidget {
  const ModalFormControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: OutlinedButton(
                child: Text('Nuevo Registro'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.blue,
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.blue, width: 1),
                ),
                onPressed: () {
                  forgotPasswordDialog(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  forgotPasswordDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          FormGroup buildForm() => fb.group({
                'peso': FormControl<String>(
                    value: "", validators: [Validators.required]),
              });
          return AlertDialog(
            content: Container(
              height: 500,
              child:  SingleChildScrollView(
                child: Column(
                    children: [
                      _Imagen(),
                      Container(
                        width: double.infinity,
                        child: OutlinedButton(
                          child: Text('TOMAR FOTO'),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.blue,
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.blue, width: 1),
                          ),
                          onPressed: () {
                            context
                                  .read<MiProgresoCubit>()
                                  .imageChanged(ImageSource.camera);
                          },
                        ),
                      ),
                      ReactiveFormBuilder(
                          form: buildForm,
                          builder: (context, form, child) {
                            return Column(
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          AppField(
                                            keyboardType: TextInputType.number,
                                            form: form,
                                            formControlName: "peso",
                                            labelText: "Ingresa tu peso",
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
                                          label: 'Aceptar',
                                          onPressed: () async {
                                            if (form.valid) {
                                               BlocProvider.of<
                                                      MiProgresoCubit>(context)
                                                  .saveProgress(
                                                form.control("peso").value,
                                              );
                
                                              //openMail(context);
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
              
            ),
          );
        });
  }

  void showBottomModal(BuildContext context, Function imege) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return FractionallySizedBox(
              heightFactor: 0.30,
              child: TypeImageSource(
                  onPressed: (imegeSource) => imege(imegeSource)));
        });
  }
}

class _Imagen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MiProgresoCubit, MiProgresoState>(
      buildWhen: (previous, current) =>
          (previous.imagen != current.imagen),
      builder: (context, state) {
        if (state.imagen.isNotEmpty) {
          return Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    child: Image.memory(
                      base64.decode(state.imagen),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )),
            ],
          );
        } else {
          return Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
          );
        }
      },
    );
  }
}
