import 'package:flutter/material.dart';
import 'package:profile_page/features/home/domain/entities/university_student_without_car.dart';

class StudentRequestSheetView extends StatelessWidget {
  const StudentRequestSheetView({
    super.key,
    required this.student,
    required this.onAccept,
    required this.onReject,
  });

  final UniversityStudentWithoutCar student;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(student.image),
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('¡${student.name} quiere un viaje!',
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)
                        ),
                        Text(student.university,
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'S/.${student.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
              const Divider(height: 32, thickness: 1),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(Icons.circle, color: Color.fromRGBO(70, 70, 70, 0.27), size: 16),      
                      SizedBox(
                          height: 55,
                          child: VerticalDivider(color: Colors.grey[400], thickness: 2)
                      ),
                      Icon(Icons.location_on, color: Color.fromRGBO(3, 72, 141, 0.63), size: 24),
                      SizedBox(
                          height: 35,
                          child: VerticalDivider(color: Colors.grey[400], thickness: 2)
                      ),
                      Icon(Icons.person, color: Color.fromRGBO(202, 96, 9, 0.753), size: 24),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Punto de Recojo:',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700])),
                        Text(student.pickup,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 24),
                        Text('Punto de Destino:',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700])),
                        Text(student.destination,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 24),
                        Text('Cantidad de pasajeros:',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700])),
                        Text('${student.numberPeople}',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReject,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Rechazar',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(3, 72, 141, 0.63),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Aceptar',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}