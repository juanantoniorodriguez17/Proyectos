import 'dart:async';
import 'package:flutter/material.dart';
import '../data/datos_animales.dart';
import '../models/perfil.dart';

class JuegoClasificar extends StatefulWidget {
  @override
  _JuegoClasificarState createState() => _JuegoClasificarState();
}

class _JuegoClasificarState extends State<JuegoClasificar> {
  // Configuración
  int cantidadPreguntas = 10;
  int tiempoLimite = 60;
  bool juegoIniciado = false;

  // Estado del juego
  int nivel = 0;
  int puntuacion = 0;
  List<Map<String, dynamic>> niveles = [];
  String? categoriaSeleccionada;

  // Tiempo
  int tiempoRestante = 0;
  bool juegoActivo = true;
  Timer? timer;

  void _iniciarJuego() {
    List<Map<String, dynamic>> disponibles = [];

    for (var animal in animales) {
      if (perfilActual.edad >= animal.edadMinima) {
        disponibles.add({
          "nombre": animal.nombre,
          "imagen": animal.imagen,
          "categoria": animal.categoria,
        });
      }
    }

    disponibles.shuffle();
    niveles = disponibles.take(cantidadPreguntas).toList();

    setState(() {
      nivel = 0;
      puntuacion = 0;
      categoriaSeleccionada = null;
      juegoActivo = true;
      tiempoRestante = tiempoLimite;
      juegoIniciado = true;
    });

    if (tiempoLimite > 0) {
      timer?.cancel();
      timer = Timer.periodic(Duration(seconds: 1), (t) {
        if (mounted &&
            juegoActivo &&
            tiempoRestante > 0 &&
            nivel < niveles.length) {
          setState(() => tiempoRestante--);
          if (tiempoRestante == 0) {
            t.cancel();
            _mostrarGameOver();
          }
        }
      });
    }
  }

  void _responder(String categoria) {
    if (categoriaSeleccionada != null || !juegoActivo) return;

    bool esCorrecta = niveles[nivel]["categoria"] == categoria;
    setState(() {
      categoriaSeleccionada = categoria;
      if (esCorrecta) puntuacion++;
    });

    Future.delayed(Duration(seconds: 1), () {
      if (nivel + 1 < niveles.length) {
        setState(() {
          nivel++;
          categoriaSeleccionada = null;
        });
      } else {
        juegoActivo = false;
        timer?.cancel();
        _mostrarResultado();
      }
    });
  }

  void _mostrarGameOver() {
    juegoActivo = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.timer_off, color: Colors.red),
            SizedBox(width: 10),
            Text("¡Tiempo agotado!"),
          ],
        ),
        content: Text(
          "Clasificaste $puntuacion de ${niveles.length} animales.",
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() => juegoIniciado = false);
              Navigator.pop(context);
            },
            child: Text("Volver a jugar"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Salir"),
          ),
        ],
      ),
    );
  }

  void _mostrarResultado() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emoji_events, color: Colors.amber),
            SizedBox(width: 10),
            Text("¡Juego completado!"),
          ],
        ),
        content: Text(
          "Clasificaste $puntuacion de ${niveles.length} animales.\n"
          "${tiempoLimite > 0 ? "Tiempo restante: ${tiempoRestante}s" : ""}",
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() => juegoIniciado = false);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text("Jugar de nuevo"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Salir"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!juegoIniciado) {
      return Scaffold(
        appBar: AppBar(
          title: Text("📁 Clasifica Animales"),
          backgroundColor: Colors.orange,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          // 👈 CAMBIO IMPORTANTE
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.category, size: 80, color: Colors.orange),
              SizedBox(height: 30),
              Text(
                "Configura tu juego",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      "📊 Cantidad de preguntas",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCantidadBoton(5),
                        SizedBox(width: 15),
                        _buildCantidadBoton(10),
                        SizedBox(width: 15),
                        _buildCantidadBoton(15),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      "⏱️ Tiempo límite",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTiempoBoton(30, "30s"),
                        SizedBox(width: 15),
                        _buildTiempoBoton(60, "1 min"),
                        SizedBox(width: 15),
                        _buildTiempoBoton(120, "2 min"),
                        SizedBox(width: 15),
                        _buildTiempoBoton(0, "∞"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: _iniciarJuego,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "🎮 ¡Comenzar!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (niveles.isEmpty || nivel >= niveles.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Clasifica Animales"),
          backgroundColor: Colors.orange,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    Map<String, dynamic> nivelActual = niveles[nivel];

    return WillPopScope(
      onWillPop: () async {
        timer?.cancel();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Clasifica Animales"),
          backgroundColor: Colors.orange,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              timer?.cancel();
              setState(() => juegoIniciado = false);
            },
          ),
          actions: [
            if (tiempoLimite > 0)
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: tiempoRestante < 10 ? Colors.red : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      tiempoRestante < 10 ? Icons.timer : Icons.timer_outlined,
                      color: tiempoRestante < 10 ? Colors.white : Colors.black,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${tiempoRestante}s",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 20),
                  SizedBox(width: 4),
                  Text(
                    "$puntuacion",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "${nivel + 1}/${niveles.length}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Barra de progreso
              LinearProgressIndicator(
                value: (nivel + 1) / niveles.length,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(Colors.orange),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              SizedBox(height: 20),

              // Pregunta
              Text(
                "¿A qué categoría pertenece?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16),

              // Opciones en Grid de 3 columnas (ARRIBA)
              Expanded(
                flex: 3,
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.5,
                  children: [
                    _buildOpcionBoton("Ave", Icons.flutter_dash, nivelActual),
                    _buildOpcionBoton("Mamífero", Icons.pets, nivelActual),
                    _buildOpcionBoton("Reptil", Icons.terrain, nivelActual),
                    _buildOpcionBoton("Anfibio", Icons.water, nivelActual),
                    _buildOpcionBoton("Insecto", Icons.bug_report, nivelActual),
                    _buildOpcionBoton("Arácnido", Icons.spa, nivelActual),
                    _buildOpcionBoton("Marino", Icons.waves, nivelActual),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Imagen del animal (ABAJO, más grande)
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      nivelActual["imagen"],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: 60,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text(
                              nivelActual["nombre"],
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Feedback de respuesta
              if (categoriaSeleccionada != null)
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: nivelActual["categoria"] == categoriaSeleccionada
                        ? Colors.green[50]
                        : Colors.red[50],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: nivelActual["categoria"] == categoriaSeleccionada
                          ? Colors.green
                          : Colors.red,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        nivelActual["categoria"] == categoriaSeleccionada
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: nivelActual["categoria"] == categoriaSeleccionada
                            ? Colors.green
                            : Colors.red,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          nivelActual["categoria"] == categoriaSeleccionada
                              ? "✅ ¡Correcto! ${nivelActual["nombre"]} es un ${nivelActual["categoria"]}."
                              : "❌ ¡Incorrecto! ${nivelActual["nombre"]} es un ${nivelActual["categoria"]}, no un $categoriaSeleccionada.",
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOpcionBoton(
    String categoria,
    IconData icono,
    Map<String, dynamic> nivelActual,
  ) {
    Color colorBoton = Colors.blue;
    Color textColor = Colors.white;

    if (categoriaSeleccionada != null) {
      if (nivelActual["categoria"] == categoria) {
        colorBoton = Colors.green;
      } else if (categoriaSeleccionada == categoria) {
        colorBoton = Colors.red;
      }
    }

    return ElevatedButton.icon(
      onPressed: categoriaSeleccionada == null && juegoActivo
          ? () => _responder(categoria)
          : null,
      icon: Icon(icono, size: 18),
      label: Text(
        categoria,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: colorBoton,
        foregroundColor: textColor,
        padding: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildCantidadBoton(int cantidad) {
    return FilterChip(
      selected: cantidadPreguntas == cantidad,
      label: Text("$cantidad"),
      onSelected: (_) => setState(() => cantidadPreguntas = cantidad),
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.orange,
      checkmarkColor: Colors.white,
    );
  }

  Widget _buildTiempoBoton(int tiempo, String texto) {
    return FilterChip(
      selected: tiempoLimite == tiempo,
      label: Text(texto),
      onSelected: (_) => setState(() => tiempoLimite = tiempo),
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.orange,
      checkmarkColor: Colors.white,
    );
  }
}
