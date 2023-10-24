
import 'package:divisasback/src/services/DB/postConnection.dart';

class DivisasModel{
  
  static Future<dynamic> getAll(PostConnection connection) async{
    final query =await connection.query('SELECT * FROM divisa');
    return query;  
  }



  static Future<dynamic> create (var input, PostConnection? connection) async{
    await connection?.query('''INSERT INTO divisa  VALUES ('${input['id']}','${input['PaisEmisor']}','${input['simbolo']}')''');
    return {'message':"Divisa creada","statusCode":201}; 
  
  }

  static Future<dynamic> remove ({var id,PostConnection? connection})async{
    final query1= await connection?.query('''select * from divisa  where iddivisa='${id}';''');
    if (query1.isEmpty) {
      return {'message': 'No hay divisa para eliminar',"statusCode":404};
    }
    await connection?.query('''DELETE FROM divisa WHERE iddivisa='${id}';''');
    return {'message':"Divisa eliminada","statusCode":200};
  }
}