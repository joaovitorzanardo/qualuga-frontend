import 'dart:convert';

import 'package:qualuga/dto/address_dto.dart';
import 'package:http/http.dart' as http;

class AddressService {
  static const baseUrl = "https://viacep.com.br/ws";

  Future<AddressDTO?> getAddressByCep(String cep) async {
    AddressDTO? addressDTO;
    final response = await http.get(Uri.parse('$baseUrl/$cep/json/'));

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['erro'] == null) {
        addressDTO = AddressDTO.fromJsonOfCepAPI(
            jsonDecode(response.body) as Map<String, dynamic>);
      }
    }

    return addressDTO;
  }
}
