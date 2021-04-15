import 'package:flutter/material.dart';

extension Extra on TimeOfDay {

  String formated(){
    return '${hour}h:${minute.toString().padLeft(2, '0')}';
  }
}