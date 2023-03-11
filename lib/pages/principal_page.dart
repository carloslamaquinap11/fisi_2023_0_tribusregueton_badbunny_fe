import 'package:fisi_2023_0_tribusregueton_donomar_fe/constants/constant.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/pages/appointment_page.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/pages/home_page.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/pages/service_page.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/navigation_page_provider.dart';

class NavigationBottomWidget extends StatefulWidget {
  final int myIndexSelected;

  const NavigationBottomWidget({this.myIndexSelected=0});

  @override
  State<NavigationBottomWidget> createState() => _NavigationBottomWidgetState();
}

class _NavigationBottomWidgetState extends State<NavigationBottomWidget> {
  int selectedIndex=0;

  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    // Home(),
    AppointmentPage(),
    ServicePage(),
    SettingPage(),
  ];

  // void _onItemTapped(int index) {
  //   print('INDEX PRESIONADO');
  //   print(index);
  //   setState(() {
  //     selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    final navigationPage = Provider.of<NavigationPageProvider>(context, listen: true);
    selectedIndex = navigationPage.indexPage;
    
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        selectedLabelStyle: TextStyle(fontSize: 15),
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Citas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'Servicios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
        currentIndex: navigationPage.indexPage,
        selectedItemColor: Color.fromARGB(255, 6, 218, 154),
        onTap: (value){
          navigationPage.changeIndexPage(value);
        },
      ),
    );
  }
}
