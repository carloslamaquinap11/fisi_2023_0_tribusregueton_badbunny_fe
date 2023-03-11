import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/cita.dart';
import '../providers/cita_provider.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();

  
}

class _AppointmentPageState extends State<AppointmentPage> {

  List<Cita>? citas;
  @override
  void initState() {
    getCitasByClientId();
    super.initState();
  }

  getCitasByClientId() async {
    final citaProvider = Provider.of<CitaProvider>(context, listen: false);
    final clienteId = Get.arguments['cliente'].clienteId;
    await citaProvider.getCitasOnDisplay(clienteId);
    final data = citaProvider.listacitas;
    setState(() {
      if (data != null) {
        citas = data;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorGreen = Color(0xFF03BB85);
    return Column(
      children: [
        Container(
          color: colorGreen,
          child: Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 40),
                height: 90,
                width: double.infinity,
                child: Text('Citas agendadas',style: TextStyle(fontFamily: 'Mitr',color: Colors.white,fontSize: 25),),
              ),
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Color.fromARGB(255, 255, 255, 255),
            alignment: citas!=null && citas!.isNotEmpty ? Alignment.topCenter : Alignment.center,
            child: SingleChildScrollView(
              // color: Colors.white,
              padding: EdgeInsets.only(top: 20,left: 40,right: 40,bottom: 20),
              child: 
                  citas==null ? CircularProgressIndicator()
                  : citas!.length<1 ? Center(child: Text('Sin datos'))
                  : Column(
                    // mainAxisAlignment: citas!=null && citas!.isNotEmpty ? MainAxisAlignment.center : MainAxisAlignment.end,
                      children: citas!.map(
                          (cita)=>AppointmentCard(cita)
                        ).toList() ?? [] ),
            ),
          ),
        ),
        
      ],
    );
  }
  Widget AppointmentCard(Cita cita){
    // final formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.parse(cita.fechaCita));
    return Column(
      children: [
        Container(
          height: 160,
          padding: EdgeInsets.only(left: 20,right: 10),
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // color: Colors.white,
            gradient: LinearGradient(
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                  colors: [Color.fromRGBO(76, 74, 185, 0.922), Color.fromRGBO(123, 122, 197, 0.776)])
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.supervised_user_circle_rounded,color: Colors.white,size: 45),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dr. ${cita.nombreDoctor}',style: TextStyle(color: Colors.white,fontFamily: 'Mitr',fontSize: 18,fontWeight: FontWeight.w500),),
                            Text('${cita.especialidad}',style: TextStyle(color: Colors.white,fontFamily: 'Mitr',fontSize: 13,),)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.navigate_next_rounded,color: Colors.white,size: 45),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.timer_outlined,color: Colors.white,size: 45),
                  SizedBox(width: 10,),
                  Text('${cita.fechaCita.split(' ')[0]} ${cita.horaCita}:00',style: TextStyle(color: Colors.white,fontFamily: 'Mitr',fontSize: 15,fontWeight: FontWeight.w100),),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.medical_services_outlined,color: Colors.white,size: 45),
                  SizedBox(width: 10,),
                  Text(cita.nombreServicio,style: TextStyle(color: Colors.white,fontFamily: 'Mitr',fontSize: 15,fontWeight: FontWeight.w100),)
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 25,)
      ],
    );
  }
}