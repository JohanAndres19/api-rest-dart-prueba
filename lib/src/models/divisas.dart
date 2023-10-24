
import 'package:divisasback/src/services/DB/postConnection.dart';

class DivisasModel{
  
  static getAll(PostConnection connection) async{
    final query =await connection.query('SELECT * FROM divisa');
    return query;  
  }

  static getByIdCambio({var id , PostConnection? connection}) async{
    final query =await connection?.query('''select * from tasadecambio as t where t.iddivisaapkfk='${id}';''');
    if (query.isEmpty) {
      return {'message': 'No hay Tasas de cambio para la divisa',"statusCode":404};
    }
    return {'message':query,"statusCode":200}; 
    
  }

  static create (var input, PostConnection? connection) async{
    await connection?.query('''INSERT INTO divisa  VALUES ('${input['id']}','${input['PaisEmisor']}','${input['simbolo']}')''');
    return {'message':"Divisa creada","statusCode":201}; 
  
  }

  static remove ({var id,PostConnection? connection})async{
    final query1= await connection?.query('''select * from divisa  where iddivisa='${id}';''');
    final query2 = await connection?.query('''select * from tasadecambio as t where t.iddivisaapkfk='${id}';''');
    switch([query1.length,query2.length]){
      case [0,0]:
        return {'message':"Divisa no encontrada","statusCode":404};
      case [1,0]:
        await connection?.query('''delete from divisa  where iddivisa='${id}';''');
        return {'message':"Divisa eliminada","statusCode":200};
      case [1,1]:
        await connection?.query('''delete from divisa  where iddivisa='${id}';''');
        await connection?.query('''delete from tasadecambio  where iddivisaapkfk='${id}';''');
        return {'message':"Divisa eliminada y sus cambios","statusCode":200};  
    }
  }
}