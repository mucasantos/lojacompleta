import 'package:flutter/material.dart';
import 'package:lojacompleta/models/admin_users_manager.dart';
import 'package:lojacompleta/models/cart_manager.dart';
import 'package:lojacompleta/models/home_manager.dart';
import 'package:lojacompleta/models/product.model.dart';
import 'package:lojacompleta/models/product_manager.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:lojacompleta/screens/base_screen.dart';
import 'package:lojacompleta/screens/cart/cart_screen.dart';
import 'package:lojacompleta/screens/edit_product/edit_product_screen.dart';
import 'package:lojacompleta/screens/login/login_screen.dart';
import 'package:lojacompleta/screens/product/product_screen.dart';
import 'package:lojacompleta/screens/select_product_screen/select_product_screen.dart';
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
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
            create: (_) => AdminUsersManager(),
            lazy: false,
            update: (_, userManager, adminUsersManager) =>
                adminUsersManager..updateUser(userManager)),
      ],
      child: MaterialApp(
        title: 'Samuca\'s PetShop',
        color: const Color(0xFF66CCB5),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ).copyWith(
          backgroundColor: const Color(0xFF66CCB5),
          primaryColor: const Color(0xFF66CCB5),
          scaffoldBackgroundColor: const Color(0xFF66CCB5),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(elevation: 0),
          bottomAppBarColor: const Color(0xFF66CCB5),
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
            case '/select_product':
              return MaterialPageRoute(builder: (_) => SelectProductScreen());
              break;
            case '/edit':
              return MaterialPageRoute(
                  builder: (_) =>
                      EditProductScreen(settings.arguments as Product));
              break;
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
