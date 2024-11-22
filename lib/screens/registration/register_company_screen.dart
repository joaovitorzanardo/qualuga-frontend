// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qualuga/dto/company_account_dto.dart';
import 'package:qualuga/screens/registration/register_address_screen.dart';
import 'package:qualuga/service/registration/register_company_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  RegisterCompanyService registerCompanyService = RegisterCompanyService();
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  String? forceErrorText;
  bool isLoading = false;

  Future<void> nextSection() async {
    setState(() => forceErrorText = null);
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => isLoading = true);
    bool valid = await registerCompanyService.checkEmail(_email.text);
    setState(() => isLoading = false);

    if (!valid) {
      setState(() => forceErrorText =
          'Esse email já está sendo utilizado por outro usuário!');
      return;
    }

    CompanyAccountDTO companyAccountDTO = CompanyAccountDTO(
        name: _name.text, email: _email.text, password: _password.text);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RegisterAddress(companyAccountDTO: companyAccountDTO)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50),
            child:
                Text("qualuga", style: Theme.of(context).textTheme.titleMedium),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text("Preencha os campos com os seus dados...",
                style: Theme.of(context).textTheme.bodySmall),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
              width: 500,
              child: Form(
                key: _formKey,
                child: Material(
                  child: Container(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Column(
                        children: [
                          Container(
                            child: TextFormField(
                              controller: _name,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  focusColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .focusColor,
                                  labelText: "Nome",
                                  labelStyle: Theme.of(context)
                                      .inputDecorationTheme
                                      .labelStyle,
                                  border: Theme.of(context)
                                      .inputDecorationTheme
                                      .border),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'O nome da empresa deve ser informado.';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: TextFormField(
                              controller: _email,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              forceErrorText: forceErrorText,
                              decoration: InputDecoration(
                                  focusColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .focusColor,
                                  labelText: "Email",
                                  labelStyle: Theme.of(context)
                                      .inputDecorationTheme
                                      .labelStyle,
                                  border: Theme.of(context)
                                      .inputDecorationTheme
                                      .border),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'O email deve ser informado.';
                                }

                                RegExp exp =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                                if (!exp.hasMatch(value)) {
                                  return 'Formato do email inválido';
                                }

                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: _password,
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  focusColor: Theme.of(context)
                                      .inputDecorationTheme
                                      .focusColor,
                                  labelText: "Senha",
                                  labelStyle: Theme.of(context)
                                      .inputDecorationTheme
                                      .labelStyle,
                                  border: Theme.of(context)
                                      .inputDecorationTheme
                                      .border),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'A senha deve ser informada.';
                                }

                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 30),
                          if (isLoading)
                            const CircularProgressIndicator()
                          else
                            Container(
                                color: Theme.of(context).colorScheme.primary,
                                child: Container(
                                  width: 500,
                                  child: TextButton(
                                      style: Theme.of(context)
                                          .textButtonTheme
                                          .style,
                                      onPressed: nextSection,
                                      child: Text(
                                        "CONTINUAR",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Gliker',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none),
                                      )),
                                ))
                        ],
                      )),
                ),
              )),
        ],
      ),
    );
  }
}
