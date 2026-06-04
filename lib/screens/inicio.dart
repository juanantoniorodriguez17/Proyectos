import 'package:flutter/material.dart';
import '../screens/catalogos.dart';
import '../screens/configurar_perfil.dart';
import '../screens/juegos.dart';
import '../screens/favoritos.dart';
import '../models/perfil.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    Color colorTema = _getColorFromName(perfilActual.colorTema);

    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido ${perfilActual.nombre}"),
        backgroundColor: colorTema,
        actions: [
          // Botón de favoritos
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FavoritosScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfigurarPerfil()),
              );
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Botón de juegos
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => JuegosScreen()),
                );
              },
              icon: Icon(Icons.games, size: 28),
              label: Text(
                "🎮 Juegos Educativos",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          // Catálogo de animales
          Expanded(child: Catalogos()),
        ],
      ),
    );
  }

  Color _getColorFromName(String colorName) {
    switch (colorName) {
      case "azul":
        return Colors.blue;
      case "verde":
        return Colors.green;
      case "rosa":
        return Colors.pink;
      case "rojo":
        return Colors.red;
      case "naranja":
        return Colors.orange;
      case "morado":
        return Colors.purple;
      case "cian":
        return Colors.cyan;
      case "amarillo":
        return Colors.amber;
      case "gris":
        return Colors.grey;
      case "teal":
        return Colors.teal;
      case "indigo":
        return Colors.indigo;
      case "lime":
        return Colors.lime;
      default:
        return Colors.blue;
    }
  }
}
