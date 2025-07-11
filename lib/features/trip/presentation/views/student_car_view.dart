import 'package:flutter/material.dart';
import 'package:profile_page/features/home/domain/entities/university_student_without_car.dart';

class StudentCardView extends StatelessWidget {
  const StudentCardView({
    super.key, 
    required this.student, 
    this.boarded = false,
    required this.onBoarded,
    this.onArrived,
  });

  final UniversityStudentWithoutCar student;
  final bool boarded;
  final VoidCallback? onBoarded;
  final VoidCallback? onArrived;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: boarded ? Color.fromRGBO(247, 247, 247, 1) : null,
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: Row(
              children: [
                const Icon(Icons.people, size: 30, color: Color.fromRGBO(202, 96, 9, 0.753)),
                const SizedBox(width: 5),
                Text("${student.numberPeople}", style: TextStyle(fontSize: 23)),
              ],
            ),
          ),
          Container(
            color: Color.fromRGBO(245, 240, 230, 0.96),
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(student.image, width: 100, height: 100),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person, size: 20, color: Color.fromRGBO(58, 183, 147, 0.859)),
                        const SizedBox(width: 5),
                        Text(" ${student.name}"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.my_location, size: 20, color: Color.fromRGBO(58, 183, 147, 0.859)),
                        const SizedBox(width: 5),
                        Text(" ${student.pickup}"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.pin_drop, size: 20, color: Color.fromRGBO(58, 183, 147, 0.859)),
                        const SizedBox(width: 5),
                        Text(" ${student.destination}"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.payments, size: 20, color: Color.fromRGBO(58, 183, 147, 0.859)),
                        const SizedBox(width: 5),
                        Text(" ${student.price}"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${student.code} - ${student.university}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color.fromRGBO(5, 73, 124, 0.859),
                ),
                ),
              ],
            ),
          ),
          if (boarded)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0,),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    color: Color.fromRGBO(58, 183, 147, 0.859), //245, 240, 230, 0.96
                    child: const Text(
                      'Pasajero(s) a bordo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: onArrived, // llamada
                    icon: const Icon(Icons.directions_walk, color: Colors.white,),
                    label: const Text("Pasajero(s) llegó a su destino", 
                      style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                ),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(202, 96, 9, 0.753), //202, 96, 9, 0.753 - 44, 128, 212, 0.859
                    ),
                  ),
                )
              ],
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: onBoarded,
                style: FilledButton.styleFrom(
                  backgroundColor: Color.fromRGBO(202, 96, 9, 0.753),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Icon(Icons.check, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}