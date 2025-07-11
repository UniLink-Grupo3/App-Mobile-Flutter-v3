import 'package:flutter/material.dart';
import 'package:profile_page/features/home/domain/entities/university_student_without_car.dart';
import 'package:profile_page/features/home/presentation/pages/map_page.dart';
import 'package:profile_page/features/home/presentation/views/student_destination_view.dart';

class StartTripPage extends StatefulWidget {

  const StartTripPage({
    super.key,
    required this.students,
    required this.acceptedStudents,
    required this.boardedIds,
    required this.onAccept,
  });

  final ValueNotifier<List<UniversityStudentWithoutCar>> acceptedStudents;
  final List<UniversityStudentWithoutCar> students;  
  final ValueNotifier<Set<int>> boardedIds; 
  final ValueChanged<UniversityStudentWithoutCar> onAccept; 

  @override
  State<StartTripPage> createState() => _StartTripPageState();
}

class _StartTripPageState extends State<StartTripPage>
  with AutomaticKeepAliveClientMixin {
  
  late final ValueNotifier<List<UniversityStudentWithoutCar>> acceptedNotifier;
  
  @override
  void initState() {
    super.initState();
    acceptedNotifier = widget.acceptedStudents; // usa el mismo del MainPage
  }
  
  bool _isOnline = false;
  String? _selectedDestination; 

  @override
  bool get wantKeepAlive => true;

  Future<void> _handleSwitch(bool value) async {
  if (value) {
    final bool hasAccepted = acceptedNotifier.value.isNotEmpty;//widget.acceptedStudents.isNotEmpty;
    final bool hasBoarded  = widget.boardedIds.value.isNotEmpty;
    
    if (hasAccepted || hasBoarded) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No puedes ponerte en línea mientras tengas pasajeros activos.',
            ),
          ),
        );
        return;
      }

      final dest = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.all(24), // margen al borde de pantalla
        child: const StudentDestinationView(),  // ← tu widget
      ),
    );

    if (!mounted || dest == null) return;

    setState(() {
      _selectedDestination = dest;
      _isOnline = true;
    });

  } else {
    setState(() => _isOnline = false);
    }
  }

  void _handleAccept(UniversityStudentWithoutCar student) {
  // Agrega el nuevo aceptado a la lista y notifica
  acceptedNotifier.value = [...acceptedNotifier.value, student];
  widget.onAccept(student); // Llama callback original si se necesita
}


  @override
  Widget build(BuildContext context) {
    super.build(context); 

    return Stack(
      children: [
        Positioned.fill(
          child: MapPage(
            showLocation: _isOnline,
            students: widget.students,//availableStudents,,
            acceptedStudents: widget.acceptedStudents, //widget.acceptedStudents,
            boardedIds: widget.boardedIds,
            onAccept: _handleAccept, //widget.onAccept,
          ),
        ),
        Positioned(
          top: 24,
          left: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  color: Color(0x33000000),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    Text(
                      _isOnline ? 'Online' : 'Offline',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isOnline ? Colors.green : Colors.red,
                      ),
                    ),
                    if (_isOnline && _selectedDestination != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _selectedDestination!,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
                Switch(
                  value: _isOnline,
                  onChanged: _handleSwitch,
                  activeColor: _isOnline ? Colors.green : Colors.red,
                  inactiveThumbColor: Colors.red,
                  inactiveTrackColor: Colors.red.shade300,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}