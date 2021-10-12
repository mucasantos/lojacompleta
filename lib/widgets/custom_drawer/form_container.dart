import 'package:flutter/material.dart';
import 'package:lojacompleta/helpers/validators.dart';
import 'package:lojacompleta/models/user.dart';
import 'package:lojacompleta/widgets/stagger_animation_button.dart';

class FormContainer extends StatefulWidget {
  @override
  _FormContainerState createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final TextEditingController passController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

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

    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(color: Colors.white24, width: 1),
            )),
            child: TextFormField(
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
                if (!emailValid(email)) return "E-mail inválido";
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
              bottom: BorderSide(color: Colors.white24, width: 1),
            )),
            child: TextFormField(
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
                if (senha.isEmpty || senha.length < 8) {
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
          StaggerAnimationButton(
              user: user,
              controller: _animationController,
              formKey: formKey) //Antes era _animatorController.view
        ],
      ),
    );
  }
}
