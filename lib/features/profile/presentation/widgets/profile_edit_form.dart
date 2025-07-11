import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_page/features/profile/domain/driver.dart';
import 'package:profile_page/features/profile/presentation/bloc/driver_bloc.dart';
import 'package:profile_page/features/profile/presentation/bloc/driver_event.dart';

class ProfileEditForm extends StatefulWidget {
  final Driver driver; // Asumiendo que Driver es una clase que contiene la información del conductor

  const ProfileEditForm({super.key, required this.driver});

  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {

  late bool isEditing = false; // Variable para controlar el modo de edición
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController universityController;
  late TextEditingController carController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    isEditing = false; // Iniciar en modo de visualización
    // Inicializar los controladores con los valores del conductor
    nameController = TextEditingController(text: widget.driver.name);
    emailController = TextEditingController(text: widget.driver.mail);
    universityController = TextEditingController(text: widget.driver.university);
    phoneController = TextEditingController(text: widget.driver.phone);
    carController = TextEditingController(text: widget.driver.car);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    universityController.dispose();
    carController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            //seccion del avatar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/image.png'),
                ),
              ),
            ),

            //---------Seccion de nombres
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                readOnly: !isEditing, // Hace que el campo sea de solo lectura,
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),


            //---------Seccion del email
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                readOnly: !isEditing,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            

            //---------Seccion de Univeristy
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                readOnly: !isEditing,
                controller: universityController,
                decoration: InputDecoration(
                  labelText: 'Univeristy',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //---------Seccion del phone
            
Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                readOnly: !isEditing,
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Numero',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //---------Seccion de car
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                readOnly: !isEditing,
                controller: carController,
                decoration: InputDecoration(
                  labelText: 'Car',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            

            //---------Boton de Save
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                      setState(() {
                      isEditing = !isEditing; // Alternar entre editar y guardar
                    });

                    if (!isEditing) {
                      // Aquí iría la lógica para guardar los cambios
                      
                      context.read<DriverBloc>().add(UpdateDriverInfo(
                        id: widget.driver.id, 
                        name: nameController.text,
                        mail: emailController.text,
                        university: universityController.text,
                        phone: widget.driver.phone, 
                        car: carController.text,
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50), // Cambia el tamaño del botón
                    backgroundColor: Colors.blue[100], 
                    textStyle: TextStyle(color: Colors.black)// Cambia el color del botón
                  ),
                  child: Text(
                    isEditing ? 'Guardar' : 'Editar',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold, // Cambia el color del texto del botón
                      fontSize: 20, // Cambia el tamaño del texto del botón),
                    ), // Cambia el texto del botón
                ),
              ),
            ),
            ),
            const Spacer(),
             Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                      
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(50, 50), // Cambia el tamaño del botón
                    backgroundColor: Colors.red, 
                    textStyle: TextStyle(color: Colors.black)// Cambia el color del botón
                  ),
                  child: Text(
                     'Cerrar Sesión',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold, // Cambia el color del texto del botón
                      fontSize: 20, // Cambia el tamaño del texto del botón),
                    ), // Cambia el texto del botón
                ),
              ),
                          ),
            ),

          ],
        );
  }
}