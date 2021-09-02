class ConversionDataModel {
  String status;
  Payload payload;

  ConversionDataModel({this.status, this.payload});

  ConversionDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    payload =
        json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.payload != null) {
      data['payload'] = this.payload.toJson();
    }
    return data;
  }
}

class Payload {
  String installTime;
  String afStatus;
  String afMessage;
  bool isFirstLaunch;

  Payload(
      {this.installTime, this.afStatus, this.afMessage, this.isFirstLaunch});

  Payload.fromJson(Map<String, dynamic> json) {
    installTime = json['install_time'];
    afStatus = json['af_status'];
    afMessage = json['af_message'];
    isFirstLaunch = json['is_first_launch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['install_time'] = this.installTime;
    data['af_status'] = this.afStatus;
    data['af_message'] = this.afMessage;
    data['is_first_launch'] = this.isFirstLaunch;
    return data;
  }
}
