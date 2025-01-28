import 'package:flutter_dotenv/flutter_dotenv.dart';

String get serverUri {
  String connectionScheme = dotenv.env['CONNECTION_SCHEME']!;
  String connectionIp = dotenv.env['CONNECTION_IP']!;
  String connectionPort = dotenv.env['CONNECTION_PORT']!;
  
  return '$connectionScheme://$connectionIp:$connectionPort';
}