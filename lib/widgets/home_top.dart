import 'package:flutter/material.dart';
import 'package:lojacompleta/models/user_manager.dart';
import 'package:provider/provider.dart';

class HomeTop extends StatelessWidget {
  final Animation<double> containerGrow;
  HomeTop({
    @required this.containerGrow,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.1,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/login_back.jpg"), fit: BoxFit.cover)),
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /*
          Container(
            alignment: Alignment.topCenter,
            width: containerGrow.value * 150,
            height: containerGrow.value * 150,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("images/shopping.gif"),
                  fit: BoxFit.cover,
                )),
          ),
          */
          Consumer<UserManager>(builder: (_, userManager, __) {
            if (userManager.user == null) return Container();
            return Text(
              "Bem-vindo, ${userManager.user.name}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            );
          }),
        ],
      )),
    );
  }
}
