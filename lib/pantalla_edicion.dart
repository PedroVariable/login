import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pantalla_vista.dart';
import 'pantalla_registro.dart';

class PantallaEdicion extends StatefulWidget {
  @override
  _PantallaEdicionState createState() => _PantallaEdicionState();
}

class _PantallaEdicionState extends State<PantallaEdicion> {
  final TextEditingController _nombreController = TextEditingController();

  void _cargarNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nombreController.text = prefs.getString('nombre') ?? '';
    });
  }

  void _actualizarNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', _nombreController.text);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => PantallaVista()),
      (route) => false,
    );
  }

  void _eliminarNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('nombre');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => PantallaRegistro()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _cargarNombre();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Nombre'),
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
              onPressed: _actualizarNombre,
              child: Text('Guardar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: _eliminarNombre,
              child: Text('Eliminar'),
            ),
          ],
        ),
      ),
    );
  }
}
