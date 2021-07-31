import 'package:flutter/material.dart';
import 'package:lojacompleta/helpers/validators.dart';
import 'package:lojacompleta/models/user.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: _formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        enabled: !userManager.loading,
                        decoration:
                            const InputDecoration(hintText: "Nome Completo"),
                        validator: (name) {
                          if (name.isEmpty)
                            return "Nome obrigatório";
                          else if (name.trim().split(' ').length <= 1)
                            return "Preencha o seu nome completo!";
                          return null;
                        },
                        onSaved: (name) => user.name = name,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: "E-mail"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email.isEmpty)
                            return "E-mail obrigatório";
                          else if (!emailValid(email)) return "E-mail inválido";
                          return null;
                        },
                        onSaved: (email) => user.email = email,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(hintText: "Senha"),
                        obscureText: true,
                        validator: (pass) {
                          if (pass.isEmpty)
                            return "Senha está em branco!";
                          else if (pass.length < 8)
                            return "A senha precisa ter 8 caracteres";
                          return null;
                        },
                        onSaved: (pass) => user.password = pass,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        enabled: !userManager.loading,
                        decoration:
                            const InputDecoration(hintText: "Repita a senha"),
                        obscureText: true,
                        validator: (repPass) {
                          if (repPass.isEmpty)
                            return "Campo obrigatório";
                          else if (repPass.length < 8)
                            return "A senha precisa ser igual";
                          return null;
                        },
                        onSaved: (repPass) => user.confirmPassword = repPass,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              if (user.password != user.confirmPassword) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: const Text(
                                  "As senhas não coincidem!",
                                  textAlign: TextAlign.center,
                                )));

                                return;
                              }

                              await userManager.signUp(
                                  user: user,
                                  onFail: (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "Não foi possível cadastrar: $e",
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Colors.red[200],
                                    ));
                                  },
                                  onSuccess: () {
                                    Navigator.of(context).pop();
                                  });
                            }
                          },
                          child: userManager.loading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                  strokeWidth: 1.0,
                                )
                              : Text(
                                  "Criar conta",
                                  style: TextStyle(fontSize: 18),
                                ),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF66CCB5),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }
}
