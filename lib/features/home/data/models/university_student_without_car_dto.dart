import 'package:profile_page/features/home/domain/entities/university_student_without_car.dart';

class UniversityStudentWithoutCarDto {
  final int id;
  final String name;
  final String code;
  final String university;
  final String image;
  final int numberPeople;
  final String destination;
  final String pickup;
  final int price;
  final double latitude;
  final double longitude;

  UniversityStudentWithoutCarDto({
    required this.id,
    required this.name,
    required this.code,
    required this.university,
    required this.image,
    required this.numberPeople,
    required this.destination,
    required this.pickup,
    required this.price,
    required this.latitude,
    required this.longitude,
  });

  factory UniversityStudentWithoutCarDto.fromJson(Map<String, dynamic> json) {
  return UniversityStudentWithoutCarDto(
    id: int.parse(json['id'].toString()),
    name: json['name'],
    code: json['code'],
    university: json['university'],
    image: json['image'],
    numberPeople: int.parse(json['numberPeople'].toString()),
    destination: json['destination'],
    pickup: json['pickup'],
    price: int.parse(json['price'].toString()),
    latitude: double.parse(json['latitude'].toString()),
    longitude: double.parse(json['longitude'].toString()),
  );
}

  UniversityStudentWithoutCar toDomain() {
    return UniversityStudentWithoutCar(
      id: id,
      name: name,
      code: code,
      university: university,
      image: image,
      numberPeople: numberPeople,
      destination: destination,
      pickup: pickup,
      price: price,
      latitude: latitude,
      longitude: longitude,
    );
  }
}