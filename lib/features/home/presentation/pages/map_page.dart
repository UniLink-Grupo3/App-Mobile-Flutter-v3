import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:profile_page/features/home/domain/entities/university_student_without_car.dart';
import 'package:profile_page/features/home/presentation/views/student_request_sheet_view.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key, 
    required this.showLocation,
    required this.students,
    required this.onAccept,
    required this.boardedIds,
    required this.acceptedStudents,
  });

  final bool showLocation;
  final List<UniversityStudentWithoutCar> students;
  final ValueChanged<UniversityStudentWithoutCar> onAccept;
  final ValueNotifier<Set<int>> boardedIds; 
  final ValueListenable<List<UniversityStudentWithoutCar>> acceptedStudents;

  
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late BitmapDescriptor _car;
  late BitmapDescriptor _personBlue;
  late BitmapDescriptor _personGreen;
  final Set<int> _accepted = {};
  final Set<int> _rejected = {};
  final List<Marker> _userMarkers = [];
  static const LatLng _fakeCurrentLocation = LatLng(-12.0464, -77.0428);
  bool _iconsReady = false;
  
  @override
  void initState() {
    super.initState();
    _loadIcons();
  }
  
  Future<void> _loadIcons() async {
    _car = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/car.png',
    );
    _personBlue = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(24, 24)),
      'assets/person_blue.png',
    );
    _personGreen = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(24, 24)),
      'assets/person_green.png',
    );

    setState(() => _iconsReady = true);
  }

  Marker get _defaultMarker =>  Marker(
        markerId: MarkerId('current-location'),
        position: _fakeCurrentLocation,
        icon: _car,
        infoWindow: InfoWindow(title: 'Mi ubicación'),
      );

  Set<Marker> _buildStudentMarkers(Set<int> boarded, List<UniversityStudentWithoutCar> acceptedList) {
    final result = <Marker>{};

    for (final s in widget.students) {
      if (_rejected.contains(s.id)) continue;
      if (boarded.contains(s.id)) continue; 

      final bool isAccepted = acceptedList.any((e) => e.id == s.id);

      result.add(
        Marker(
          markerId: MarkerId('student-${s.id}'),
          position: LatLng(s.latitude, s.longitude),
          icon: isAccepted ? _personGreen : _personBlue, 
          infoWindow: isAccepted
              ? InfoWindow.noText
              : InfoWindow(title: s.name),
          //onTap: _accepted.contains(s.id) ? null : () => _showStudentInfo(s),
          onTap: isAccepted ? null : () => _showStudentInfo(s),
        ),
      );
    }
    return result;
  }

  @override
  void didUpdateWidget(covariant MapPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.showLocation && !oldWidget.showLocation) {
      _moveCameraToCurrentLocation();
      setState(() {
        _accepted.clear();
        _rejected.clear();
      });
    }
  }

  Future<void> _moveCameraToCurrentLocation() async {
    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(const CameraPosition(
        target: _fakeCurrentLocation,
        zoom: 15,
      )),
    );
  }

  void _onAccept(UniversityStudentWithoutCar s, BuildContext ctx) {
    setState(() {
      _accepted.add(s.id);
      _rejected.remove(s.id);
    });
    widget.onAccept(s);
    Navigator.pop(ctx);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Haz aceptado a ${s.name}')),
    );
  }

  void _showStudentInfo(UniversityStudentWithoutCar s) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) => StudentRequestSheetView(
        student: s, 
        onAccept: () =>  _onAccept(s, context),
        onReject: () {
          setState(() {
            _rejected.add(s.id);
            _accepted.remove(s.id);
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Has rechazado a ${s.name}')),
        );
      },
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_iconsReady) {
      return const Center(child: CircularProgressIndicator());
    }

    return ValueListenableBuilder<Set<int>>(
      valueListenable: widget.boardedIds,
      builder: (_, ids, __) {
        return ValueListenableBuilder<List<UniversityStudentWithoutCar>>(
          valueListenable: widget.acceptedStudents, // <--- Escucha lista de aceptados
          builder: (_, acceptedList, __) {
            final Set<Marker> markers = widget.showLocation
                ? <Marker>{
                    _defaultMarker,
                    ..._userMarkers,
                    ..._buildStudentMarkers(ids, acceptedList),
                  }
                : <Marker>{};

            return GoogleMap(
              myLocationEnabled: widget.showLocation,
              myLocationButtonEnabled: widget.showLocation,
              markers: markers,
              initialCameraPosition: const CameraPosition(
                target: _fakeCurrentLocation,
                zoom: 15,
              ),
            );
          },
        );
      },
    );
  }
}