

import 'dart:convert';

class Cita {
    Cita({
        required this.citaId,
        required this.nombreDoctor,
        required this.especialidad,
        required this.fechaCita,
        required this.horaCita,
        required this.nombreServicio,
        required this.direccion,
        required this.observacion,
    });

    int citaId;
    String nombreDoctor;
    String especialidad;
    String fechaCita;
    String horaCita;
    String nombreServicio;
    String direccion;
    String observacion;
    
    factory Cita.fromJson(String str) => Cita.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Cita.fromMap(Map<String, dynamic> json) => Cita(
        citaId: json["citaId"],
        nombreDoctor: json["nombreDoctor"],
        especialidad: json["especialidad"],
        fechaCita: json["fechaCita"],
        horaCita: json["horaCita"],
        nombreServicio: json["nombreServicio"],
        direccion: json["direccion"],
        observacion: json["observacion"],
    );

    static getListCita(String str){
      List<dynamic> parsedListJson = jsonDecode(str);
      List<Cita> citas = List<Cita>.from(parsedListJson.map<Cita>((dynamic i) =>Cita.fromMap(i)));
      return citas;
    }

    Map<String, dynamic> toMap() => {
        "citaId": citaId,
        "nombreDoctor": nombreDoctor,
        "especialidad": especialidad,
        "fechaCita": fechaCita,
        "horaCita": horaCita,
        "nombreServicio": nombreServicio,
        "direccion": direccion,
        "observacion": observacion,
    };

}