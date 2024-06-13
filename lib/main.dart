import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pantalla_registro.dart';
import 'pantalla_vista.dart';

void main() {
  runApp(login());
}

class login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo de Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<String?>(
        future: _obtenerNombre(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return PantallaVista();
          } else {
            return PantallaRegistro();
          }
        },
      ),
    );
  }

  Future<String?> _obtenerNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nombre');
  }
}
