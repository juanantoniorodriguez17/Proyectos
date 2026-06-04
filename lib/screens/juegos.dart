import 'package:flutter/material.dart';
import '../models/perfil.dart';
import '../models/juego.dart';
import '../data/datos_juegos.dart';
import '../games/juego_memoria.dart';
import '../games/juego_preguntas.dart';
import '../games/juego_clasificar.dart';

class JuegosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Filtrar juegos según edad del usuario
    List<Juego> juegosDisponibles = juegos
        .where((juego) => perfilActual.edad >= juego.edadMinima)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("🎮 Minijuegos"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: juegosDisponibles.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 80, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    "¡Cumple ${8 - perfilActual.edad} años más\npara desbloquear juegos!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: juegosDisponibles.length,
                itemBuilder: (context, index) {
                  Juego juego = juegosDisponibles[index];
                  return _buildJuegoCard(context, juego);
                },
              ),
            ),
    );
  }

  Widget _buildJuegoCard(BuildContext context, Juego juego) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () => _abrirJuego(context, juego),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(juego.icono, style: TextStyle(fontSize: 55)),
            SizedBox(height: 12),
            Text(
              juego.nombre,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                juego.descripcion,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "🔞 ${juego.edadMinima}+ años",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _abrirJuego(BuildContext context, Juego juego) {
    switch (juego.tipo) {
      case "memoria":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => JuegoMemoria()),
        );
        break;
      case "preguntas":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => JuegoPreguntas()),
        );
        break;
      case "clasificar":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => JuegoClasificar()),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "🎮 ¡Próximamente! Este juego estará disponible pronto.",
            ),
            backgroundColor: Colors.orange,
          ),
        );
    }
  }
}
