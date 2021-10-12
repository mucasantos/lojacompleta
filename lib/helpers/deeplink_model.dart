class DeepLinkModel {
  String status;
  PayloadDeepLink payload;

  DeepLinkModel({this.status, this.payload});

  DeepLinkModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    payload = json['payload'] != null
        ? new PayloadDeepLink.fromJson(json['payload'])
        : null;
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

class PayloadDeepLink {
  DeepLink deepLink;
  String status;

  PayloadDeepLink({this.deepLink, this.status});

  PayloadDeepLink.fromJson(Map<String, dynamic> json) {
    deepLink = json['deepLink'] != null
        ? new DeepLink.fromJson(json['deepLink'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deepLink != null) {
      data['deepLink'] = this.deepLink.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class DeepLink {
  int amount;
  String mediaSource;
  String campaign;
  String deepLinkValue;
  String option;
  bool isDeferred;

  DeepLink(
      {this.amount,
      this.mediaSource,
      this.campaign,
      this.deepLinkValue,
      this.option,
      this.isDeferred});

  DeepLink.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    mediaSource = json['media_source'];
    campaign = json['campaign'];
    deepLinkValue = json['deep_link_value'];
    option = json['option'];
    isDeferred = json['is_deferred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['media_source'] = this.mediaSource;
    data['campaign'] = this.campaign;
    data['deep_link_value'] = this.deepLinkValue;
    data['option'] = this.option;
    data['is_deferred'] = this.isDeferred;
    return data;
  }
}
