import 'package:foodyore/services/app_config.dart' as auth_config;

String AuthKey = 'ded0031e0f7923758ed2ff7a53b6ac8c';
String AuthToken = '';
setHeaders() {
  print("==============================$AuthKey");

  return {'X-API-Key': '$AuthKey'};
}

setHeaders2() {
  AuthKey = auth_config.getAuthToken();

  print("==============================1$AuthKey");

  return {'Content-Type': 'application/json', 'X-API-Key': '$AuthKey'};
}

void pr(dynamic params, {int lineNumber = 1}) {
  List lines = StackTrace.current.toString().trimRight().split('\n');
  printLongString('\x1B[34m$params\x1B[0m');
  printLongString(
    '\x1B[36mRef#----------------------------------------------------------------------${DateTime.now()} -' +
        lines[lineNumber] +
        '\x1B[0m',
  );
}

void printLongString(String text) {
  final RegExp pattern = RegExp('.{8,800}');
  pattern
      .allMatches(text)
      .forEach((RegExpMatch match) => print(match.group(0)));
}
