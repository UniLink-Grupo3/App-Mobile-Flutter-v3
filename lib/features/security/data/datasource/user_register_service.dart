import 'dart:convert';
import 'dart:io';

import 'package:profile_page/features/security/data/models/user_register_dto.dart';
import 'package:http/http.dart' as http;

class UserRegisterService {
  
  Future<void> registerUser(UserRegisterDto user) async {
    final Uri url = Uri.parse("https://movbackfinallll-production.up.railway.app/auth/register");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode != HttpStatus.created && response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to register user');
    }
  }
}