import '../models/identity_info.dart';
import '../Hit.dart';

class DetectionRequest{
  // device and system info to be sent with the request
  String deviceId;
  String deviceType;
  String deviceModel;
  String appVersion;
  String systemVersion;

  // List of hits to be sent to server
  List<Hit> detections = [];

  DetectionRequest(List<Hit> hits, IdentityInfo info){
    this.deviceId = info.deviceId;
    this.deviceModel = info.deviceModel;
    this.appVersion = info.appVersion;
    this.systemVersion = info.systemVersion;
    this.deviceType = info.deviceType;

    this.detections = hits;
  }

  //creates json representation of the request
  Map<String, dynamic> toJson() => {
    "device_id": deviceId,
    "device_model": deviceModel,
    "app_version": appVersion,
    "system_version": systemVersion,
    "device_type": deviceType,
    "detections": List<dynamic>.from(detections.map((x) => x.toJson())),
  };
}
