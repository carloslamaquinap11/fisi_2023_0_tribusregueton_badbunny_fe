import 'dart:convert';

class CitaViewModel {
  CitaViewModel({
    required this.doctorId,
    required this.clienteId,
    required this.servicioId,
    required this.observacion,
    required this.motivo,
    required this.fechaCita,
    required this.horaCita,
    required this.local,
  });

  int doctorId;
  int clienteId;
  int servicioId;
  String observacion;
  String motivo;
  String fechaCita;
  int horaCita;
  String local;

  factory CitaViewModel.fromJson(String str) =>
      CitaViewModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CitaViewModel.fromMap(Map<String, dynamic> json) => CitaViewModel(
        doctorId: json["doctorId"],
        clienteId: json["clienteId"],
        servicioId: json["servicioId"],
        observacion: json["observacion"],
        motivo: json["motivo"],
        fechaCita: json["fechaCita"],
        horaCita: json["horaCita"],
        local: json["local"],
      );

  static getListCita(String str) {
    List<dynamic> parsedListJson = jsonDecode(str);
    List<CitaViewModel> citas = List<CitaViewModel>.from(parsedListJson
        .map<CitaViewModel>((dynamic i) => CitaViewModel.fromMap(i)));
    return citas;
  }

  Map<String, dynamic> toMap() => {
        'doctorId': doctorId,
        'clienteId': clienteId,
        'servicioId': servicioId,
        'observacion': observacion,
        'motivo': motivo,
        'fechaCita': fechaCita,
        'horaCita': horaCita,
        'local': local,
      };
}
