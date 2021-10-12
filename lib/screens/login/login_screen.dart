import 'package:flutter/material.dart';
import 'package:lojacompleta/helpers/validators.dart';
import 'package:lojacompleta/models/user.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:lojacompleta/widgets/signup_botton.dart';
import 'package:lojacompleta/widgets/stagger_animation_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  User user = User();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "images/login_back.jpg",
              ),
              fit: BoxFit.cover)),
      child: Consumer<UserManager>(builder: (_, usermanager, __) {
        return ListView(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 100,
                        bottom: 80,
                      ),
                      child: Image.asset(
                        "images/login.png",
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border(
                              bottom:
                                  BorderSide(color: Colors.white24, width: 1),
                            )),
                            child: TextFormField(
                              enabled: !usermanager.loading,
                              style: TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'E-mail',
                                hintStyle: TextStyle(color: Colors.white),
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              validator: (email) {
                                if (!emailValid(email!))
                                  return "E-mail inválido";
                                setState(() {
                                  user.email = email;
                                });

                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border(
                              bottom:
                                  BorderSide(color: Colors.white24, width: 1),
                            )),
                            child: TextFormField(
                              enabled: !usermanager.loading,
                              style: TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Senha',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                border: InputBorder.none,
                              ),
                              obscureText: true,
                              autocorrect: false,
                              validator: (senha) {
                                if (senha!.isEmpty || senha.length < 8) {
                                  return "Senha inválida";
                                }

                                setState(() {
                                  user.password = senha;
                                });

                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SignUpButton()
                  ],
                ),
                StaggerAnimationButton(
                    user: user,
                    controller: _animationController!, //era .view
                    formKey: formKey)
              ],
            ),
          ],
        );
      }),
    ));
  }
}
