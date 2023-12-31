import 'dart:async';

import 'package:angel3_framework/angel3_framework.dart';
import 'package:divisasback/src/models/divisas.dart';
import 'package:divisasback/src/models/tipodeCambio.dart';
import 'package:divisasback/src/services/DB/postConnection.dart';
import 'package:zod_validation/zod_validation.dart';


Future configureServer(Angel app) async {
    await app.configure(_DivisasController().configureServer);
    await app.configure(_TasaCambioController().configureServer);
}

@Expose('/divisas')
class _DivisasController extends Controller{

  final params ={
      'id':Zod().type<String>().min(3).max(3).required(),
      'PaisEmisor':Zod().type<String>().max(50).required(),
      'simbolo':Zod().type<String>().max(2).optional(),
    };

  @Expose('/',method: 'GET')
    Future getAll(RequestContext req, ResponseContext res) async {
      final data=await DivisasModel.getAll(req.container!.make<PostConnection>());
      res.json(data);
  }


  @Expose('/',method: 'POST')
  Future createDivisa(RequestContext req, ResponseContext res) async {
    await req.parseBody();
    final zod = Zod.validate(data: req.bodyAsMap, params: params);
    if (zod.isNotValid) {
      res.statusCode=400;
      res.json({"message":zod.result});
    }
    final data = await DivisasModel.create(req.bodyAsMap, req.container?.make<PostConnection>());
    res.statusCode=data['statusCode'];
    res.json(data['message']);
  }

  
  @Expose('/:id',method:'DELETE')
  Future removeDivisa(RequestContext req, ResponseContext res) async {
    final data = await DivisasModel.remove(id:req.params['id'],connection: req.container?.make<PostConnection>());
    res.statusCode=data['statusCode'];
    res.json(data['message']);
  }

}

//--------------------------------------------
@Expose('/tasacambio')
class _TasaCambioController extends Controller{

  final params ={
      'idA':Zod().type<String>().min(3).max(3).required(),
      'idB':Zod().type<String>().min(3).max(3).required(),
      'valor':Zod().type<double>().required(),
  };

  @Expose('/:id',method: 'GET')
  Future getByIdCambio(RequestContext req, ResponseContext res) async {
    final data=await TasaCambioModel.getByIdCambio(id: req.params['id'],connection: req.container?.make<PostConnection>());
    res.statusCode=data['statusCode'];
    res.json(data['message']);
  }


  @Expose('/',method: 'POST')
  Future createTasa(RequestContext req, ResponseContext res) async {
    await req.parseBody();
    final data = await TasaCambioModel.create(input:req.bodyAsMap, connection:req.container?.make<PostConnection>(),validate: params);
    res.statusCode=data['statusCode'];
    res.json(data['message']);
  }

  

  @Expose('/:id',method:'DELETE')
  Future removeDivisa(RequestContext req, ResponseContext res) async {
    
    final data = await TasaCambioModel.remove(id:req.params['id'],connection: req.container?.make<PostConnection>());
    res.statusCode=data['statusCode'];
    res.json(data['message']);
  }

}


