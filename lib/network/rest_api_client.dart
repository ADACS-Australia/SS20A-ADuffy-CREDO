import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import '../models/detection.dart';
import '../models/login.dart';
import '../utils/prefs.dart';
import '../models/login_response.dart';
import '../models/user.dart';

class  RestApiClient{
  /// CREDO REST API client
  /// handles all requests to and responses from CREDO endpoint
 
  // CREDo endpoint
  static const String _endpoint = "https://api.credo.science/api/v2";
  // HTTP client
  final Client _client;

  RestApiClient(this._client);

  
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    /// sends login post request
    
    var requestJson = jsonEncode(loginRequest);
    print("Login Request: $requestJson");

    final response = await _client.post(
      "$_endpoint/user/register",
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: requestJson);

    if(response.statusCode != 200)
    {
      print(response.body);
      throw new Exception('Cannot login! Something went wrong');
    }
    
    final responseJson = jsonDecode(response.body);
    print("Response: $responseJson");
    return LoginResponse.fromJson(responseJson);
  }

  Future<dynamic> sendHit(DetectionRequest detectionRequest) async {

    // Retrieve authorisation token from SharedPreferences
    String token = await Prefs.getPrefString(Prefs.USER_TOKEN);

    var requestJson = jsonEncode(detectionRequest);
    print("Detection Request: $requestJson");

    final response = await _client.post(
      "$_endpoint/detection",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token",
      },
      body: requestJson);

      if(response.statusCode != 200)
      {
        print(response.body);
        throw new Exception('Cannot send hits! Something went wrong');
      }

    //print hits Id's as JSON, ex. {"detections": [{id=100},{id=101} ]}, returned from server
    print(jsonDecode(response.body));
    
  }

  Future<dynamic> requestRegister(RegisterRequest registerRequest) async {

    var requestJson = jsonEncode(registerRequest);
    print("Register Request: $requestJson");

    final response = await _client.post(
      "$_endpoint/detection",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: requestJson);

      if(response.statusCode != 200)
      {
        print(response.body);
        throw new Exception('Cannot register! Something went wrong');
      }

    print(jsonDecode(response.body));
    
  }

  Future<dynamic> requestUpdateUser(UpdateUserRequest updateUserRequest) async {

    // Retrieve authorisation token from SharedPreferences
    String token = await Prefs.getPrefString(Prefs.USER_TOKEN);
    
    var requestJson = jsonEncode(updateUserRequest);
    print("Update User Request: $requestJson");

    final response = await _client.post(
      "$_endpoint/user/info",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token",
      },
      body: requestJson);

      if(response.statusCode != 200)
      {
        print(response.body);
        throw new Exception('Cannot update user info! Something went wrong');
      }

    final responseJson = jsonDecode(response.body);
    print("Response: $responseJson");
    return UserInfoResponse.fromJson(responseJson);
    
  }

}