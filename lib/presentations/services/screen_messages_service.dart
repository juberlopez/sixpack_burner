

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ScreenMessagesService {
toast(String msgS){
  return Fluttertoast.showToast(
        msg: msgS,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0
    );
}
  
}