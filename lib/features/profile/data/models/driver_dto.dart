import 'package:profile_page/features/profile/domain/driver.dart';

class DriverDto{
  final int id;
  final String name;
  final String mail;
  final String university;
  final String phone;
  final String car;

  const DriverDto({
    required this.id,
    required this.name,
    required this.mail,
    required this.university,
    required this.phone,
    required this.car,
  });

  factory DriverDto.fromJson(Map<String, dynamic> json) {
    return DriverDto(
      name: json['nombre'] as String,
      mail: json['correo'] as String,
      phone: json['numero'] as String,
      university: "upc",
      car: "Toyota corolla",
      id : 1,
    );
  }

  Driver toDomain() {
    return Driver(
      id: id,
      name: name,
      mail: mail,
      university: university,
      phone: phone,
      car: car,
    );
  }
}