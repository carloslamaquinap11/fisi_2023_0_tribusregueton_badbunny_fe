import 'package:fisi_2023_0_tribusregueton_donomar_fe/bloc/user/user_bloc.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/pages/login_page.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/pages/principal_page.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/providers/cita_provider.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/providers/navigation_page_provider.dart';
import 'package:flutter/material.dart';

import 'package:fisi_2023_0_tribusregueton_donomar_fe/pages/pagina2_page.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/pages/pagina1_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'providers/citaviewmodel_provider.dart';
import 'providers/login_provider.dart';
import 'providers/servicio_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()),
        ChangeNotifierProvider(create: (_) => CitaProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => ServicioProvider(), lazy: false),
        ChangeNotifierProvider(
            create: (_) => LoginProvider('', ''), lazy: false),
        ChangeNotifierProvider(create: (_) => CitaVMProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => NavigationPageProvider(), lazy: false),
        
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        getPages: [
          GetPage(name: '/login', page: () => const LoginPage()),
          GetPage(
              name: '/principal', page: () => const NavigationBottomWidget()),
          GetPage(name: '/pagina1', page: () => const Pagina1Page()),
          GetPage(name: '/pagina2', page: () => const Pagina2Page()),
        ],
      ),
    );
  }
}
