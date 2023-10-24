import 'package:angel3_framework/angel3_framework.dart';
import 'package:file/file.dart';
import 'Controllers/divisasroutes.dart' as routesdv;
AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) {
    /* 
    app.get('/divisas', (req, res) async {
      final query = req.container?.make<PostConnection>();
      final data = await query?.query('SELECT * FROM divisa');
      res.json(data);
    });


    app.get('/divisas/:id', (req, res)async {
      final query = req.container?.make<PostConnection>();
      final data = await query?.query('''select * from tasadecambio as t where t.iddivisaapkfk='${req.params['id']}';''');
      if(data.isEmpty){
        res.statusCode=404;
        res.json({'message':'No hay Tasas de cambio para la divisa'});
      }else{
        res.json(data);
      }
    });

    app.post('/divisas', (req, res)async{
      await req.parseBody();
      final params = req.container?.make<Map<String,Zod>>();
      final zod =Zod.validate(data:req.bodyAsMap, params: params!);
      if(!zod.isNotValid){
        final query = req.container?.make<PostConnection>();
        await query?.query('''INSERT INTO divisa  VALUES ('${req.bodyAsMap['id']}','${req.bodyAsMap['PaisEmisor']}','${req.bodyAsMap['simbolo']}')'''); 
        res.statusCode=201;
      }else{
        res.statusCode=400;
      }

    }); */
    app.configure(routesdv.configureServer);
  };
}

/** 
 * endpoints:
 * 
 * divisas 
 * 
 * 
 * 
*/