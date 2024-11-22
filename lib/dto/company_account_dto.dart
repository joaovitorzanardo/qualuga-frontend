import 'package:qualuga/dto/address_dto.dart';

class CompanyAccountDTO {
  final int companyId = 0;
  final String name;
  final String email;
  final String password;
  late AddressDTO addressDTO;

  CompanyAccountDTO(
      {required this.name, required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'companyId': companyId,
        'name': name,
        'email': email,
        'password': password,
        'address': addressDTO.toJson(),
      };
}
