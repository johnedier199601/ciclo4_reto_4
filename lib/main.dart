import 'package:app_geolocalizacion/controlador/ControladorGeneral.dart';
import 'package:app_geolocalizacion/interface/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(ControladorGeneral());
  runApp(const MyApp());
}
