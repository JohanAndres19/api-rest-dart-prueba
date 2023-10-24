
import 'package:divisasback/src/services/DB/postConnection.dart';
import 'package:zod_validation/zod_validation.dart';

class TasaCambioModel{
  static getByIdCambio({var id , PostConnection? connection}) async{
    final query =await connection?.query('''select * from tasadecambio as t where t.iddivisaapkfk='${id}';''');
    if (query.isEmpty) {
      return {'message': 'No hay Tasas de cambio para la divisa',"statusCode":404};
    }
    return {'message':query,"statusCode":200}; 
    
  }

  static create ({Map<String, dynamic>? input, PostConnection? connection , var validate}) async{
    var validador=[];
    input?.forEach((key, value) {
      validador.add(Zod.validate(data: value,params: validate).isValid);
    });
    if (validador.any((element) => element==false)) {
      return {'message': 'No se puede crear la Tasa',"statusCode":400};
    }
    try {
      input?.forEach((key, value) async{ 
        await connection?.query('''INSERT INTO tasadecambio  VALUES ('${value?['idA']}','${value?['idB']}','${value?['valor']}')''');

      });
    } catch (e) {
      return {'message': 'No se puede crear la Tasa',"statusCode":400};
    }
    return {'message':"Tasas de cambio creadas","statusCode":201}; 
  }

  static remove ({var id,PostConnection? connection})async{
    final query1= await connection?.query('''select * from tasadecambio  where iddivisaapkfk='${id}';''');
    if (query1.isEmpty) {
      return {'message': 'No hay Tasas de cambio para la divisa',"statusCode":404};
    }
    await connection?.query('''DELETE FROM tasadecambio WHERE iddivisaapkfk='${id}';''');
  }


}