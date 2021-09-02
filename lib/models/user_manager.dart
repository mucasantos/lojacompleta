import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojacompleta/helpers/constants.dart';
import 'package:lojacompleta/helpers/firebase_erros.dart';
import 'package:lojacompleta/models/user.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  final Firestore firestore = Firestore.instance;

  bool _loading = false;
  bool get loading => _loading;
  bool get isLoggedIn => user != null;
  Map get deepLinkData => _deepLinkData;
  Map get gcd => _gcd;
  User user;

  AppsflyerSdk _appsflyerSdk;
  Map _deepLinkData;
  Map _gcd;

  //GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  set deepLinkData(Map value) {
    _deepLinkData = value;
    notifyListeners();
  }

  set gcd(Map value) {
    _gcd = value;
    notifyListeners();
  }

  _getLinks() {
    _appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

    _appsflyerSdk.onAppOpenAttribution((res) {
      print("onAppOpenAttribution res: " + res.toString());

      deepLinkData = res;
    });
    _appsflyerSdk.onInstallConversionData((res) {
      print(" Aqui onInstallConversionData res: " + res.toString());

      print(res['Status']);

      gcd = res;
    });
    _appsflyerSdk.onDeepLinking((res) {
      print("onDeepLinking res: ");

      print(res.toString());

      deepLinkData = res;
    });
  }

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      await _loadCurrentUser(firebaseUser: result.user);
      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();

    if (currentUser != null) {
      final docUser =
          await firestore.collection('users').document(currentUser.uid).get();

      user = User.fromDocument(document: docUser);
      print(user.name);
      notifyListeners();
    }
  }

  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      user.id = result.user.uid;
      this.user = user;

      await user.saveData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }
}
