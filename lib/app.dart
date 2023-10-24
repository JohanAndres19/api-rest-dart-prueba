import 'package:angel3_framework/angel3_framework.dart';
import 'package:file/local.dart';
import 'src/services/service.dart' as service;
import 'src/routes/route.dart' as routes;


Future configureServer( Angel app) async{
  var fs = const LocalFileSystem();
  await app.configure(service.configureServer);
  await app.configure(routes.configureServer(fs));
}