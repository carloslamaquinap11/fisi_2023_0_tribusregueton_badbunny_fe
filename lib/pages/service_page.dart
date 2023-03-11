import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/citaViewModel.dart';
import '../providers/citaviewmodel_provider.dart';

import 'package:pay/pay.dart';

import '../providers/navigation_page_provider.dart';

//Clase Todo para enviar valores entre paginas
class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Center(
    //     child: Text('Pagina de Servicios Dentales'),
    //   ),
    // );

    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Nuestros Servicios',
      home: ServiceSite(),
    );
  }
}

class ServiceSite extends StatefulWidget {
  const ServiceSite({Key? key}) : super(key: key);
  @override
  State<ServiceSite> createState() => _ServiceSite();
}

class _ServiceSite extends State<ServiceSite> {
  // The inital group value
  // String _selectedService = 'consulta_general';






  String selectedService = '';

  final _formKey = GlobalKey<FormState>();
  String _id = '';
  String _address = '';
  String _doctorName = '';
  DateTime _dateTime = DateTime.now();
  String _observation = '';
  String _motivo = '';
  TextEditingController _dateTimeController = TextEditingController();
  final List<String> services = [];

  GlobalKey<_MyDropDownState> _dropdownKeyServicio =
      GlobalKey<_MyDropDownState>();
  GlobalKey<_MyDropDownState> _dropdownKeyMedico =
      GlobalKey<_MyDropDownState>();
  GlobalKey<_MyDropDownState> _dropdownKeySede = GlobalKey<_MyDropDownState>();

  static final Map<String, dynamic> citaValues = {
    'doctorId': 0,
    'clienteId': 0,
    'servicioId': 0,
    'observacion': '',
    'motivo': '',
    'fechaCita': '',
    'horaCita': 0,
    'local': ''
  };

  @override
  Widget build(BuildContext context) {
    final insertarCita = Provider.of<CitaVMProvider>(context, listen: true);
    print('texto1');
    final cliente = Get.arguments["cliente"];
    print('texto2');

    const _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: '99.99',
        status: PaymentItemStatus.final_price,
      )
    ];

    const String defaultGooglePayConfigString = '''{
      "provider": "google_pay",
      "data": {
        "environment": "TEST",
        "apiVersion": 2,
        "apiVersionMinor": 0,
        "allowedPaymentMethods": [
          {
            "type": "CARD",
            "tokenizationSpecification": {
              "type": "PAYMENT_GATEWAY",
              "parameters": {
                "gateway": "example",
                "gatewayMerchantId": "gatewayMerchantId"
              }
            },
            "parameters": {
              "allowedCardNetworks": ["VISA", "MASTERCARD"],
              "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
              "billingAddressRequired": true,
              "billingAddressParameters": {
                "format": "FULL",
                "phoneNumberRequired": true
              }
            }
          }
        ],
        "merchantInfo": {
          "merchantId": "01234567890123456789",
          "merchantName": "Example Merchant Name"
        },
        "transactionInfo": {
          "countryCode": "US",
          "currencyCode": "USD"
        }
      }
    }''';




    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Cita'),
        backgroundColor: Color.fromARGB(218, 6, 218, 155),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyDropDown(key: _dropdownKeyServicio, list: [
                'Consulta General',
                'Limpieza dental',
                'Curacion',
                'Aplicacion Fluor',
                'Extracción dental',
                'Radiografia',
                'Blanqueamiento',
              ]), // SERVICIOOOOOOOO
              TextFormField(
                decoration: InputDecoration(labelText: 'DNI: ${cliente.dni}'),
                readOnly: true,
              ),
              MyDropDown(
                key: _dropdownKeyMedico,
                list: [
                  'Piero Curay Chacon',
                  'Xavier Mejia Benito',
                  'Andre	Huancas Cuicapuza',
                  'Jose Carlos Ponce',
                  'Marco Antonio Solis',
                  'Roberto Hernandez Soto',
                ],
              ),
              MyDropDown(
                key: _dropdownKeySede,
                list: [
                  'Los Olivos',
                  'Independencia',
                  'Comas',
                  'Cercado de Lima'
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fecha y hora'),
                readOnly: true,
                controller: _dateTimeController,
                onTap: () async {
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (dateTime != null) {
                    TimeOfDay? timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (timeOfDay != null) {
                      setState(() {
                        _dateTime = DateTime(
                          dateTime.year,
                          dateTime.month,
                          dateTime.day,
                          timeOfDay.hour,
                          timeOfDay.minute,
                        );
                        _dateTimeController.text = _dateTime != null
                            ? DateFormat('yyyy-MM-dd HH:mm').format(_dateTime!)
                            : '';
                      });
                    }
                  }
                },
                validator: (value) {
                  if (_dateTime == null || value!.isEmpty) {
                    return 'Debe seleccionar una fecha y hora';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Motivo de la cita'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  _motivo = value!;
                  setState(() {
                    _motivo = value!;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Observaciones'),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {
                  _observation = value!;
                  setState(() {
                    _observation = value!;
                  });
                },
              ),
              // Container(
              //   child: GooglePayButton(
              //     paymentConfiguration: PaymentConfiguration.fromJsonString(
              //         defaultGooglePayConfigString),
              //     paymentItems: _paymentItems,
              //     type: GooglePayButtonType.pay,
              //     margin: const EdgeInsets.only(top: 15.0),
              //     onPaymentResult: onGooglePayResult,
              //     loadingIndicator: const Center(
              //       child: CircularProgressIndicator(),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(218, 6, 218, 155),
        onPressed: () async {
          citaValues['clienteId'] = cliente.clienteId;
          citaValues['doctorId'] =
              _dropdownKeyMedico.currentState!.getSelectedIndex();
          citaValues['servicioId'] =
              _dropdownKeyServicio.currentState!.getSelectedIndex();
          citaValues['observacion'] = _observation;
          citaValues['motivo'] = _motivo; //_motivo; probar pq no funca
          citaValues['fechaCita'] = _dateTimeController.text.split(' ')[0];
          citaValues['horaCita'] =
              int.parse(_dateTimeController.text.split(' ')[1].substring(0, 2));
          citaValues['local'] =
              _dropdownKeySede.currentState!.getSelectedValue();

          CitaViewModel citaenviar = CitaViewModel.fromMap(citaValues);

          print(citaValues);
          if (_formKey.currentState?.validate() == true) {
            _formKey.currentState?.save();
          }

          await insertarCita.insertCitaCompleta(citaenviar);
          print('cita insertada');
          print('nos fuimos a pricnipal');
          await _dialogBuilder(context);
          
        },
        child: Icon(Icons.send),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
    print('SE HIZO EL PAGO CORRECTAMENTE');
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final navigationPage = Provider.of<NavigationPageProvider>(context, listen: false);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          title: const Text('Éxito'),
          content: const Text('Cita registrada correctamente!'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                navigationPage.changeIndexPage(0);
              },
            ),
          ],
        );
      },
    );
  }
}

class MyDropDown extends StatefulWidget {
  final List<String> list;
  final Key key;

  const MyDropDown({required this.key, required this.list}) : super(key: key);

  @override
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String dropdownValue = "";

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Color.fromARGB(255, 58, 183, 146)),
      underline: Container(
        height: 2,
        color: Color.fromARGB(255, 58, 183, 146),
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
          print(dropdownValue);
        });
      },
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  String getSelectedValue() {
    return dropdownValue;
  }

  int getSelectedIndex() {
    return widget.list.indexOf(dropdownValue) + 1;
  }
}
