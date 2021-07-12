import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'exceptions.dart';


class APIBaseHelper{
  static const String _baseUrl = "https://api.credo.science/api/v2";

  final _client = http.Client();

  // APIBaseHelper(this._client);

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await _client.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {Map<String,String> headers = const {HttpHeaders.contentTypeHeader: "application/json"}, dynamic body}) async {
    var responseJson;
    try {
      final response = await _client.post("$_baseUrl$url",
        headers: headers,
        body: body,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    print("Response code: ${response.statusCode}");
    var responseJson = json.decode(response.body.toString());
    print(responseJson);

    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 400:
        throw BadRequestException(responseJson['message']);
      case 401:
      case 403:
        throw UnauthorisedException(responseJson['message']);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}



