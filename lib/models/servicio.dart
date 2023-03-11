// class Servicio {
//   int servicioId;
//   String servicioNombre;

//   Servicio({required this.servicioId, required this.servicioNombre});

//   static List<Servicio> getUsers() {
//     return <Servicio>[
//       Servicio(servicioId: 1, servicioNombre: "Consulta General"),
//       Servicio(servicioId: 2, servicioNombre: "Limpieza Dental"),
//       Servicio(servicioId: 3, servicioNombre: "Aplicación de Fluor"),
//       Servicio(servicioId: 4, servicioNombre: "Extracción Dental"),
//       Servicio(servicioId: 5, servicioNombre: "Radiografía"),
//     ];
//   }
// }

import 'dart:convert';

class Servicio {
    Servicio({
        required this.servicioId,
        required this.nombre,
        required this.descripcion,
        required this.duracion,
        required this.precio,
    });

    int servicioId;
    String nombre;
    String descripcion;
    int duracion;
    int precio;

    factory Servicio.fromJson(String str) => Servicio.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Servicio.fromMap(Map<String, dynamic> json) => Servicio(
        servicioId: json["servicioId"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        duracion: json["duracion"],
        precio: json["precio"],
    );

    static getListServicio(String str){
      List<dynamic> parsedListJson = jsonDecode(str);
      List<Servicio> servicios = List<Servicio>.from(parsedListJson.map<Servicio>((dynamic i) =>Servicio.fromMap(i)));
      return servicios;
    }

    Map<String, dynamic> toMap() => {
        "servicioId": servicioId,
        "nombre": nombre,
        "descripcion": descripcion,
        "duracion": duracion,
        "precio": precio,
    };
}
