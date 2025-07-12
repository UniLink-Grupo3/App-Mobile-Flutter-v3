import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:profile_page/features/profile/data/models/driver_dto.dart';
import 'package:profile_page/features/profile/domain/driver.dart';
import 'package:profile_page/features/shared/service/api_client.dart';

class ProfileService {

  Future<Driver> getDriver() async{
    final dio = ApiClient().dio;


     try {
    final response = await dio.get(
      'https://movbackfinallll-production.up.railway.app/auth/me',
    );

       return DriverDto.fromJson(response.data as Map<String, dynamic>).toDomain();
  } catch (e) {
    throw Exception('Error al obtener datos del conductor');
  }


    // final Uri url = Uri.parse('https://movbackfinallll-production.up.railway.app/auth/me');
    // http.Response response = await http.get(url);
    // print("as;dlkfjas;ldfkjasd;lkfjsad;lfkjasdlfkasjdklfsdjlkfljkfajlk--------");
    // print(response.body);
    // if (response.statusCode == HttpStatus.ok) {
    //   final drivermap = jsonDecode(response.body) as Map<String, dynamic>;
    //   return DriverDto.fromJson(drivermap).toDomain();
    // } else {
    //   throw Exception('Failed to load driver');
    // }
  
  }

  Future<void> updateDriver(Driver driver) async {
    final Uri url = Uri.parse('http://localhost:3000/users/${driver.id}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': driver.id,
        'name': driver.name,
        'mail': driver.mail,
        'university': driver.university,
        'car': driver.car,
      }),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to update driver');
    }
  }

}