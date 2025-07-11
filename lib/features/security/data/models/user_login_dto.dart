import 'package:profile_page/features/security/domain/entities/user_login.dart';

class UserLoginDto {
  final String correo;
  final String contrasena;

  UserLoginDto({
    required this.correo,
    required this.contrasena,
  });

  factory UserLoginDto.fromJson(Map<String, dynamic> json) {
    return UserLoginDto(
      correo: json['correo'],
      contrasena: json['contrasena'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correo': correo,
      'contrasena': contrasena,
    };
  }

  UserLogin toDomain() {
    return UserLogin(
      correo: correo,
      contrasena: contrasena,
    );
  }
}