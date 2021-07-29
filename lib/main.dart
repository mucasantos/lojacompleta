import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:lojacompleta/screens/base_screen.dart';
import 'package:lojacompleta/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Loja do Samuca',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ).copyWith(
          primaryColor: const Color(0xff7FB4E2),
          scaffoldBackgroundColor: const Color(0xff7FB4E2),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(elevation: 0),
        ),
        home: LoginScreen(),
      ),
    );
  }
}
