class IdentityInfo {
  // Holds device and system identity Info
  final String deviceId;
  final String deviceType;
  final String deviceModel;
  final String appVersion;
  final String systemVersion;

  const IdentityInfo(this.deviceId, this.deviceType, this.deviceModel, this.appVersion, this.systemVersion);

  Map<String, dynamic> toJson() => 
  {"device_id": deviceId, 
  "device_type": deviceType,
  "device_model": deviceModel,
  "app_version": appVersion,
  "system_version": systemVersion
  };

}