import 'package:app_geolocalizacion/procesos/peticiones.dart';
import 'package:get/get.dart';

class ControladorGeneral extends GetxController {
  final Rxn<List<Map<String, dynamic>>> _ListaDePosiciones =
      Rxn<List<Map<String, dynamic>>>();
  final _unaPosicion = "".obs;

  void cargarUnaPosicion(String x) {
    _unaPosicion.value = x;
  }

  String get unaPosicion => _unaPosicion.value;

  void CargarListaDePosiciones(List<Map<String, dynamic>> x) {
    _ListaDePosiciones.value = x;
  }

  List<Map<String, dynamic>>? get ListaDePosiciones => _ListaDePosiciones.value;

  Future<void> CargarTodaLaBaseDeDatos() async {
    final datos = await peticionesDB.MostrasTodasLasUbicaciones();
    CargarListaDePosiciones(datos);
  }
}
