import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:profile_page/features/home/data/datasources/without_car_service.dart';
import 'package:profile_page/features/home/presentation/pages/star_trip_page.dart';
import 'package:profile_page/features/trip/presentation/pages/trip_page.dart';
import 'package:profile_page/features/home/domain/entities/university_student_without_car.dart';
import 'package:profile_page/features/profile/presentation/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List <UniversityStudentWithoutCar> _students = [];
  late final ProfilePage   _profile;  
  final ValueNotifier<Set<int>> _boardedIds = ValueNotifier(<int>{});
  final Set<int> _everAcceptedIds = {};
  final ValueNotifier<List<UniversityStudentWithoutCar>> _acceptedNotifier = ValueNotifier([]);
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadStudents();
    _profile   = const ProfilePage();
  }

  Future<void> loadStudents() async {
    
    List<UniversityStudentWithoutCar> students = await WithoutCarService().getStudentsWithoutCar();
    setState(() {
      _students = students;
    });
  }

  /// Filtra las solicitudes que nunca fueron aceptadas
  List<UniversityStudentWithoutCar> get _pendingStudents {
    return _students.where((s) => !_everAcceptedIds.contains(s.id)).toList();
  }

  void _handleAccept(UniversityStudentWithoutCar s) {
    if (!_acceptedNotifier.value.any((e) => e.id == s.id)) {
      _acceptedNotifier.value = [..._acceptedNotifier.value, s];
      _everAcceptedIds.add(s.id);
    }
  }

  void _handleClear() {
    _acceptedNotifier.value = [];
    _boardedIds.value = <int>{};
    _everAcceptedIds.clear();
  }

  void _handleBoarded(UniversityStudentWithoutCar s) {
    _boardedIds.value = {..._boardedIds.value, s.id};
  }

  @override
  Widget build(BuildContext context) {
    final tripPage = TripPage(
      acceptedStudents: _acceptedNotifier,
      boardedIds: _boardedIds,
      onBoarded: _handleBoarded,
      onClear: _handleClear,
    );
    final startTrip = ValueListenableBuilder<List<UniversityStudentWithoutCar>>(
      valueListenable: _acceptedNotifier,
      builder: (_, __, ___) {
        return StartTripPage(
          students: _pendingStudents,
          acceptedStudents: _acceptedNotifier,
          boardedIds: _boardedIds,
          onAccept: _handleAccept,
        );
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(3, 72, 141, 0.63), //255, 88, 116, 176
            ),
            child: Row(
              children: [
                Image.asset('assets/logo.png'),
                const SizedBox(width: 10),
                const Text("RideUp", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      final url = Uri.parse('https://unilink-grupo3.github.io/RideUp-Landing-Page/');
                      print(await canLaunchUrl(url));
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.inAppBrowserView); //externalApplication
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("No se pudo abrir el enlace")),
                        );
                      }
                    },
                    child: const Text(
                      'Conócenos',
                      style: TextStyle(
                        color: Colors.white, // opcional para que se vea como link
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            // StartTripPage(
            //   students: _students,
            //   acceptedStudents: _acceptedStudents,
            //   boardedIds: _boardedIds,
            //   onAccept: _handleAccept,
            // ),
            //_startTrip,
            startTrip,
            tripPage,
            _profile,
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(3, 72, 141, 0.63),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.travel_explore), label: 'Trip'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
