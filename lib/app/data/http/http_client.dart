import 'dart:io';

import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String url});
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };

  @override
  Future get({required String url}) async {
    return await client.get(Uri.parse(url), headers: headers);
  }

}