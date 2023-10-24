
import 'package:angel3_framework/angel3_framework.dart';
import 'package:divisasback/src/services/DB/postConnection.dart';

Future configureServer(Angel app)  async {
  try {
    final postconn = PostConnection();
    
    app.container.registerSingleton<PostConnection>(postconn);
  } catch (e) {
    
  }
}