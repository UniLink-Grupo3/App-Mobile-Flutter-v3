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
      name: json['nombre']?.toString() ?? 'Sin nombre', // Convierte a String si es necesario
      mail: json['correo']?.toString() ?? 'Sin correo',
      phone: json['numero']?.toString() ?? 'Sin número',
      university: "upc",   // Valor por defecto
      car: "Toyota corolla", // Valor por defecto
      id: 1,              // Valor por defecto
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