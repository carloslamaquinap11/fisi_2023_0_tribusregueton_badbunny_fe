import 'package:fisi_2023_0_tribusregueton_donomar_fe/bloc/user/user_bloc.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Pagina1Page extends StatelessWidget {
  
  const Pagina1Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina 1'),
      ),
      body: BlocBuilder<UserBloc,UserState>(
        builder: (context,state) {

          return state.existUser?
          InformacionUsuario(user: state.user!,)
          :const Center(
            child: Text('No hay usuario seleccionado'),
          );
        }
      ),

     floatingActionButton: FloatingActionButton(
       child: const Icon( Icons.accessibility_new ),
       onPressed: () => Navigator.pushNamed(context, 'pagina2')
     ),
   );
  }
}

class InformacionUsuario extends StatelessWidget {
  
  final User user;

  const InformacionUsuario({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text('General', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ) ),
          Divider(),

          ListTile( title: Text('Nombre: ${user.nombre}') ),
          ListTile( title: Text('Edad: ${user.edad}') ),

          Text('Profesiones', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ) ),
          Divider(),

          ...user.profesiones.map(
            (prof)=>ListTile(title:Text(prof))
          ).toList(),

          // ListTile( title: Text('Profesion 1') ),
          // ListTile( title: Text('Profesion 1') ),
          // ListTile( title: Text('Profesion 1') ),

        ],
      ),
    );
  }

}