import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/helpers/constants.dart';
import 'package:lojacompleta/helpers/deeplink_model.dart';
import 'package:lojacompleta/helpers/utils.dart';
import 'package:lojacompleta/models/conversion_data.model.dart';
import 'package:lojacompleta/models/page_manager.dart';

import 'package:lojacompleta/screens/home/home_container.dart';
import 'package:lojacompleta/screens/products/products_screen.dart';
import 'package:lojacompleta/widgets/custom_drawer/drawer.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  AppsflyerSdk _appsflyerSdk;

  Map _deepLinkData;

  Map _gcd;

  @override
  void initState() {
    super.initState();
    _appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //HomeScreen(),
          //LoginScreen(),
          Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(
                title: const Text('Home'),
              ),
              body: HomeContainer(
                  // onData: _gcd,
                  // deepLinkData: _deepLinkData,
                  // logEvent: logEvent,
                  )),
          /*
          Scaffold(
              drawer: CustomDrawer(),
              appBar: AppBar(
                title: const Text('Home'),
              ),
              body: FutureBuilder<dynamic>(
                  future: _appsflyerSdk.initSdk(
                      registerConversionDataCallback: true,
                      registerOnAppOpenAttributionCallback: true,
                      registerOnDeepLinkingCallback: true),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasData) {
                        return HomeContainer(
                            // onData: _gcd,
                            // deepLinkData: _deepLinkData,
                            // logEvent: logEvent,
                            );
                      } else {
                        return Center(child: Text("Error initializing sdk"));
                      }
                    }
                  })),
                  */
          ProductsScreen(),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Home4'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> logEvent(String eventName, Map eventValues) {
    return _appsflyerSdk.logEvent(eventName, eventValues);
  }
}
