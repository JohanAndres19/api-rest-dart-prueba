import 'dart:io';

import 'package:angel3_container/mirrors.dart';
import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_hot/angel3_hot.dart';
import 'package:belatuk_pretty_logging/belatuk_pretty_logging.dart';
import 'package:logging/logging.dart';
import 'package:divisasback/app.dart';



void main() async {
  hierarchicalLoggingEnabled = true;

  var hot = HotReloader(() async{
    var logger = Logger.detached('Angel3')
      ..level = Level.ALL
      ..onRecord.listen(prettyLog);   
    var app = Angel(logger: logger,reflector: MirrorsReflector());
    await app.configure(configureServer);
    return app;

  },[Directory('lib')]);

  var server = await hot.startServer('127.0.0.1',4000);
  print('[Angel3] server listening at http://${server.address.address}:${server.port}');

}
