import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:lojacompleta/helpers/constants.dart';
import 'package:lojacompleta/models/home_manager.dart';
import 'package:lojacompleta/models/page_manager.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:lojacompleta/models/video-questions-manager.dart';
import 'package:lojacompleta/screens/admin_users/admin_users_screens.dart';
import 'package:lojacompleta/screens/home/components/addsection_widget.dart';
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
                                title: Text('Samuca\'s PetShop'),
                                centerTitle: true,
                              ),
                              actions: [
                                IconButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed('/cart'),
                                    icon: Icon(Icons.shopping_cart_outlined)),
                                Consumer2<UserManager, HomeManager>(
                                  builder: (_, userManager, homeManager, __) {
                                    if (userManager.userIsAdmin &&
                                        !userManager.loading) {
                                      if (homeManager.editing) {
                                        return PopupMenuButton(onSelected: (e) {
                                          if (e == 'Salvar') {
                                            homeManager.saveEditing();
                                          } else {
                                            homeManager.discardEditing();
                                          }
                                        }, itemBuilder: (_) {
                                          return ['Salvar', 'Descartar']
                                              .map((e) {
                                            return PopupMenuItem(
                                              child: Text(e),
                                              value: e,
                                            );
                                          }).toList();
                                        });
                                      } else {
                                        return IconButton(
                                            onPressed: homeManager.enterEditing,
                                            icon: Icon(Icons.edit));
                                      }
                                    } else
                                      return Container();
                                  },
                                ),
                              ],
                            ),
                            Consumer<HomeManager>(
                              builder: (_, homeManager, __) {
                                if (homeManager.loading) {
                                  return SliverToBoxAdapter(
                                    child: Center(
                                      child: Image.asset(
                                        "images/saving.gif",
                                        scale: 4,
                                      ),
                                    ),
                                  );
                                }
                                final List<Widget> children =
                                    homeManager.sections.map<Widget>((section) {
                                  switch (section.type) {
                                    case 'List':
                                      return SectionList(section);
                                    case 'Staggered':
                                      return SectionStaggered(section);
                                    case 'more':
                                      return SectionList(section);
                                    default:
                                      return Container();
                                  }
                                }).toList();
                                if (homeManager.editing)
                                  children.add(AddSection(
                                    homeManager: homeManager,
                                  ));

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
                  body: Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              VideoQuestionsManager questionsManager =
                                  VideoQuestionsManager();
                            },
                            child: Text('VideoQuestions')),
                      ],
                    ),
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
                  AdminUsersScreen(),
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