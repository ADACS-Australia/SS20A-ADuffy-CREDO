import 'dart:convert';
import 'dart:io';

import 'package:credo_transcript/models/login.dart';
import 'package:http/http.dart';

import '../Hit.dart';
import '../models/login_response.dart';

class  RestApiClient{

  static const String _endpoint = "https://api.credo.science/api/v2";
  final Client _client;

  RestApiClient(this._client);

  Future<LoginResponse> login(LoginRequest loginRequest) async {

    final response = await _client.post(
      "$_endpoint/user/login",
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: jsonEncode(loginRequest));

    if(response.statusCode != 200)
    {
      print(response.body);
      throw new Exception('Cannot login! SOmething went wrong');
    }
    

    final json = jsonDecode(response.body);
    return LoginResponse.fromJson(json);
  }

  Future<void> sendHit(Hit hit, String token) async {
    final response = await _client.post(
      "$_endpoint/detection",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token",
      },
      body: jsonEncode(hit));

  }

}