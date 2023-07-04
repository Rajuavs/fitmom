import 'dart:convert' show jsonEncode;

import 'package:http/http.dart' as http;

class SendNotification{
Future<dynamic> sendnotificaiton(Map callJdata) async {
  http.Response res = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAS2bsr_M:APA91bEspYKBQCDyp1fF7FbpAwvGiVndNc3bOUDoRPpVX0a1xE7tm5zLO2GPsWM7ITlPmm1PM8lkUe4g4ijqDh4wwabaiU6FYStNRWCLQ3N8xJVlxLEB_6aEBw_Z3d6Rpz3WNH9m8wG0',
    },
    body: jsonEncode(callJdata),
  );
  print("sending notificaotn Response: ${res.body}");
  return res.body;
}

}