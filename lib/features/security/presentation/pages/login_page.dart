import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:profile_page/features/app/presentation/main_page.dart';
import 'package:profile_page/features/security/data/datasource/user_login_service.dart';
import 'package:profile_page/features/security/presentation/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Future<Position> determinePosition() async {
    //estan encendidos los servicios de ubicacion?
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Opcional: abre la pantalla de ajustes
    await Geolocator.openLocationSettings();
    throw Exception('Ubicación desactivada');
  }

  //tenemos permisos?
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever){
        return Future.error('Permiso de ubicación denegado');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void _showSnack(String msg) {                        // helper local
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    final correo = _emailController.text.trim();
    final contrasena = _passwordController.text.trim();

    if (correo.isEmpty || contrasena.isEmpty) {
      _showSnack('Completa todos los campos');
      return;
    }

    try {
      final isLoggedIn = await UserLoginService().login(correo, contrasena);

      if (!mounted) return;

      if (!isLoggedIn) {
        _showSnack('Credenciales incorrectas');
        return;
      }

      _showSnack('Inicio de sesión exitoso');

      await determinePosition();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainPage()),
      );
    } catch (e) {
      if (!mounted) return;
      _showSnack(
        e.toString().contains('Ubicación desactivada')
            ? 'Activa el GPS y vuelve a intentarlo.'
            : 'Necesitamos acceso a tu ubicación.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'RideUp',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Image.asset('assets/logo.png', width: 100, height: 100),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Correo electrónico',
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.email),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: _loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(3, 72, 141, 0.63),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                    );
                }, 
                child: Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(color: Color.fromRGBO(1, 35, 70, 0.627), fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
