import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import '../models/detection.dart';
import '../models/login.dart';
import '../utils/prefs.dart';
import '../models/login_response.dart';
import '../models/user.dart';
import 'api_base_helper.dart';

class  RestApiClient{
  /// CREDO REST API client
  /// handles all requests to and responses from CREDO endpoint
 
  // CREDO endpoint
  // static const String _endpoint = "https://api.credo.science/api/v2";
  // HTTP client
  // final Client _client = Client();

  // RestApiClient(this._client);

  APIBaseHelper _helper = APIBaseHelper();

  
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    /// sends login post request
    
    var requestJson = jsonEncode(loginRequest);
    print("Login Request: $requestJson");

    final responseJson = await _helper.post(
      "/user/login",
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: requestJson);
    return LoginResponse.fromJson(responseJson);
  }

  Future<dynamic> sendHit(DetectionRequest detectionRequest) async {

    // Retrieve authorisation token from SharedPreferences
    String token = await Prefs.getPrefString(Prefs.USER_TOKEN);

    var requestJson = jsonEncode(detectionRequest);
    print("Detection Request: $requestJson");

    final responseJson = await _helper.post(
      "/detection",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token",
      },
      body: requestJson);

      // if(response.statusCode != 200)
      // {
      //   print(response.body);
      //   throw new Exception('Cannot send hits! Something went wrong');
      // }

    //print hits Id's as JSON, ex. {"detections": [{id=100},{id=101} ]}, returned from server
    print(responseJson);
    
  }

  Future<dynamic> register(RegisterRequest registerRequest) async {

    var requestJson = jsonEncode(registerRequest);
    print("Register Request: $requestJson");

    final responseJson = await _helper.post(
      "/user/register",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: requestJson);

      // if(response.statusCode != 200)
      // {
      //   print(response.body);
      //   throw new Exception('Cannot register! Something went wrong');
      // }

    print(responseJson);
    
  }

  Future<dynamic> updateUser(UpdateUserRequest updateUserRequest) async {

    // Retrieve authorisation token from SharedPreferences
    String token = await Prefs.getPrefString(Prefs.USER_TOKEN);
    
    var requestJson = jsonEncode(updateUserRequest);
    print("Update User Request: $requestJson");

    final responseJson = await _helper.post(
      "/user/info",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Token $token",
      },
      body: requestJson);

      // if(response.statusCode != 200)
      // {
      //   print(response.body);
      //   throw new Exception('Cannot update user info! Something went wrong');
      // }

    // final responseJson = jsonDecode(response.body);
    // print("Response: $responseJson");
    return UserInfoResponse.fromJson(responseJson);
    
  }

}