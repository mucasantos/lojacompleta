import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/helpers/constants.dart';
import 'package:lojacompleta/models/home_manager.dart';
import 'package:lojacompleta/models/page_manager.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:lojacompleta/screens/home/components/section_list.dart';
import 'package:lojacompleta/screens/home/components/section_staggered.dart';
import 'package:lojacompleta/screens/home/homescreen.dart';
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

  UserManager userManager;
  @override
  void initState() {
    super.initState();
    _appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => PageManager(pageController),
        child: Consumer<UserManager>(
          builder: (_, userManager, __) {
            return PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // HomeScreen(),
                //LoginScreen(),
                Scaffold(
                    backgroundColor: const Color(0xFF66CCB5),
                    drawer: CustomDrawer(),
                    // appBar: AppBar(
                    //   backgroundColor: const Color(0xFF66CCB5),
                    //   title: const Text('Loja do Samuca'),
                    // ),
                    body: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: const [
                                  Color.fromARGB(255, 30, 118, 130),
                                  Color.fromARGB(250, 253, 181, 168)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                        ),
                        CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              snap: true,
                              floating: true,
                              backgroundColor: Colors.transparent,
                              flexibleSpace: const FlexibleSpaceBar(
                                title: Text('Loja do Samuca'),
                                centerTitle: true,
                              ),
                              actions: [
                                IconButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed('/cart'),
                                    icon: Icon(Icons.shopping_cart_outlined))
                              ],
                            ),
                            Consumer<HomeManager>(
                              builder: (_, homeManager, __) {
                                final List<Widget> children =
                                    homeManager.sections.map<Widget>((section) {
                                  switch (section.type) {
                                    case 'List':
                                      return SectionList(section);
                                    case 'Staggered':
                                      return SectionStaggered(section);
                                    default:
                                      return Container();
                                  }
                                }).toList();

                                return SliverList(
                                  delegate: SliverChildListDelegate(children),
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    )),

                ProductsScreen(),
                Scaffold(
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    backgroundColor: const Color(0xFF66CCB5),
                    title: const Text('Meus Pedidos'),
                  ),
                ),
                Scaffold(
                  drawer: CustomDrawer(),
                  appBar: AppBar(
                    backgroundColor: const Color(0xFF66CCB5),
                    title: const Text('Lojas'),
                  ),
                ),
                if (userManager.userIsAdmin) ...[
                  Scaffold(
                    drawer: CustomDrawer(),
                    appBar: AppBar(
                      backgroundColor: const Color(0xFF66CCB5),
                      title: const Text('Usuários'),
                    ),
                  ),
                  Scaffold(
                    drawer: CustomDrawer(),
                    appBar: AppBar(
                      backgroundColor: const Color(0xFF66CCB5),
                      title: const Text('Lojas'),
                    ),
                  ),
                ]
              ],
            );
          },
        ));
  }
/*
  Future<bool> logEvent(String? eventName, Map? eventValues) {
    return _appsflyerSdk!.logEvent(eventName, eventValues);
  }
  */
}


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