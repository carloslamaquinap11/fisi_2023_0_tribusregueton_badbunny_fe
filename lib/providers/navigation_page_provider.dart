import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cita.dart';

class NavigationPageProvider extends ChangeNotifier {
  
  int indexPage=0;

  CitaProvider() {
  }

  changeIndexPage(int index)  {
    indexPage=index;
    notifyListeners();
  }
}
