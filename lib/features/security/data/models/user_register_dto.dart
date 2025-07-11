
class UserRegisterDto {

  final String nombre;
  final String correo;
  final String numero;
  final String contrasena;

  UserRegisterDto({

    required this.nombre,
    required this.correo,
    required this.numero,
    required this.contrasena,
  });

  factory UserRegisterDto.fromJson(Map<String, dynamic> json) {
    return UserRegisterDto(

      nombre: json['nombre'],
      correo: json['correo'],
      numero: json['numero'],
      contrasena: json['contrasena'],
    );
  }

  Map<String, dynamic> toJson() {
    return {

      'nombre': nombre,
      'correo': correo,
      'numero': numero,
      'contrasena': contrasena,
    };
  }

}