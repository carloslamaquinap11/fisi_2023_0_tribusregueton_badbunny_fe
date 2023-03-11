import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool light0 = true;
  bool light1 = true;
  bool light2 = true;
  bool rememberLogin = false;
  final colorGreenInput = Color(0xFF03BB85);

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Switch(
        //   value: light0,
        //   onChanged: (bool value) {
        //     setState(() {
        //       light0 = value;
        //     });
        //   },
        // ),
        // Switch(
        //   thumbIcon: thumbIcon,
        //   value: light1,
        //   onChanged: (bool value) {
        //     setState(() {
        //       light1 = value;
        //     });
        //   },
        // ),
        FlutterSwitch(
          activeColor: colorGreenInput,
          value: rememberLogin, 
          onToggle: (val) {
            
            setState(() {
              rememberLogin = rememberLogin == val? !val : val;
            });
          }
        ),
      ],
    );
  }
}
