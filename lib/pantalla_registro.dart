import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pantalla_vista.dart';

class PantallaRegistro extends StatefulWidget {
  @override
  _PantallaRegistroState createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final TextEditingController _nombreController = TextEditingController();

  void _guardarNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', _nombreController.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PantallaVista()),
    );
  }

  void _limpiarTexto() {
    _nombreController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarNombre,
              child: Text('Guardar'),
            ),
            ElevatedButton(
              onPressed: _limpiarTexto,
              child: Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }
}
