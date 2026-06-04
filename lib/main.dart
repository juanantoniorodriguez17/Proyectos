import 'package:flutter/material.dart';
import 'screens/bienvenida.dart';
import 'screens/inicio.dart';
import 'models/perfil.dart';

// Perfil temporal (se reemplazará después)
Perfil perfilActual = Perfil(
  nombre: "",
  edad: 0,
  colorTema: "azul",
  favoritos: [],
  primerIngreso: true,
);

void main() {
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AnimalLearn",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: perfilActual.primerIngreso ? BienvenidaScreen() : Inicio(),
    );
  }
}
