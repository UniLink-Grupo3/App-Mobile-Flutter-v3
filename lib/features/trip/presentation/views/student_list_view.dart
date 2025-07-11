import 'package:flutter/material.dart';
import 'package:profile_page/features/home/domain/entities/university_student_without_car.dart';
import 'package:profile_page/features/trip/presentation/views/student_car_view.dart';


class StudentListView extends StatefulWidget {
  const StudentListView({
    super.key, 
    required this.students, 
    required this.boardedIds,
    required this.onBoarded,
    required this.onArrived,
  });

  final List<UniversityStudentWithoutCar> students;
  final Set<int> boardedIds;
  final Function(UniversityStudentWithoutCar) onBoarded;
  final Function(UniversityStudentWithoutCar) onArrived;

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.students.length,
      itemBuilder: (context, index){
        final student = widget.students[index];
        final boarded = widget.boardedIds.contains(student.id);
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: StudentCardView(
            student: student,
            boarded: boarded,
            onBoarded: () => widget.onBoarded(student),
            onArrived: () => widget.onArrived(student),
          ),
        );
      },
    );
  }
}