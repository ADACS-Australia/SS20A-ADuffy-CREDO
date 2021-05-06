import 'dart:io';
import 'package:credo_transcript/models/detection.dart';
import 'package:http/http.dart';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

import 'package:credo_transcript/models/identity_info.dart';
import 'package:credo_transcript/models/login.dart';
import 'package:credo_transcript/models/login_response.dart';
import 'package:credo_transcript/network/rest_api_client.dart';
import 'package:credo_transcript/utils/prefs.dart';
import '../Hit.dart';

class CredoRepository {
  // creates a singelton class to be loaded once regardless of number of calls
  CredoRepository._privateConstructor();
  static final CredoRepository _credoRepository =
      CredoRepository._privateConstructor();
  factory CredoRepository() => _credoRepository;

  void init() {
    //loads system and device information
    _getIdentityInfo();
  }

  IdentityInfo _identityInfo;
  RestApiClient _apiClient = RestApiClient(Client());

  Future<void> _getIdentityInfo() async {
    // to get device information
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // to get system and application information
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    //device ID
    String deviceId;
    // os - phone/tablet
    String deviceType;
    // device model
    String deviceModel;
    //application version
    String appVersion;
    //system sdk
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

    _identityInfo = IdentityInfo(
        deviceId, deviceType, deviceModel, appVersion, systemVersion);
  }

  Future<void> requestLogin(String login, String password) async {
    LoginResponse loginResponse;

    if (login.contains('@')) {
      print("login by email");
      loginResponse = await _apiClient
          .login(LoginByEmailRequest(login, password, _identityInfo));
    } else {
      print("login by username");
      loginResponse = await _apiClient
          .login(LoginByUsernameRequest(login, password, _identityInfo));
    }

    // Authorisation token returned from server to be used for subsequent requests
    var _token = loginResponse?.token;

    // Saving token, username and password in shared preferences
    if (_token != null) {
      Prefs.setPref(Prefs.USER_TOKEN, _token);
      Prefs.setPref(Prefs.USER_LOGIN, loginResponse.username);
      Prefs.setPref(Prefs.USER_PASSWORD, password);
    }
  }

  // print preferences for debugging purposes
  void _printPrefs() async {
    print(await Prefs.getPref(Prefs.USER_TOKEN));
    print(await Prefs.getPref(Prefs.USER_LOGIN));
    print(await Prefs.getPref(Prefs.USER_PASSWORD));
  }

  //clear preferences upon logout
  Future<void> clearPrefs() async {
    try {
      bool tokenRemoved = await Prefs.removePref(Prefs.USER_TOKEN);
      bool loginRemoved = await Prefs.removePref(Prefs.USER_LOGIN);
      bool passwordRemoved = await Prefs.removePref(Prefs.USER_PASSWORD);

      if (tokenRemoved && loginRemoved && passwordRemoved) {
        return true;
      } else {
        throw Exception("Logout failed!");
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> requestSendHit(Hit hit) async {
    // _getIdentityInfo();
    await _apiClient.sendHit(DetectionRequest([hit], _identityInfo));
  }

  Future<bool> checkSavedLogin() async {
    var savedLogin = await Prefs.getPref(Prefs.USER_LOGIN);
    var savedPassword = await Prefs.getPref(Prefs.USER_PASSWORD);

    return (savedLogin != null && savedPassword != null);
  }
}
