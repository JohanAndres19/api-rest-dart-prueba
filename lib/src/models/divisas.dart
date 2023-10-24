
import 'package:divisasback/src/services/DB/postConnection.dart';

class DivisasModel{
  
  static getAll(PostConnection connection) async{
    final query =await connection.query('SELECT * FROM divisa');
    return query;  
  }



  static create (var input, PostConnection? connection) async{
    await connection?.query('''INSERT INTO divisa  VALUES ('${input['id']}','${input['PaisEmisor']}','${input['simbolo']}')''');
    return {'message':"Divisa creada","statusCode":201}; 
  
  }

  static remove ({var id,PostConnection? connection})async{
    final query1= await connection?.query('''select * from divisa  where iddivisa='${id}';''');
    if (query1.isEmpty) {
      return {'message': 'No hay Tasas de cambio para la divisa',"statusCode":404};
    }
    await connection?.query('''DELETE FROM divisa WHERE iddivisa='${id}';''');
  }
}