import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/helpers/constants.dart';
import 'package:lojacompleta/helpers/utils.dart';
import 'package:lojacompleta/models/cart_manager.dart';
import 'package:lojacompleta/models/product.model.dart';
import 'package:lojacompleta/models/product_manager.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:lojacompleta/screens/base_screen.dart';
import 'package:lojacompleta/screens/cart/cart_screen.dart';
import 'package:lojacompleta/screens/login/login_screen.dart';
import 'package:lojacompleta/screens/product/product_screen.dart';
import 'package:lojacompleta/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        ),
        ProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
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
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(settings.arguments as Product));
              break;
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
              break;
            case '/base':
              return MaterialPageRoute(builder: (_) => BaseScreen());
              break;
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
              break;
            case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen());
              break;
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
