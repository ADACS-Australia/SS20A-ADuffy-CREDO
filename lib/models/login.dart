import 'identity_info.dart';

abstract class LoginRequest {
  String password;
  String deviceId;
  String deviceType;
  String deviceModel;
  String appVersion;
  String systemVersion;  

  Map<String, dynamic> toJson();
}

class LoginByUsernameRequest extends LoginRequest {
  String username;

  LoginByUsernameRequest(String username, String password, IdentityInfo info){
    this.username = username;
    this.password = password;
    this.deviceId = info.deviceId;
    this.deviceModel = info.deviceModel;
    this.appVersion = info.appVersion;
    this.systemVersion = info.systemVersion;
  }

  Map<String, dynamic> toJson() => {
    "usename": username,
    "password": password,
    "device_id": deviceId,
    "device_model": deviceModel,
    "app_version": appVersion,
    "system_version": systemVersion
  };
}

class LoginByEmailRequest extends LoginRequest {
  String email;

  LoginByEmailRequest(String email, String password, IdentityInfo info){
    this.email = email;
    this.password = password;
    this.deviceId = info.deviceId;
    this.deviceModel = info.deviceModel;
    this.appVersion = info.appVersion;
    this.systemVersion = info.systemVersion;
  }

  Map<String, dynamic> toJson() => {
    "usename": email,
    "password": password,
    "device_id": deviceId,
    "device_model": deviceModel,
    "app_version": appVersion,
    "system_version": systemVersion
  };
}