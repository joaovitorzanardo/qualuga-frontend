class AddressDTO {
  final int addressId = 0;
  final String cep;
  final String street;
  final int? number;
  final String district;
  final String city;
  final String state;

  const AddressDTO(
      {required this.cep,
      required this.street,
      required this.number,
      required this.district,
      required this.city,
      required this.state});

  Map<String, dynamic> toJson() => {
        'addressId': addressId,
        'cep': cep,
        'street': street,
        'number': number,
        'district': district,
        'city': city,
        'state': state
      };

  factory AddressDTO.fromJsonOfCepAPI(Map<String, dynamic> json) {
    return switch (json) {
      {
        'cep': String cep,
        'localidade': String city,
        'logradouro': String street,
        'bairro': String district,
        'uf': String state
      } =>
        AddressDTO(
            cep: cep,
            city: city,
            street: street,
            district: district,
            number: null,
            state: state),
      _ => throw const FormatException('Erro ao converter json para objeto.'),
    };
  }
}
