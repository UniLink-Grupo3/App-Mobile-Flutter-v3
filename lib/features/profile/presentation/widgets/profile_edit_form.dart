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

  @override
  void initState() {
    super.initState();
    isEditing = false; // Iniciar en modo de visualización
    // Inicializar los controladores con los valores del conductor
    nameController = TextEditingController(text: widget.driver.name);
    emailController = TextEditingController(text: widget.driver.mail);
    universityController = TextEditingController(text: widget.driver.university);
    carController = TextEditingController(text: widget.driver.car);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    universityController.dispose();
    carController.dispose();
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
              padding: const EdgeInsets.all(8.0),
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
                        car: carController.text,
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(isEditing ? 'Save' : 'Edit'), // Cambia el texto del botón
                ),
              ),
            ),
            
          ],
        );
  }
}