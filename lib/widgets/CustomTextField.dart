

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String? labelText;
  final TextInputType? keyboardType;
  final bool? isPassword;

  final String formProperty;
  final Map<String,String> formValues;
  // final TextEditingController controller;

  const CustomTextField({
    Key? key,
    this.labelText,
    this.keyboardType,
    this.isPassword,
    required this.formProperty, 
    required this.formValues,
    // required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final widthDevice = MediaQuery.of(context).size.width;
    final heightDevice = MediaQuery.of(context).size.height;
    final colorGreen = Color(0xFF03BB85);
    final colorGreenClaro = Color(0xFF90FFCF);
    final colorWhite = Colors.white;
    final colorGreenInput = Color(0xFF03BB85);

    return TextFormField(
      // controller: controller,
      cursorColor: colorGreenInput,
      keyboardType: keyboardType,
      obscureText: isPassword ?? false,
      style: TextStyle(
        fontSize: 21,
        color: Colors.black87,
        fontFamily: 'Mitr',
      ),
      onChanged: (value) => formValues[formProperty]=value,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15),
        label: Text(labelText!),
        labelStyle: TextStyle(
          fontSize: 21,
          color: Colors.black45,
          fontFamily: 'Mitr',
        ),
        floatingLabelStyle: TextStyle(
          color: colorGreenInput,
          fontSize: 25,
          fontFamily: 'Mitr',
          
        ),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 6,color: colorGreenInput),
          borderRadius: BorderRadius.circular(15),
        ),
        fillColor: colorWhite,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 6,color: Colors.black26),
          borderRadius: BorderRadius.circular(15)
        ),
      ),
    );
  }
}