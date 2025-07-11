import 'package:flutter/material.dart';
import 'package:profile_page/features/security/data/datasource/user_register_service.dart';
import 'package:profile_page/features/security/data/models/user_register_dto.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

bool _obscurePassword = true;

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
  final user = UserRegisterDto(
    nombre: _nameController.text.trim(),
    correo: _emailController.text.trim(),
    numero: _phoneController.text.trim(),
    contrasena: _passwordController.text.trim(),
  );

  // Mostrar un banner de carga (opcional)
  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registrando usuario...')),
    );
  }

  try {
    // Esperar el registro
    await UserRegisterService().registerUser(user);

    // Verificar si el widget sigue montado antes de usar context
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Oculta el anterior
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario registrado con éxito')),
    );

    // Limpiar campos
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _passwordController.clear();

  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al registrar: $e')),
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
            const SizedBox(height: 20), // Sirve para separar el contenido del borde superior
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
            const SizedBox(height: 20),
            Center(
              child: Image.asset('assets/logo.png', width: 100, height: 100),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Nombre completo',
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.person),
                ),
              ),
            ),
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
                controller: _phoneController,
                decoration: const InputDecoration(
                  hintText: 'Teléfono',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.phone_android)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: TextField(
                obscureText: _obscurePassword,
                controller: _passwordController,
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
                onPressed: () async {
                  await _registerUser();

                  if (mounted) {
                    Navigator.pop(context); // Regresa a la página anterior
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(3, 72, 141, 0.63),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
