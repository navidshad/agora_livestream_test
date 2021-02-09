import 'package:agora_flutter_test/src/config.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

class TokenGeneratorService {
  final Client _http = Client();

  Future<String> generate(String room) {
    var url = Config.ServerBaseURL + '/rtcToken/?channelName=$room';
    return _http.get(url).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map body = convert.jsonDecode(response.body);
        return body['key'] as String;
      } else {
        throw response;
      }
    });
  }
}
