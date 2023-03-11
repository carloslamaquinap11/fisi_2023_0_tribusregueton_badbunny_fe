import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cliente.dart';
import '../models/login.dart';

class LoginProvider extends ChangeNotifier {
  String _apiKey = '';
  String _baseUrl = 'applicationfisident20230306204218.azurewebsites.net';

  Cliente cliente = Cliente(
      clienteId: 0,
      userId: 0,
      dni: '',
      nombres: '',
      apepat: '',
      apemat: '',
      celular: '');

  LoginProvider(String email, String password) {
    this.signIn(email, password);
  }

  signIn(String email, String password) async {
    // String email="ricardoninaquispeasdasd@gmail.com";String password="123";
    print('INICIO LOGIN PROVIDER');
    print(email);
    print(password);
    Map<String, dynamic> login = {'email': email, 'pass': password};
    var url = Uri.https(_baseUrl, '/api/Login/SignIn', login);
    final response = await http.post(url);
    if (response.statusCode == 200) {
      print(response.body);
      cliente = Cliente.fromJson(response.body);
    } else {
      print('---' + response.body);
    }
    notifyListeners();
    print('FIN LOGIN');
  }
}
