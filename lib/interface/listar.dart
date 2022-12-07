import 'package:app_geolocalizacion/controlador/ControladorGeneral.dart';
import 'package:app_geolocalizacion/procesos/peticiones.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class listar extends StatefulWidget {
  const listar({super.key});

  @override
  State<listar> createState() => _listarState();
}

class _listarState extends State<listar> {
  ControladorGeneral control = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    control.CargarTodaLaBaseDeDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: control.ListaDePosiciones?.isEmpty == false
              ? ListView.builder(
                  itemCount: control.ListaDePosiciones!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.location_history_rounded),
                        trailing: IconButton(
                            onPressed: () {
                              Alert(
                                      title: "ATENCION!!!!",
                                      desc:
                                          "Esta seguro que desea eliminar esta ubicacion?",
                                      type: AlertType.warning,
                                      buttons: [
                                        DialogButton(
                                            color: Colors.green,
                                            child: Text("SI"),
                                            onPressed: () {
                                              peticionesDB.EliminarUnaPosicion(
                                                  control.ListaDePosiciones![
                                                      index]["id"]);
                                              control.CargarTodaLaBaseDeDatos();
                                              ;
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
                            icon: Icon(Icons.delete_forever_rounded)),
                        title: Text(
                            control.ListaDePosiciones![index]["coordenadas"]),
                        subtitle:
                            Text(control.ListaDePosiciones![index]["fecha"]),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
