import 'identity_info.dart';

abstract class RegisterRequest {
  String password = "";
  String deviceId = "";
  String deviceType = "";
  String deviceModel = "";
  String appVersion = "";
  String systemVersion = "";
  String team = "ADACS";
  String language = "";
  String displayName = "";
  String username = "";
  String email = "";


  Map<String, dynamic> toJson() => {
        "usename": username,
        "password": password,
        "display_name": displayName,
        "team": team,
        "language": language,
        "email": email,
        "device_id": deviceId,
        "device_model": deviceModel,
        "app_version": appVersion,
        "system_version": systemVersion,
        "device_type": deviceType
      };

  RegisterRequest(String username, String password, String displayName, String email, String team, String language, IdentityInfo info) {
    this.username = username;
    this.password = password;
    this.displayName = displayName;
    this.email = email;
    this.team = team;
    this.language = language;
    this.deviceId = info.deviceId;
    this.deviceModel = info.deviceModel;
    this.appVersion = info.appVersion;
    this.systemVersion = info.systemVersion;
    this.deviceType = info.deviceType;
  }
}

abstract class UpdateUserRequest {
  String deviceId = "";
  String deviceType = "";
  String deviceModel = "";
  String appVersion = "";
  String systemVersion = "";
  String team = "ADACS";
  String language = "";
  String displayName = "";

  Map<String, dynamic> toJson() => {
        "display_name": displayName,
        "team": team,
        "language": language,
        "device_id": deviceId,
        "device_model": deviceModel,
        "app_version": appVersion,
        "system_version": systemVersion,
        "device_type": deviceType
      };

  UpdateUserRequest(String displayName, String team, String language, IdentityInfo info) {
    this.displayName = displayName;
    this.team = team;
    this.language = language;
    this.deviceId = info.deviceId;
    this.deviceModel = info.deviceModel;
    this.appVersion = info.appVersion;
    this.systemVersion = info.systemVersion;
    this.deviceType = info.deviceType;
  }
}



