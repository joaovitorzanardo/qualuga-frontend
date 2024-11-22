// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qualuga/screens/login/login_screen.dart';

class CompanyRegistered extends StatelessWidget {
  const CompanyRegistered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(31, 31, 31, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 50),
            child: Text("Empresa Cadastrada com Sucesso!",
                style: TextStyle(
                    fontSize: 80,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontFamily: 'Gliker',
                    fontWeight: FontWeight.normal)),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              color: Color.fromRGBO(0, 127, 255, 1),
              child: Container(
                width: 500,
                child: TextButton(
                    style: OutlinedButton.styleFrom(
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
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none),
                    )),
              ))
        ],
      ),
    );
  }
}
