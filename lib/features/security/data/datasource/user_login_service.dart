import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:profile_page/features/shared/service/api_client.dart';

class UserLoginService {
  Future<bool> login(String correo, String contrasena) async {
    final dio = ApiClient().dio;

 try {
    final response = await dio.post(
      'https://movbackfinallll-production.up.railway.app/auth/login',
      data: {'correo': correo, 'contrasena': contrasena},
    );
    return response.data['success'] == true;
  } catch (e) {
    return false;
  }

    // final Uri url = Uri.parse('https://movbackfinallll-production.up.railway.app/auth/login');

    // final response = await http.post(
    //   url,
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    //   body: jsonEncode({
    //     'correo': correo,
    //     'contrasena': contrasena,
    //   }),
    // );

    // // Imprimir para verificar respuesta del backend
    // print('STATUS: ${response.statusCode}');
    // print('BODY: ${response.body}');

    // if (response.statusCode != HttpStatus.ok) {
    //   throw Exception('Error al iniciar sesión');
    // }

    // final data = jsonDecode(response.body);

    // // Aquí puedes ajustar la lógica dependiendo de lo que devuelva el backend.
    // // Por ejemplo, si devuelve {"success": true}, podrías usar eso:
    // return data['success'] == true;
  }
}