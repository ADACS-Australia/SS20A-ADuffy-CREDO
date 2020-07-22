import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:http/http.dart';
import 'package:package_info/package_info.dart';
import 'package:credo_transcript/models/identity_info.dart';
import 'package:credo_transcript/models/login.dart';
import 'package:credo_transcript/models/login_response.dart';
import 'package:credo_transcript/network/rest_api_client.dart';
import 'package:credo_transcript/utils/prefs.dart';


class CredoRepository{

  CredoRepository._privateConstructor();
  static final CredoRepository _credoRepository = CredoRepository._privateConstructor();
  factory CredoRepository() => _credoRepository;

  IdentityInfo _identityInfo;
  String _token;
  RestApiClient _apiClient = RestApiClient(Client());

  Future<void> _getIdentityInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String deviceId;
    String deviceType;
    String deviceModel;
    String appVersion;
    String systemVersion;
    
    appVersion = packageInfo.version;
    

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      
      deviceId = androidInfo.androidId;
      systemVersion = androidInfo.version.sdkInt.toString();
      deviceModel = androidInfo.model;
      deviceType = androidInfo.device;
      } else {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
      systemVersion = iosInfo.systemVersion;
      deviceModel = iosInfo.model;
      deviceType = iosInfo.systemName;
    }

    _identityInfo = IdentityInfo(deviceId, deviceType, deviceModel, appVersion, systemVersion);
  }

  Future<void> requestLogin(String login, String password) async {
    _getIdentityInfo();
    LoginResponse loginResponse;

    if(login.contains('@')){
      print("login by email");
      loginResponse =  await _apiClient.login(LoginByEmailRequest(login, password, _identityInfo));
    }
    else {
      print("login by username");
      loginResponse =  await _apiClient.login(LoginByUsernameRequest(login, password, _identityInfo));
    }
    print(loginResponse?.username);
    _token = loginResponse?.token;

    // Saving token, username and password in shared preferences 
    if(_token != null){
      Prefs.setPref(Prefs.USER_TOKEN, _token);
      Prefs.setPref(Prefs.USER_LOGIN, loginResponse.username);
      Prefs.setPref(Prefs.USER_PASSWORD, password);
    }
    _printPrefs();
  }

  void _printPrefs()async{
    print(await Prefs.getPref(Prefs.USER_TOKEN));
    print(await Prefs.getPref(Prefs.USER_LOGIN));
    print(await Prefs.getPref(Prefs.USER_PASSWORD));
  }

  
}  
  
  