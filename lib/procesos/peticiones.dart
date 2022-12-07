import 'package:geolocator/geolocator.dart';
import 'package:sqflite/sqflite.dart' as sql;

class peticionesDB {
  static Future<void> CrearTabla(sql.Database database) async {
    await database.execute(""" CREATE TABLE posiciones(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      coordenadas TEXT,
      fecha TEXT
    ) """);
  }

  static Future<sql.Database> BaseDeDatos() async {
    return sql.openDatabase("minticGeo.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await CrearTabla(database);
    });
  }

  static Future<List<Map<String, dynamic>>> MostrasTodasLasUbicaciones() async {
    final base_de_datos = await peticionesDB.BaseDeDatos();
    return base_de_datos.query("posiciones", orderBy: "fecha");
  }

  static Future<void> EliminarUnaPosicion(int id_posicion) async {
    final base_de_datos = await peticionesDB.BaseDeDatos();
    base_de_datos.delete("posiciones", where: "id=?", whereArgs: [id_posicion]);
  }

  static Future<void> EliminarTodasLasPosicion() async {
    final base_de_datos = await peticionesDB.BaseDeDatos();
    base_de_datos.delete("posiciones");
  }

  static Future<void> GuardarPosicion(coordenadas, fecha) async {
    final base_de_datos = await peticionesDB.BaseDeDatos();
    final datos = {"coordenadas": coordenadas, "fecha": fecha};
    await base_de_datos.insert("posiciones", datos,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
