import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 160.0),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed("/signup");
        },
        child: Text(
          "Não possui uma conta? Cadastre-se",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.5),
        ),
      ),
    );
  }
}
