import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/citaViewModel.dart';
import '../models/cliente.dart';
import '../models/login.dart';

class CitaVMProvider extends ChangeNotifier {
  String _apiKey = '';
  String _baseUrl = 'applicationfisident20230306204218.azurewebsites.net';

  CitaVMProvider() {
    // CitaViewModel citavm = CitaViewModel(
    //     doctorId: 3,
    //     clienteId: 5,
    //     servicioId: 4,
    //     observacion: 'string',
    //     motivo: 'string',
    //     fechaCita: '2023-05-10',
    //     horaCita: 11,
    //     local: 'Norte');
    // insertCitaCompleta(citavm);
  }

  insertCitaCompleta(CitaViewModel citavm) async {
    print('INICIO CVM PROVIDER');
    Map<String, dynamic> dataquery = {
      'insertcita': citavm.toJson(),
    };
    print(dataquery);
    print('CONVERTIR EN VM');
    var url = Uri.https(_baseUrl, '/api/Cita');
    print(url);
    print('ENVIAR VM');
    final response = await http.post(url, body: citavm.toJson(), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      print(response.body);
      //cliente = Cliente.fromJson(response.body);
    } else {
      print('---' + response.body);
    }
    notifyListeners();
    print('FIN registrarcitavm');
  }
}
