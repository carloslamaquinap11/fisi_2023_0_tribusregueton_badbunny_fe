import 'dart:convert';

class Cliente {
    Cliente({
        required this.clienteId,
        required this.userId,
        required this.dni,
        required this.nombres,
        required this.apepat,
        required this.apemat,
        required this.celular,
    });

    int clienteId;
    int userId;
    String dni;
    String nombres;
    String apepat;
    String apemat;
    String celular;
    
    factory Cliente.fromJson(String str) => Cliente.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
        clienteId: json["clienteId"],
        userId: json["userId"],
        dni: json["dni"],
        nombres: json["nombres"],
        apepat: json["apepat"],
        apemat: json["apemat"],
        celular: json["celular"],
    );

    static getListCita(String str){
      List<dynamic> parsedListJson = jsonDecode(str);
      List<Cliente> citas = List<Cliente>.from(parsedListJson.map<Cliente>((dynamic i) =>Cliente.fromMap(i)));
      return citas;
    }

    Map<String, dynamic> toMap() => {
        "clienteId": clienteId,
        "userId": userId,
        "dni": dni,
        "nombres": nombres,
        "apepat": apepat,
        "apemat": apemat,
        "celular": celular,
    };
}