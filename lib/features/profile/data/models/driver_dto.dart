import 'package:profile_page/features/profile/domain/driver.dart';

class DriverDto{
  final int id;
  final String name;
  final String mail;
  final String university;
  final String car;

  const DriverDto({
    required this.id,
    required this.name,
    required this.mail,
    required this.university,
    required this.car,
  });

  factory DriverDto.fromJson(Map<String, dynamic> json) {
    return DriverDto(
      id: json['id'] as int,
      name: json['name'] as String,
      mail: json['mail'] as String,
      university: json['university'] as String,
      car: json['car'] as String,
    );
  }

  Driver toDomain() {
    return Driver(
      id: id,
      name: name,
      mail: mail,
      university: university,
      car: car,
    );
  }
}