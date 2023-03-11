import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cita.dart';

class CitaProvider extends ChangeNotifier {
  String _apiKey = '';
  String _baseUrl = 'applicationfisident20230306204218.azurewebsites.net';
  List<Cita>? listacitas;

  CitaProvider() {
    // this.getCitasOnDisplay(5);
  }

  getCitasOnDisplay(int id) async {
    var url = Uri.https(
        _baseUrl, '/api/Cita/GetCitaByClienteId/${id.toString()}', {});
    final response = await http.get(url);

    if (response.statusCode == 200) {
      listacitas = Cita.getListCita(response.body);
    }
    else{
      listacitas = [];
    }
    notifyListeners();
    //final Map<String, dynamic> decodedData = json.decode(response.body);
    //return listacitas;
    //print(response.body);
  }
}
