import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pantalla_edicion.dart';
import 'pantalla_registro.dart';

class PantallaVista extends StatefulWidget {
  @override
  _PantallaVistaState createState() => _PantallaVistaState();
  
}

class _PantallaVistaState extends State<PantallaVista> {
  String? _nombre;

  @override
  void initState() {
    super.initState();
    print(_cargarNombre);
    _cargarNombre();
  }

  void _cargarNombre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nombre = prefs.getString('nombre');
    });
  }

  void _cerrarSesion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('nombre');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => PantallaRegistro()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Nombre'),
      ),
      body: Center(
        child: _nombre == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hola, $_nombre!'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PantallaEdicion()),
                      ).then((_) => _cargarNombre());
                    },
                    child: Text('Editar'),
                  ),
                  ElevatedButton(
                    onPressed: () => _cerrarSesion(context),
                    child: Text('Cerrar sesión'),
                  ),
                ],
              ),
      ),
    );
  }
}
