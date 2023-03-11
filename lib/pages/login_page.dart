import 'package:fisi_2023_0_tribusregueton_donomar_fe/widgets/CustomSwitch.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  final String email = "";
  final String password = "";
  static bool rememberLogin = false;
  static final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  static final Map<String, String> formValues = {
    'email': 'micorreo@gmail.com',
    'password': '123123123'
  };

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;
    final heightDevice = MediaQuery.of(context).size.height;
    final colorGreen = Color(0xFF03BB85);
    final colorGreenClaro = Color(0xFF90FFCF);
    final colorWhite = Colors.white;
    final colorGreenInput = Color(0xFF03BB85);

    // final emailController = TextEditingController();
    // final passwordController = TextEditingController();

    final userProvider = Provider.of<LoginProvider>(context, listen: true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: widthDevice,
          height: heightDevice,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [colorGreen, Colors.black])),
          child: Center(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: heightDevice * 0.05),
                  height: heightDevice * 0.34,
                  color: Colors.transparent,
                  child: Image(image: AssetImage('assets/images/Logo.png')),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70)),
                      color: colorGreenClaro,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: heightDevice * 0.08,
                          child: Center(
                            child: Text(
                              'Iniciar sesión',
                              style: TextStyle(
                                  fontSize: heightDevice * 0.03,
                                  fontFamily: 'Mitr'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 30, bottom: 30, left: 70, right: 70),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(70),
                                  topRight: Radius.circular(70)),
                              color: colorWhite,
                            ),
                            child: Column(
                              children: [
                                CustomTextField(
                                  labelText: 'Correo',
                                  keyboardType: TextInputType.emailAddress,
                                  isPassword: false,
                                  formProperty: 'email',
                                  formValues: formValues,
                                ),
                                SizedBox(height: heightDevice * 0.025),
                                CustomTextField(
                                  labelText: 'Contraseña',
                                  keyboardType: TextInputType.text,
                                  isPassword: true,
                                  formProperty: 'password',
                                  formValues: formValues,
                                ),
                                SizedBox(height: heightDevice * 0.025),
                                Row(
                                  children: [
                                    CustomSwitch(),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Recuérdame',
                                      style: TextStyle(
                                          fontSize: heightDevice * 0.02,
                                          fontFamily: 'Mitr'),
                                    )
                                  ],
                                ),
                                SizedBox(height: heightDevice * 0.025),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                                (states) => colorGreenInput),
                                        minimumSize: MaterialStateProperty.all(
                                            Size(double.infinity,
                                                heightDevice * 0.06)),
                                        elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        heightDevice * 0.06)))),
                                    child: Text(
                                      'INGRESAR',
                                      style: TextStyle(
                                          fontFamily: 'Mitr',
                                          fontSize: heightDevice * 0.03),
                                    ),
                                    onPressed: () async {
                                      print('email: ${formValues["email"]}');
                                      print(
                                          'password: ${formValues["password"]}');

                                      if (formValues["email"] == '' ||
                                          formValues["password"] == '') {
                                        print('complete sus datos');
                                      } else {
                                        await userProvider.signIn(
                                            formValues["email"]!,
                                            formValues["password"]!);

                                        final cliente = userProvider.cliente;

                                        print(cliente.nombres);

                                        if (cliente.clienteId != 0) {
                                          Get.toNamed('principal',
                                              arguments: {'cliente': cliente});
                                        } else {
                                          _dialogBuilder(context);
                                        }
                                      }
                                    }),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      '¿Olvidó su contraseña?',
                                      style: TextStyle(
                                          fontFamily: 'Mitr',
                                          fontWeight: FontWeight.bold,
                                          color: colorGreenInput),
                                    )),
                                Text(
                                  '¿No tienes una cuenta?',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontFamily: 'Mitr'),
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.all(0),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap),
                                    onPressed: () {},
                                    child: Text(
                                      'Regístrese aquí',
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontWeight: FontWeight.bold,
                                        color: colorGreenInput,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ups!'),
          content: const Text('Datos incorrectos.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
