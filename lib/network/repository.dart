import 'dart:io';
import 'package:credo_transcript/models/detection.dart';
import 'package:credo_transcript/models/user.dart';
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

  late IdentityInfo _identityInfo;
  RestApiClient _apiClient = RestApiClient();

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
    try{
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
      var _token = loginResponse.token;

      // Saving token, username and password in shared preferences
      if (_token != "") {
        Prefs.setPrefString(Prefs.USER_TOKEN, _token);
        Prefs.setPrefString(Prefs.USER_LOGIN, loginResponse.username);
        Prefs.setPrefString(Prefs.USER_PASSWORD, password);
        Prefs.setPrefString(Prefs.USER_DISPLAY_NAME, loginResponse.displayName);
        Prefs.setPrefString(Prefs.USER_EMAIL, loginResponse.email);
        Prefs.setPrefString(Prefs.USER_TEAM, loginResponse.team);
        Prefs.setPrefString(Prefs.USER_LANGUAGE, loginResponse.language);
      }
    } catch(e) {
      print(e);
    }
  }

  // print preferences for debugging purposes
  void _printPrefs() async {
    print(await Prefs.getPrefString(Prefs.USER_TOKEN));
    print(await Prefs.getPrefString(Prefs.USER_LOGIN));
    print(await Prefs.getPrefString(Prefs.USER_PASSWORD));
    print(await Prefs.getPrefString(Prefs.USER_EMAIL));
    print(await Prefs.getPrefString(Prefs.USER_DISPLAY_NAME));
    print(await Prefs.getPrefString(Prefs.USER_TEAM));
    
  }

  //clear preferences upon logout
  Future<void> clearLoginPrefs() async {
    try {
      bool tokenRemoved = await Prefs.removePref(Prefs.USER_TOKEN);
      bool loginRemoved = await Prefs.removePref(Prefs.USER_LOGIN);
      bool passwordRemoved = await Prefs.removePref(Prefs.USER_PASSWORD);
      await Prefs.removePref(Prefs.USER_TEAM);
      await Prefs.removePref(Prefs.USER_EMAIL);
      await Prefs.removePref(Prefs.USER_DISPLAY_NAME);
      await Prefs.removePref(Prefs.USER_LANGUAGE);

      if (!(tokenRemoved && loginRemoved && passwordRemoved)) {
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
    var savedLogin = await Prefs.getPrefString(Prefs.USER_LOGIN);
    var savedPassword = await Prefs.getPrefString(Prefs.USER_PASSWORD);
    _printPrefs();
    return (savedLogin != "" && savedPassword != "");
  }

  Future<void> requestUpdateUserInfo(String team, String displayName, String language) async {
    UserInfoResponse userInfoResponse;

    userInfoResponse = await _apiClient.updateUser(UpdateUserRequest(displayName, team, language, _identityInfo));

    Prefs.setPrefString(Prefs.USER_TEAM, userInfoResponse.team);
    Prefs.setPrefString(Prefs.USER_DISPLAY_NAME, userInfoResponse.displayName);
    Prefs.setPrefString(Prefs.USER_LANGUAGE, userInfoResponse.language);    
  }

  Future requestRegisterAccount(String displayName, String team, String email, String password, String username) async {
    await _apiClient.register(RegisterRequest(username, password, displayName, email, team, 'en', _identityInfo));
  }
}


