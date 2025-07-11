import 'dart:convert';
import 'dart:io';

import 'package:profile_page/features/home/data/models/university_student_without_car_dto.dart';
import 'package:profile_page/features/home/domain/entities/university_student_without_car.dart';
import 'package:http/http.dart' as http;

class WithoutCarService {
  Future <List <UniversityStudentWithoutCar>> getStudentsWithoutCar() async{
    final Uri url = Uri.parse("https://movbackfinallll-production.up.railway.app/students");
    http.Response response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      final List maps = jsonDecode(response.body);
    return maps
        .map((e) => UniversityStudentWithoutCarDto.fromJson(e).toDomain())
        .toList();
    } else {
      return [];
    }
  }
}