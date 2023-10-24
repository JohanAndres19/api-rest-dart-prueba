import 'dart:async';

import 'package:angel3_framework/angel3_framework.dart';
import 'package:divisasback/src/models/divisas.dart';
import 'package:divisasback/src/services/DB/postConnection.dart';
import 'package:zod_validation/zod_validation.dart';


Future configureServer(Angel app) async {
    await app.configure(_DivisasController().configureServer);
}

@Expose('/divas')
class _DivisasController extends Controller{

  @Expose('/',method: 'GET')
    Future getAll(RequestContext req, ResponseContext res) async {
      final data=DivisasModel.getAll(req.container!.make<PostConnection>());
      res.json(data);
  }

  @Expose('/:id',method: 'GET')
  Future getByIdCambio(RequestContext req, ResponseContext res) async {
    final data=DivisasModel.getByIdCambio(id: req.params['id'],connection: req.container?.make<PostConnection>());
    res.statusCode=data['statusCode'];
    res.json(data['message']);
  }

  @Expose('/',method: 'POST')
  Future createDivisa(RequestContext req, ResponseContext res) async {
    await req.parseBody();
    final params = req.container?.make<Map<String, Zod>>();
    final zod = Zod.validate(data: req.bodyAsMap, params: params!);
    if (zod.isNotValid) {
      res.statusCode=400;
      res.json({"message":zod.result});
    }
    final data = await DivisasModel.create(req.bodyAsMap, req.container?.make<PostConnection>());
    res.statusCode=data['statusCode'];
    res.json(data['message']);
  }
  @Expose('/tipoCambio',method: 'POST')
  Future createCambio(RequestContext req, ResponseContext res) async {
    await req.parseBody();
    final params = req.container?.make<Map<String, Zod>>();
    final zod = Zod.validate(data: req.bodyAsMap, params: params!);
    if (zod.isNotValid) {
      res.statusCode=400;
      res.json({"message":zod.result});
    }
    final data = await DivisasModel.create(req.bodyAsMap, req.container?.make<PostConnection>());
    res.statusCode=data['statusCode'];
    res.json(data['message']);
  }

  @Expose('/id',method:'DELETE')
  Future removeDivisa(RequestContext req, ResponseContext res) async {
    
    final data = await DivisasModel.remove(id:req.params['id'],connection: req.container?.make<PostConnection>());
    res.statusCode=data['statusCode'];
    res.json(data['message']);
  }

}

 /* final divisasrouter = Router<FutureOr<dynamic> Function(RequestContext<dynamic>, ResponseContext<dynamic>)>()
  ..get('/', (req, res) async {
    final query = req.container?.make<PostConnection>();
    final data = await query?.query('SELECT * FROM divisa');
    res.json(data);
  })
  ..get('/:id', (req, res) async {
    final query = req.container?.make<PostConnection>();
    final data = await query?.query(
        '''select * from tasadecambio as t where t.iddivisaapkfk='${req.params['id']}';''');
    if (data.isEmpty) {
      res.statusCode = 404;
      res.json({'message': 'No hay Tasas de cambio para la divisa'});
    } else {
      res.json(data);
    }
  })
  ..post('/', (req, res) async {
    await req.parseBody();
    final params = req.container?.make<Map<String, Zod>>();
    final zod = Zod.validate(data: req.bodyAsMap, params: params!);
    if (!zod.isNotValid) {
      final query = req.container?.make<PostConnection>();
      await query?.query(
          '''INSERT INTO divisa  VALUES ('${req.bodyAsMap['id']}','${req.bodyAsMap['PaisEmisor']}','${req.bodyAsMap['simbolo']}')''');
      res.statusCode = 201;
    } else {
      res.statusCode = 400;
    }
  }); */


