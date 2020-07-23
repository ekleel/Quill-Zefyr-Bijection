import 'dart:convert';

void console(String title, {String msg, Object map}) {
  String log = '~QuillZefyrBijection: $title \n';

  if (msg != null) log += '$msg \n';

  if (map != null) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    try {
      String jsonStr = encoder.convert(map);
      log += '$jsonStr';
    } catch (e) {
      log += 'Faild to convert map.';
    }
  }

  print('$log');
}
