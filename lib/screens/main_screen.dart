// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qualuga/screens/login/login_screen.dart';
import 'package:qualuga/screens/registration/register_company_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50, top: 30),
      alignment: Alignment.centerLeft,
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "qualuga",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: Text(
                "Alugue quadras, confirme seus jogos, \ntudo em um só lugar!",
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          Container(
              padding: EdgeInsets.only(top: 30),
              child: Builder(
                builder: (context) => FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0), // <-- Radius
                        )),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register(),
                        ),
                      );
                    },
                    child: Text(
                      "QUERO FAZER PARTE",
                      style: TextStyle(
                          color: Color.fromRGBO(0, 127, 255, 1),
                          fontFamily: 'Gliker',
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none),
                    )),
              )),
          Container(
            padding: EdgeInsets.only(top: 15),
            child: Builder(
              builder: (context) => OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0), // <-- Radius
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  child: Text(
                    "FAZER LOGIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Gliker',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
