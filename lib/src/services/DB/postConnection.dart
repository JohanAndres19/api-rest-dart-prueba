import 'dart:convert';

import 'package:postgres/postgres.dart';

class PostConnection {
  Future<dynamic> query(String query) async {
    final connect = PostgreSQLConnection(
      'ep-soft-hat-93009920.us-east-2.aws.neon.fl0.io', // dirección del servidor PostgreSQL
      5432, // puerto del servidor PostgreSQL
      'Divisas', // nombre de la base de datos
      username: 'fl0user', // nombre de usuario
      password: 'QCXz9icZdjg6', // contraseña
      useSSL: true,
      encoding: Encoding.getByName('utf8'),
    );
    try {
      await connect.open();
      final data = await connect.mappedResultsQuery(query);
      await connect.close();
      return data;
    } catch (e) {
      print("Ouch fallo la conexion con la base de datos");
      print(e);
    }
  }
}
