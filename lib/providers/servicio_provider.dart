import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/servicio.dart';

class ServicioProvider extends ChangeNotifier {
  String _apiKey = '';
  String _baseUrl = 'applicationfisident20230306204218.azurewebsites.net';

  List<Servicio> servicios = [];

  ServicioProvider() {
    this.getAllServicio();
  }

  getAllServicio() async {
    var url = Uri.https(_baseUrl, '/api/Servicio', {});
    final response = await http.get(url);
    servicios = Servicio.getListServicio(response.body);
    notifyListeners();
  }
}
