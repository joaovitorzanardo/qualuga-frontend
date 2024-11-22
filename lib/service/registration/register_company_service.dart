import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:qualuga/dto/company_account_dto.dart';

class RegisterCompanyService {
  static const BASE_URL = 'https://qualuga-api-aa7705975057.herokuapp.com';

  Future<Response> register(CompanyAccountDTO companyAccountDTO) async {
    return await http.post(Uri.parse('$BASE_URL/auth/company/register'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(companyAccountDTO.toJson()));
  }

  Future<bool> checkEmail(String email) async {
    bool valid = false;

    final response =
        await http.get(Uri.parse('$BASE_URL/auth/company/checkEmail/$email'));

    if (response.statusCode == 200) {
      valid = jsonDecode(response.body)['valid'];
    }

    return valid;
  }
}
