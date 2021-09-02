import 'dart:async';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/helpers/constants.dart';
import 'package:lojacompleta/helpers/deeplink_model.dart';
import 'package:lojacompleta/helpers/utils.dart';
import 'package:lojacompleta/models/conversion_data.model.dart';
import 'package:lojacompleta/widgets/text_border.dart';

// ignore: must_be_immutable
class HomeContainer extends StatefulWidget {
  final Map onData;
  final Future<bool> Function(String, Map) logEvent;
  final Map deepLinkData;

  HomeContainer({
    this.onData,
    this.deepLinkData,
    this.logEvent,
  });

  @override
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  final String eventName = "purchase";

  final Map eventValues = {
    "af_content_id": "id123",
    "af_currency": "USD",
    "af_revenue": "20"
  };

  String _logEventResponse = "No event have been sent";
  PayloadDeepLink payloadLinkData;
  Payload conversionData;
  AppsflyerSdk _appsflyerSdk;

  Map _deepLinkData;

  Map _gcd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAppsFlyer();
  }

  void initAppsFlyer() async {
    _appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
    _appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true);
    _appsflyerSdk.onAppOpenAttribution((res) {
      print("onAppOpenAttribution res: " + res.toString());
      setState(() {
        _deepLinkData = res;
      });
    });
    _appsflyerSdk.onInstallConversionData((res) {
      // print("onInstallConversionData res: " + res.toString());
      setState(() {
        _gcd = res;
        conversionData = Payload.fromJson(_gcd['payload']);
      });
      print('bla');
      print(_gcd['payload']['install_time'].toString());
      print('depois');

      print(conversionData.afMessage);
    });
    _appsflyerSdk.onDeepLinking((res) {
      print("onDeepLinking res: " + res.toString());
      setState(() {
        _deepLinkData = res;
        payloadLinkData = PayloadDeepLink.fromJson(_deepLinkData['payload']);
      });

      if (payloadLinkData.deepLink.option.contains('open_signup'))
        Navigator.of(context).pushNamed('/signup');
      //final map = Utils.formatJson(res);
      //if (map.contains('open_signup')) {
      //  Navigator.of(context).pushNamed('/signup');
      // }
    });

    _appsflyerSdk.onAppOpenAttribution((res) {
      print("RESSSSS");
      print(res.toString());

      setState(() {
        _deepLinkData = res;
        payloadLinkData = PayloadDeepLink.fromJson(_deepLinkData['payload']);
      });
      if (payloadLinkData.deepLink.option.contains('open_signup'))
        Navigator.of(context).pushNamed('/signup');
    });
  }

  @override
  Widget build(BuildContext context) {
    // conversionDataModel = ConversionDataModel.fromJson(widget.onData);

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(
                "AF SDK",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
              ),
              TextBorder(
                controller: TextEditingController(
                    text: _gcd != null
                        ? Utils.formatJson(_gcd)
                        : "No conversion data"),
                labelText: "Conversion Data:",
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0),
              ),
              TextBorder(
                controller: TextEditingController(
                    text: _deepLinkData != null
                        ? Utils.formatJson(_deepLinkData)
                        : "No Attribution data"),
                labelText: "Attribution Data:",
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(children: <Widget>[
                  Center(
                    child: Text("Log event"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                  ),
                  TextBorder(
                    controller: TextEditingController(
                        text:
                            "event name: $eventName\nevent values: $eventValues"),
                    labelText: "Event Request",
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                  ),
                  TextBorder(
                      labelText: "Server response",
                      controller:
                          TextEditingController(text: _logEventResponse)),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                  ),
                  if (payloadLinkData != null)
                    Column(
                      children: [
                        Text('Isso mesmo'),
                        Text(payloadLinkData.deepLink.option ?? ' '),
                        Text(payloadLinkData.deepLink.deepLinkValue ?? ''),
                        Text(payloadLinkData.deepLink.mediaSource ?? ''),
                      ],
                    ),
                  if (conversionData != null)
                    Column(
                      children: [
                        Text(conversionData.afMessage ?? ' '),
                        Text(conversionData.afStatus ?? ''),
                        Text(conversionData.installTime ?? ''),
                      ],
                    ),
                  ElevatedButton(
                    onPressed: () {
                      print("Pressed");
                      final map = Utils.formatJson(_deepLinkData);
                      if (map.contains('open_signup')) {
                        Navigator.of(context).pushNamed('/signup');
                      }

                      widget.logEvent(eventName, eventValues).then((onValue) {
                        setState(() {
                          _logEventResponse = onValue.toString();
                        });
                      }).catchError((onError) {
                        setState(() {
                          _logEventResponse = onError.toString();
                        });
                      });
                    },
                    child: Text("Send purchase event"),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
