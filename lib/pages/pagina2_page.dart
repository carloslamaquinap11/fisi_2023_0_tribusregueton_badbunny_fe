import 'package:fisi_2023_0_tribusregueton_donomar_fe/bloc/user/user_bloc.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Pagina2Page extends StatelessWidget {
  
  const Pagina2Page({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

    final UserBloc userBloc = BlocProvider.of<UserBloc>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            MaterialButton(
              child: const Text('Establecer Usuario', style: TextStyle( color: Colors.white ) ),
              color: Colors.blue,
              onPressed: () {
                final newUser = User(
                  nombre: 'Carlos',
                  edad: 24,
                  profesiones: ['FullStack Developer']
                );
                // BlocProvider.of<UserBloc>(context,listen: false).add( ActivateUser(newUser) );
                userBloc.add( ActivateUser(newUser) );
              }
            ),

            MaterialButton(
              child: const Text('Cambiar Edad', style: TextStyle( color: Colors.white ) ),
              color: Colors.blue,
              onPressed: () {
                // BlocProvider.of<UserBloc>(context,listen: false).add( ChangeUserAge(29) );
                userBloc.add( ChangeUserAge(29) );
              }
            ),

            MaterialButton(
              child: const Text('Añadir Profesion', style: TextStyle( color: Colors.white ) ),
              color: Colors.blue,
              onPressed: () {
                userBloc.add( AddProfesionUser('Ingeniero de sistemas') );
              }
            ),

          ],
        )
     ),
   );
  }
}