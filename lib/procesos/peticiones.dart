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
}
