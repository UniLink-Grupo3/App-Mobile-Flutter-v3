import 'package:flutter/material.dart';
import 'package:profile_page/features/home/domain/entities/university_student_without_car.dart';
import 'package:profile_page/features/trip/presentation/views/student_list_view.dart';

class TripPage extends StatefulWidget {
  const TripPage({
    super.key,
    required this.acceptedStudents,
    required this.boardedIds,
    required this.onBoarded,  
    required this.onClear,
  });

  final ValueNotifier<List<UniversityStudentWithoutCar>> acceptedStudents;
  final ValueNotifier<Set<int>> boardedIds;
  final ValueChanged<UniversityStudentWithoutCar> onBoarded;
  final VoidCallback onClear;

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {

  void _handlePassengerArrived(UniversityStudentWithoutCar student) {

    final newAcceptedList = widget.acceptedStudents.value
      .where((s) => s.id != student.id)
      .toList();

    widget.acceptedStudents.value = newAcceptedList; // Notifica
    widget.boardedIds.value = Set.from(widget.boardedIds.value)..remove(student.id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("El pasajero ${student.name} llegó a su destino"),
      ),
    );

    //Si ya no quedan pasajeros, limpiar el estado
    if (widget.acceptedStudents.value.isEmpty &&
        widget.boardedIds.value.isEmpty) {
      widget.onClear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<int>>(
      valueListenable: widget.boardedIds,
      builder: (_, ids, __) {
    if (widget.acceptedStudents.value.isEmpty) {
      return const Center(
        child: Text(
          "No ha aceptado ninguna solicitud",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return Column(
          children: [
            Expanded(
              child: StudentListView(
                students: widget.acceptedStudents.value,
                boardedIds: ids,         // Set<int> actualizado
                onBoarded: widget.onBoarded,
                onArrived: _handlePassengerArrived,
              ),
            ),
          ],
        );
      },
    );
  }
}