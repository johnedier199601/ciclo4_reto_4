import 'package:app_geolocalizacion/controlador/ControladorGeneral.dart';
import 'package:app_geolocalizacion/interface/listar.dart';
import 'package:app_geolocalizacion/procesos/peticiones.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Reto 4',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'App Geolocalización'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ControladorGeneral control = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Alert(
                        title: "ATENCION!!!!",
                        desc:
                            "Esta seguro que desea ELIMINAR TODAS las ubicaciones?",
                        type: AlertType.error,
                        buttons: [
                          DialogButton(
                              color: Colors.green,
                              child: Text("SI"),
                              onPressed: () {
                                peticionesDB.EliminarTodasLasPosicion();
                                control.CargarTodaLaBaseDeDatos();
                                Navigator.pop(context);
                              }),
                          DialogButton(
                              color: Colors.red,
                              child: Text("NO"),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                        context: context)
                    .show();
              },
              icon: Icon(Icons.delete_forever_outlined))
        ],
      ),
      body: listar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Alert(
                  title: "ATENCION!!!!",
                  desc: "Esta seguro que desea almacenar su ubicacion?",
                  type: AlertType.success,
                  buttons: [
                    DialogButton(
                        color: Colors.green,
                        child: Text("SI"),
                        onPressed: () {
                          peticionesDB.GuardarPosicion(
                              "123456.789012", DateTime.now().toString());
                          control.CargarTodaLaBaseDeDatos();
                          Navigator.pop(context);
                        }),
                    DialogButton(
                        color: Colors.red,
                        child: Text("NO"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                  context: context)
              .show();
          //peticionesDB.GuardarPosicion(
          //   "123456.789012", DateTime.now().toString());
        },
        child: Icon(Icons.location_history),
      ),
    );
  }
}
