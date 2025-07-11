import 'package:flutter/material.dart';
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
  // final List<UniversityStudentWithoutCar> _students = [
  //   UniversityStudentWithoutCar(
  //     id: 1,
  //     name: "Juan Perez",
  //     code: "U20192B548",
  //     university: "UPC",
  //     image: "https://media.istockphoto.com/id/1438969575/es/foto/joven-estudiante-universitario-sonriente-con-auriculares-de-pie-en-un-aula.jpg?s=612x612&w=is&k=20&c=8UfEA51tCSP2D_JQ-vP_dMylcRPBM5WcVCpTVGsJjVI=",
  //     numberPeople: 3,
  //     destination: "UPC",
  //     pickup: "Av. Naranjal 1300, Los Olivos",
  //     price: 15,
  //     latitude: -12.048965938489417,
  //     longitude: -77.0378789305687,
  //   ),
  //   UniversityStudentWithoutCar(
  //     id: 2,
  //     name: "Maria Lopez",
  //     code: "U20201D647",
  //     university: "UPN",
  //     image: "https://media.istockphoto.com/id/1438437093/es/foto/mujer-adulta-joven-en-tomas-de-estudio-haciendo-expresiones-faciales-y-usando-los-dedos-y-las.jpg?s=612x612&w=is&k=20&c=oi7nnAHMJ5CwWbNjFYak1YTTcdKClkTSW5WDzPhxO5A=",
  //     numberPeople: 2,
  //     destination: "Plaza Norte",
  //     pickup: "Parque Zarumilla, Calle 21",
  //     price: 20,
  //     latitude: -12.050908350907829,
  //     longitude: -77.04230926930904,
  //   ),
  //   UniversityStudentWithoutCar(
  //     id: 3,
  //     name: "Carla Sanchez",
  //     code: "U20202F107",
  //     university: "UNI",
  //     image: "https://blog.ucsp.edu.pe/hs-fs/hubfs/estudiante%20universitario.jpg?width=1200&height=750&name=estudiante%20universitario.jpg",
  //     numberPeople: 2,
  //     destination: "Plaza San Miguel",
  //     pickup: "Av. Alfredo Mendiola 6232",
  //     price: 10,
  //     latitude: -12.046407401829834,
  //     longitude: -77.04829260706902,
  //   ),
  //   UniversityStudentWithoutCar(
  //     id: 4,
  //     name: "Alexander Guevara",
  //     code: "U20212C121",
  //     university: "PUCP",
  //     image: "https://media.istockphoto.com/id/1444206982/es/foto/liderazgo-mentor-o-estudiante-presentador-en-taller-de-educaci%C3%B3n-aprendizaje-o-ense%C3%B1anza-en-el.jpg?s=612x612&w=is&k=20&c=RtFcMhaLzrOLGEMIlLB-uYZYkO_IO2szjQRlrwcMXBo=",
  //     numberPeople: 2,
  //     destination: "Plaza San Miguel",
  //     pickup: "Av. Túpac Amaru 2200, Comas",
  //     price: 15,
  //     latitude: -12.040451487858595,
  //     longitude: -77.04618338495493,
  //   )
  // ];

  //final List<UniversityStudentWithoutCar> _acceptedStudents = [];
  //late final StartTripPage _startTrip;
  late final ProfilePage   _profile;  
  final ValueNotifier<Set<int>> _boardedIds = ValueNotifier(<int>{});
  final Set<int> _everAcceptedIds = {};
  final ValueNotifier<List<UniversityStudentWithoutCar>> _acceptedNotifier = ValueNotifier([]);
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadStudents(); // Cargar estudiantes al iniciar
    // _startTrip = StartTripPage(
    //   students: _students,
    //   acceptedStudents: _acceptedStudents,
    //   boardedIds: _boardedIds,
    //   onAccept: _handleAccept,
    // );
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Conócenos", style: TextStyle(color: Colors.white),),
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
