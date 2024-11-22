// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:qualuga/dto/address_dto.dart';
import 'package:qualuga/dto/company_account_dto.dart';
import 'package:qualuga/screens/registration/successful_registration_screen.dart';
import 'package:qualuga/service/registration/address_service.dart';
import 'package:qualuga/service/registration/register_company_service.dart';

class RegisterAddress extends StatefulWidget {
  final CompanyAccountDTO companyAccountDTO;

  const RegisterAddress(
      {required CompanyAccountDTO this.companyAccountDTO, super.key});

  @override
  _RegisterAddressState createState() => _RegisterAddressState();
}

class _RegisterAddressState extends State<RegisterAddress> {
  RegisterCompanyService registerCompanyService = RegisterCompanyService();
  AddressService addressService = AddressService();

  final _formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();

  final _cep = TextEditingController();
  final _city = TextEditingController();
  final _street = TextEditingController();
  final _district = TextEditingController();
  final _number = TextEditingController();
  final _state = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  bool isLoading = false;
  String? forceErrorText;

  Future<void> _onFocusChange() async {
    if (!_focusNode.hasFocus) {
      resetAddress();
      setState(() {
        forceErrorText = null;
      });

      if (_cep.text.isNotEmpty) {
        AddressDTO? addressDTO =
            await addressService.getAddressByCep(_cep.text);

        if (addressDTO == null) {
          setState(() {
            forceErrorText = 'CPF inválido!';
          });
          return;
        }

        setState(() {
          _city.text = addressDTO.city;
          _street.text = addressDTO.street;
          _district.text = addressDTO.district;
          _state.text = addressDTO.state;
        });
      }
    }
  }

  void resetAddress() {
    setState(() {
      _city.text = '';
      _street.text = '';
      _district.text = '';
      _state.text = '';
    });
  }

  Future<void> registerCompany() async {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    widget.companyAccountDTO.addressDTO = AddressDTO(
        cep: _cep.text,
        street: _street.text,
        number: int.parse(_number.text),
        district: _district.text,
        city: _city.text,
        state: _state.text);

    setState(() => isLoading = true);
    Response response =
        await registerCompanyService.register(widget.companyAccountDTO);
    setState(() => isLoading = false);

    if (response.statusCode == 409) {
      String message = jsonDecode(response.body)['message'];

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text(
                message,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: Text('OK'))
              ],
            );
          });
    }

    if (response.statusCode == 201) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CompanyRegistered()));
    }
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
            child: Text("Cadastre um endereço para a sua empresa...",
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
                          controller: _cep,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 8,
                          focusNode: _focusNode,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          forceErrorText: forceErrorText,
                          decoration: InputDecoration(
                              focusColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .focusColor,
                              labelText: "CEP",
                              labelStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle,
                              border: Theme.of(context)
                                  .inputDecorationTheme
                                  .border),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O cep deve ser informado.';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: TextFormField(
                          controller: _city,
                          enabled: false,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              focusColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .focusColor,
                              labelText: "Cidade",
                              labelStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle,
                              border: Theme.of(context)
                                  .inputDecorationTheme
                                  .border),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'A cidade deve ser informada.';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: TextFormField(
                          controller: _street,
                          enabled: false,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              focusColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .focusColor,
                              labelText: "Rua",
                              labelStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle,
                              border: Theme.of(context)
                                  .inputDecorationTheme
                                  .border),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'A rua deve ser informada.';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: TextFormField(
                          controller: _district,
                          enabled: false,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              focusColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .focusColor,
                              labelText: "Bairro",
                              labelStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle,
                              border: Theme.of(context)
                                  .inputDecorationTheme
                                  .border),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O bairro deve ser informado.';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: TextFormField(
                          controller: _number,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              focusColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .focusColor,
                              labelText: "Número",
                              labelStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle,
                              border: Theme.of(context)
                                  .inputDecorationTheme
                                  .border),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O número deve ser informado.';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: TextFormField(
                          controller: _state,
                          enabled: false,
                          maxLength: 2,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              focusColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .focusColor,
                              labelText: "UF",
                              labelStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle,
                              border: Theme.of(context)
                                  .inputDecorationTheme
                                  .border),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'A UF deve ser informada.';
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
                                  style:
                                      Theme.of(context).textButtonTheme.style,
                                  onPressed: registerCompany,
                                  child: Text(
                                    "CRIAR CONTA",
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
