import 'package:fisi_2023_0_tribusregueton_donomar_fe/providers/cita_provider.dart';
import 'package:flutter/material.dart';
import 'package:fisi_2023_0_tribusregueton_donomar_fe/styles/colors.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/cita.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Cita>? citas;
  Cita? citaUnica;
  Image imageProm = Image.network(
      "https://media.licdn.com/dms/image/C4E03AQGlS7CNoN92tg/profile-displayphoto-shrink_800_800/0/1651168613369?e=1683158400&v=beta&t=7wjXsPRqa9eIkRO-NBSHqnocQS4KSMpn8GTO5zxdUbE");
  bool imageIsLoading = true;

  @override
  void initState() {
    imageProm.image.resolve(new ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo image, bool synchronousCall) {
      if (mounted) setState(() => imageIsLoading = false);
    }));
    getCitas();

    super.initState();
  }

  getCitas() async {
    final citaProvider = Provider.of<CitaProvider>(context, listen: false);
    final clienteId = Get.arguments['cliente'].clienteId;
    await citaProvider.getCitasOnDisplay(clienteId);
    final data = citaProvider.listacitas;
    setState(() {
      if (data != null) {
        citas = data;
        if (citas!.length > 0) {
          citaUnica = data[0];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;
    final heightDevice = MediaQuery.of(context).size.height;
    final colorGreenNotifButton = Color(0xFF03BB85);
    final colorBlackNotifIcon = Colors.black87;
    final colorWhiteNotifIcon = Colors.white;
    final colorAmberService = Color.fromARGB(255, 255, 206, 71);
    final colorRedService = Color.fromARGB(255, 247, 76, 87);
    print('CITAS');
    print(citas);
    final List<String> servicios = [];
    servicios.add('Limpieza dental');
    servicios.add('Curación dental');
    servicios.add('Profilaxis');
    servicios.add('Ortodoncia');
    servicios.add('Blanqueamiento dental');

    final userName = Get.arguments['cliente'].nombres;

    final citaviewProvider = Provider.of<CitaProvider>(context, listen: true);
    
    return Container(
      alignment: imageIsLoading || citas==null ? Alignment.center : Alignment.topCenter,
      child: 
      (imageIsLoading || citas==null) ?
        CircularProgressIndicator()
      :
      Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40),
            height: 90,
            child: Row(
              children: [
                Container(
                  
                  padding: EdgeInsets.only(left: widthDevice * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hola',
                        style: TextStyle(fontSize: 13),
                      ),
                      Row(
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: widthDevice * 0.012),
                          Icon(
                            Icons.waving_hand_outlined,
                            color: Colors.amber[600],
                          )
                        ],
                      )
                    ],
                  ),
                  width: widthDevice * 0.5,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: widthDevice * 0.07, right: widthDevice * 0.01),
                  width: widthDevice * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widthDevice * 0.1,
                        height: widthDevice * 0.1,
                        child: RawMaterialButton(
                            child: Icon(Icons.notifications_none,
                                size: widthDevice * 0.09,
                                color: colorBlackNotifIcon),
                            shape: CircleBorder(),
                            elevation: 0.0,
                            fillColor: colorGreenNotifButton,
                            onPressed: () {}),
                      ),
                      CircleAvatar(
                        radius: widthDevice * 0.05,
                        backgroundImage: imageProm.image,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  left: widthDevice * 0.05,
                  right: widthDevice * 0.05,
                  top: heightDevice * 0.005,
                  bottom: heightDevice * 0.02),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Promociones',
                    style: TextStyle(
                        fontFamily: 'Mitr',
                        fontWeight: FontWeight.w300,
                        color: colorGreenNotifButton,
                        fontSize: widthDevice * 0.075),
                  ),
                  Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color(MyColors.primary),
                          borderRadius:
                              BorderRadius.circular(widthDevice * 0.08),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://static.wixstatic.com/media/a4d05f_a9371d85ff084df5a37cd8aa472440fd.png/v1/fill/w_512,h_240,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/a4d05f_a9371d85ff084df5a37cd8aa472440fd.png"),
                            fit: BoxFit.cover,
                          ))),
                  SizedBox(height: heightDevice * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mis citas',
                        style: TextStyle(
                            fontFamily: 'Mitr',
                            fontWeight: FontWeight.w300,
                            color: colorGreenNotifButton,
                            fontSize: widthDevice * 0.075),
                      ),
                      Text(
                        'Ver todos',
                        style: TextStyle(
                            fontFamily: 'Mitr',
                            fontWeight: FontWeight.w300,
                            color: Colors.amber[700],
                            fontSize: widthDevice * 0.06),
                      ),
                    ],
                  ),
                  citaUnica == null
                      ? Text(
                          'No tiene citas ',
                          style: TextStyle(
                              fontFamily: 'Mitr',
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 197, 99, 8),
                              fontSize: widthDevice * 0.04),
                        )
                      : (Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(MyColors.primary),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "https://pbs.twimg.com/profile_images/655891199656595456/6woCUEpD_400x400.jpg"),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(citaUnica!.nombreDoctor,
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  'Especialista Dental',
                                                  style: TextStyle(
                                                      color: Color(
                                                          MyColors.text01)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color(MyColors.bg01),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: double.infinity,
                                          padding: EdgeInsets.all(15),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                citaUnica!.fechaCita
                                                    .split(' ')[0],
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Icon(
                                                Icons.access_alarm,
                                                color: Colors.white,
                                                size: 17,
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '${citaUnica!.horaCita} AM',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Icon(
                                                Icons.medication_outlined,
                                                color: Colors.white,
                                                size: 17,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  citaUnica!.nombreServicio,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              width: double.infinity,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Color(MyColors.bg02),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              width: double.infinity,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Color(MyColors.bg03),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        )),
                  SizedBox(height: heightDevice * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Servicios',
                        style: TextStyle(
                            fontFamily: 'Mitr',
                            fontWeight: FontWeight.w300,
                            color: colorGreenNotifButton,
                            fontSize: widthDevice * 0.075),
                      ),
                      Text(
                        'Ver todos',
                        style: TextStyle(
                            fontFamily: 'Mitr',
                            fontWeight: FontWeight.w300,
                            color: Colors.amber[700],
                            fontSize: widthDevice * 0.06),
                      ),
                    ],
                  ),
                  Container(
                    height: 210,
                    width: widthDevice * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            print('Container 1');
                          },
                          child: Container(
                            width: widthDevice * 0.4,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(widthDevice * 0.05),
                              color: colorAmberService,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(top: heightDevice * 0.01),
                                  child: Text(
                                    'Limpieza dental',
                                    style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  height: 50,
                                  alignment: Alignment.center,
                                ),
                                Container(
                                  height: 150,
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/cepillo.png')),
                                  alignment: Alignment.center,
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print('Container 2');
                          },
                          child: Container(
                            width: widthDevice * 0.4,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(widthDevice * 0.05),
                              color: colorRedService,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(top: heightDevice * 0.01),
                                  child: Text(
                                    'Curación dental',
                                    style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  height: 50,
                                  alignment: Alignment.center,
                                ),
                                Container(
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/herramientas.png')),
                                  height: 150,
                                  alignment: Alignment.center,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}