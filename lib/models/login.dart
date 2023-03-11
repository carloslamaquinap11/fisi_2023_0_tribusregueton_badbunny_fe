

import 'dart:convert';

class Login {
    Login({
        required this.userId,
        required this.email,
        required this.password,
        required this.rol,
    });

    int userId;
    String email;
    String password;
    int rol;
    
    factory Login.fromJson(String str) => Login.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Login.fromMap(Map<String, dynamic> json) => Login(
        userId: json["loginId"],
        email: json["email"],
        password: json["password"],
        rol: json["rol"],
    );

    static getListCita(String str){
      List<dynamic> parsedListJson = jsonDecode(str);
      List<Login> citas = List<Login>.from(parsedListJson.map<Login>((dynamic i) =>Login.fromMap(i)));
      return citas;
    }

    Map<String, dynamic> toMap() => {
        "userId": userId,
        "email": email,
        "password": password,
        "rol": rol,
    };

}