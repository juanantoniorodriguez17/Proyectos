import 'dart:async';
import 'package:flutter/material.dart';
import 'quiz_config.dart';

class JuegoPreguntas extends StatefulWidget {
  @override
  _JuegoPreguntasState createState() => _JuegoPreguntasState();
}

class _JuegoPreguntasState extends State<JuegoPreguntas> {
  // Configuración
  int cantidadPreguntas = 10;
  String dificultad = "medio";
  bool juegoIniciado = false;

  // Estado del juego
  List<Pregunta> preguntas = [];
  int preguntaActual = 0;
  int puntuacion = 0;
  bool respuestaSeleccionada = false;
  int respuestaCorrecta = 0;

  void _iniciarJuego() {
    // Filtrar preguntas por dificultad
    List<Pregunta> filtradas = bancoPreguntas
        .where((p) => p.dificultad == dificultad)
        .toList();

    if (filtradas.length < cantidadPreguntas) {
      filtradas = bancoPreguntas.toList();
    }

    filtradas.shuffle();
    preguntas = filtradas.take(cantidadPreguntas).toList();

    setState(() {
      preguntaActual = 0;
      puntuacion = 0;
      respuestaSeleccionada = false;
      juegoIniciado = true;
    });
  }

  void _responder(int index) {
    if (respuestaSeleccionada) return;

    setState(() {
      respuestaSeleccionada = true;
      respuestaCorrecta = index;
      if (preguntas[preguntaActual].respuestaCorrecta == index) {
        puntuacion++;
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      if (preguntaActual + 1 < preguntas.length) {
        setState(() {
          preguntaActual++;
          respuestaSeleccionada = false;
        });
      } else {
        _mostrarResultado();
      }
    });
  }

  void _mostrarResultado() {
    String mensaje = "";
    if (puntuacion == preguntas.length) {
      mensaje = "🎉 ¡Perfecto! Eres un experto en animales.";
    } else if (puntuacion >= preguntas.length - 2) {
      mensaje = "👏 ¡Muy bien! Casi perfecto.";
    } else if (puntuacion >= preguntas.length / 2) {
      mensaje = "📚 ¡Bien! Sigue practicando.";
    } else {
      mensaje = "📖 Sigue aprendiendo sobre animales.";
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emoji_events, color: Colors.amber),
            SizedBox(width: 10),
            Text("¡Quiz completado!"),
          ],
        ),
        content: Text(
          "Dificultad: ${_getDificultadTexto()}\n"
          "Preguntas: $puntuacion de ${preguntas.length}\n\n"
          "$mensaje",
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                juegoIniciado = false;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text("Nuevo Quiz"),
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

  String _getDificultadTexto() {
    switch (dificultad) {
      case "facil":
        return "Fácil 🌟";
      case "medio":
        return "Medio ⭐⭐";
      case "dificil":
        return "Difícil 🔥🔥🔥";
      default:
        return "Medio";
    }
  }

  Color _getDificultadColor() {
    switch (dificultad) {
      case "facil":
        return Colors.green;
      case "medio":
        return Colors.orange;
      case "dificil":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pantalla de configuración
    if (!juegoIniciado) {
      return Scaffold(
        appBar: AppBar(
          title: Text("🐘 Quiz de Animales"),
          backgroundColor: Colors.orange,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.quiz, size: 80, color: Colors.orange),
              SizedBox(height: 30),
              Text(
                "Configura tu Quiz",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),

              // Selector de cantidad de preguntas
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
                        SizedBox(width: 15),
                        _buildCantidadBoton(20),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Selector de dificultad
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      "🎯 Nivel de dificultad",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildDificultadBoton("facil", "Fácil", Colors.green),
                        SizedBox(width: 15),
                        _buildDificultadBoton("medio", "Medio", Colors.orange),
                        SizedBox(width: 15),
                        _buildDificultadBoton("dificil", "Difícil", Colors.red),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),

              // Botón iniciar
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

    // Pantalla del juego
    Pregunta pregunta = preguntas[preguntaActual];

    return Scaffold(
      appBar: AppBar(
        title: Text("🐘 Quiz de Animales"),
        backgroundColor: Colors.orange,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              juegoIniciado = false;
            });
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.yellow, size: 20),
                SizedBox(width: 5),
                Text(
                  "$puntuacion",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 15),
                Icon(Icons.help, color: Colors.white, size: 20),
                SizedBox(width: 5),
                Text(
                  "${preguntaActual + 1}/${preguntas.length}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(5),
          child: LinearProgressIndicator(
            value: (preguntaActual + 1) / preguntas.length,
            backgroundColor: Colors.white30,
            valueColor: AlwaysStoppedAnimation(Colors.yellow),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // 👈 CORRECCIÓN: permite scroll en horizontal
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dificultad
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getDificultadColor(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getDificultadTexto(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Pregunta
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange[200]!, width: 2),
              ),
              child: Text(
                pregunta.texto,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),

            // Opciones
            ...List.generate(pregunta.opciones.length, (index) {
              bool esCorrecta = pregunta.respuestaCorrecta == index;
              bool esSeleccionada =
                  respuestaSeleccionada && respuestaCorrecta == index;
              Color colorBoton = Colors.blue;

              if (respuestaSeleccionada) {
                if (esCorrecta) {
                  colorBoton = Colors.green;
                } else if (esSeleccionada && !esCorrecta) {
                  colorBoton = Colors.red;
                }
              }

              return Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _responder(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorBoton,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    pregunta.opciones[index],
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              );
            }),

            // Explicación
            if (respuestaSeleccionada)
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue[200]!, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(
                      pregunta.respuestaCorrecta == respuestaCorrecta
                          ? Icons.check_circle
                          : Icons.info,
                      color: pregunta.respuestaCorrecta == respuestaCorrecta
                          ? Colors.green
                          : Colors.blue,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        pregunta.explicacion,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 30), // Espacio extra al final
          ],
        ),
      ),
    );
  }

  Widget _buildCantidadBoton(int cantidad) {
    return FilterChip(
      selected: cantidadPreguntas == cantidad,
      label: Text("$cantidad"),
      onSelected: (_) {
        setState(() {
          cantidadPreguntas = cantidad;
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.orange,
      checkmarkColor: Colors.white,
    );
  }

  Widget _buildDificultadBoton(String valor, String texto, Color color) {
    return FilterChip(
      selected: dificultad == valor,
      label: Text(texto),
      onSelected: (_) {
        setState(() {
          dificultad = valor;
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: color,
      checkmarkColor: Colors.white,
    );
  }
}
