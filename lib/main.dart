import 'package:flutter/material.dart';
import 'package:lojacompleta/models/product_manager.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:lojacompleta/screens/base_screen.dart';
import 'package:lojacompleta/screens/login/login_screen.dart';
import 'package:lojacompleta/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        title: 'Loja do Samuca',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ).copyWith(
          primaryColor: const Color(0xFF66CCB5),
          scaffoldBackgroundColor: const Color(0xFF66CCB5),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(elevation: 0),
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
              break;
            case '/base':
              return MaterialPageRoute(builder: (_) => BaseScreen());
              break;
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
              break;
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
