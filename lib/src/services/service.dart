
import 'package:angel3_framework/angel3_framework.dart';
import 'package:divisasback/src/services/DB/postConnection.dart';
import 'package:zod_validation/zod_validation.dart';

Future configureServer(Angel app)  async {
  try {
    final postconn = PostConnection();
    final params ={
      'id':Zod().type<String>().min(3).max(3).required(),
      'PaisEmisor':Zod().type<String>().max(50).required(),
      'simbolo':Zod().type<String>().max(2).optional(),
    };
    app.container.registerSingleton<PostConnection>(postconn);
    app.container.registerSingleton<Map<String,Zod>>(params);
  } catch (e) {
    
  }
}