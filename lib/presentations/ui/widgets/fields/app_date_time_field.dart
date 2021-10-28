
import 'package:burnet_stack/presentations/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:reactive_forms/reactive_forms.dart';

class AppDateTimeField extends StatefulWidget {
  final FormGroup form;
  final String formControlName;
  //final String focusNextControlName;
  final String labelText;
  final Function onChange;

  const AppDateTimeField(
      {Key? key,
      required this.form,
      this.formControlName = "",
      this.labelText = "",
      //required this.focusNextControlName,
      required this.onChange})
      : super(key: key);

  @override
  _AppDateTimeFieldState createState() => _AppDateTimeFieldState();
}

class _AppDateTimeFieldState extends State<AppDateTimeField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:30.0),
      child: ReactiveTextField(
        readOnly: true,
        formControlName: widget.formControlName,
        decoration: InputDecoration(
          fillColor: AppTheme.tertiaryColor,
          labelText: widget.labelText,
          focusedBorder: new UnderlineInputBorder(
              borderSide:
                  new BorderSide(color: AppTheme.tertiaryColor)),
          labelStyle: TextStyle(color: AppTheme.tertiaryColor),
        ),
        onTap: () async {
          final newDateTime = await showDatePicker(
              context: context,
              initialDate: DateTime.now().subtract(Duration(days: 1)),
              firstDate: DateTime(DateTime.now().year - 1),
              lastDate: DateTime(DateTime.now().year + 1),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppTheme.tertiaryColor,
                      surface: AppTheme.tertiaryColor,
                    ),
                  ),
                  child: child as Widget,
                );
              });

          if (newDateTime != null) {
            var formatDate =
                "${newDateTime.day.toString().padLeft(2, '0')}-${newDateTime.month.toString().padLeft(2, '0')}-${newDateTime.year}";
            var formatDateInv =
                "${newDateTime.year}-${newDateTime.month.toString().padLeft(2, '0')}-${newDateTime.day.toString().padLeft(2, '0')}";

            widget.form.control(widget.formControlName).value = formatDate;

            var dataTime = formatDateInv;

            widget.onChange(dataTime);
          }
        },
        onSubmitted: () {
          /*if (widget.focusNextControlName != null) {
            widget.form.focus(widget.focusNextControlName);
          }*/
        },
        validationMessages: (errors) => {
          ValidationMessage.required: 'Campo es requerido',
        },
      ),
    );
  }
}
