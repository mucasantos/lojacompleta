import 'package:flutter/material.dart';
import 'package:lojacompleta/models/user.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:provider/provider.dart';

class StaggerAnimationButton extends StatelessWidget {
  final AnimationController controller;
  final GlobalKey<FormState> formKey;
  final User user;
  StaggerAnimationButton({this.controller, this.formKey, this.user})
      : buttonSqueeze = Tween(begin: 320.0, end: 60.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.150),
          ),
        ),
        buttonZoomOut = Tween(
          begin: 60.0,
          end: 1000.0,
        ).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1,
              curve: Curves.bounceOut,
            )));

  final Animation<double> buttonSqueeze;

  final Animation<double> buttonZoomOut;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
        child: InkWell(
          onTap: () {
            print(user.email);
            if (!formKey.currentState.validate()) return;
            controller.forward();

            context.read<UserManager>().signIn(
                user: user,
                onSuccess: () {
                  //TODO Fechar tela de login
                },
                onFail: (message) {
                  controller.reverse();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.red[200],
                  ));
                });
          },
          child: buttonZoomOut.value <= 60
              ? Container(
                  width: buttonSqueeze.value,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xFF66CCB5),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: _buildInside(context))
              : Container(
                  width: buttonZoomOut.value,
                  height: buttonZoomOut.value,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF66CCB5),
                    shape: buttonZoomOut.value < 500
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                  ),
                ),
        ),
        padding: EdgeInsets.only(
          bottom: 50.0,
        ));
  }

  Widget _buildInside(BuildContext contex) {
    if (buttonSqueeze.value > 75) {
      return Text(
        "Entrar",
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
            letterSpacing: 0.8),
      );
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 1.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}
