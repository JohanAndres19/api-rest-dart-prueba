import 'package:angel3_framework/angel3_framework.dart';
import 'package:file/file.dart';
import 'Controllers/divisasControllers.dart' as routesdv;
AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) {
    app.configure(routesdv.configureServer);
  };
}

