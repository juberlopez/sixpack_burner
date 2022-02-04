import 'package:sixpackburner/presentations/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppField extends StatelessWidget {
  final FormGroup form;
  final String formControlName;
  final String? focusNextControlName;
  final String labelText;
  final Color labelTextColor;
  final bool readOnly;
  final Function? onTap;
  final String urlImg;
  final bool prefix;
  final bool obscureText;
  final TextInputType keyboardType;
  final Map<String, String> Function(FormControl<Object?>)? validationMessages;

  const AppField(
      {Key? key,
      required this.form,
      required this.formControlName,
      this.focusNextControlName,
      this.labelText = "",
      this.onTap,
      this.readOnly = false,
      this.urlImg = "",
      this.prefix = false,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.labelTextColor = AppTheme.quaternaryColor,
      this.validationMessages})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Container(
        height: 80,
        child: Row(
          children: [
           
            prefix
                ? Container(
                    width: 30,
                    height: 30,
                    child: urlImg.length > 0
                        ? new Image.asset(
                            urlImg,
                          )
                        : null,
                  )
                : Container(),
            
            Expanded(
              child: ReactiveTextField(
                
                inputFormatters: keyboardType == TextInputType.number
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : [],
                     textInputAction: TextInputAction.done,
                autofocus: false,
                obscureText: obscureText,
                keyboardType: keyboardType,
                readOnly: readOnly,
                formControlName: formControlName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.primaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppTheme.tertiaryColor)),
            fillColor: Colors.white54, filled: true,
                  labelText: labelText,
                  
                  focusedBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.blue)),
                  labelStyle: TextStyle(
                               color: labelTextColor == null
                          ? AppTheme.primaryColor
                          : labelTextColor),
                ),
                onTap: () => onTap!(),
                onSubmitted: () {
                  if (focusNextControlName != null) {
                    form.focus(focusNextControlName!);
                  }
                },
                validationMessages: validationMessages != null
                    ? validationMessages
                    : (errors) => {
                          ValidationMessage.required: 'Campo es requerido',
                        },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
