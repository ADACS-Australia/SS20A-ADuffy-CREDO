import '../models/identity_info.dart';
import '../Hit.dart';

class DetectionRequest{

  String deviceId;
  String deviceType;
  String deviceModel;
  String appVersion;
  String systemVersion;

  List<Hit> detections;

  DetectionRequest(List<Hit> hits, IdentityInfo info){
    this.deviceId = info.deviceId;
    this.deviceModel = info.deviceModel;
    this.appVersion = info.appVersion;
    this.systemVersion = info.systemVersion;
    this.deviceType = info.deviceType;

    this.detections = detections;
  }

  Map<String, dynamic> toJson() => {
    "device_id": deviceId,
    "device_model": deviceModel,
    "app_version": appVersion,
    "system_version": systemVersion,
    "device_type": deviceType,
    "detections": List<dynamic>.from(detections.map((x) => x.toJson())),
  };
}