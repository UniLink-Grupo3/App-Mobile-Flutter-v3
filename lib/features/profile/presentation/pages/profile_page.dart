import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_page/features/profile/presentation/bloc/driver_bloc.dart';
import 'package:profile_page/features/profile/presentation/bloc/driver_event.dart';
import 'package:profile_page/features/profile/presentation/bloc/driver_state.dart';
import 'package:profile_page/features/profile/presentation/widgets/profile_edit_form.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<DriverBloc>().add(
      GetDriverInfo()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Color del fondo de la pantalla. AQUI
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'PERFIL',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
          ),
        centerTitle: true,
        backgroundColor: Colors.blue[100], 
      ),
      body: BlocConsumer<DriverBloc, DriverState>(
        listener:(context, state) {
          if (state is ErrorDriverState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder:(context, state) {
          if (state is LoadingDriverState) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is LoadedDriverState || state is UpdatedDriverInfoState) {
            final driver = (state is LoadedDriverState) 
                ? state.driver 
                : (state as UpdatedDriverInfoState).driver;
                
            return ProfileEditForm(driver: driver);
          }
          return const Center(child: Text('Error al cargar el perfil'));
        },
      ),
    );
  }
}
