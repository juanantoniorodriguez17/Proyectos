import 'dart:async';
import 'package:flutter/material.dart';
import '../data/datos_animales.dart';
import '../models/perfil.dart';

class JuegoMemoria extends StatefulWidget {
  @override
  _JuegoMemoriaState createState() => _JuegoMemoriaState();
}

class _JuegoMemoriaState extends State<JuegoMemoria> {
  // Configuración
  int cantidadPares = 6;
  int tiempoLimite = 60;
  bool juegoIniciado = false;

  // Estado del juego
  List<Map<String, String>> animalesParaJuego = [];
  List<Map<String, String>> tablero = [];
  List<int> seleccionados = [];
  List<bool> cartasBloqueadas = [];
  int paresEncontrados = 0;
  int movimientos = 0;
  bool juegoCompletado = false;
  bool esperando = false;

  // Tiempo
  int tiempoRestante = 0;
  bool juegoActivo = true;
  Timer? timer;

  void _iniciarJuego() {
    List<Map<String, String>> disponibles = [];

    for (var animal in animales) {
      if (perfilActual.edad >= animal.edadMinima) {
        disponibles.add({"nombre": animal.nombre, "imagen": animal.imagen});
      }
    }

    disponibles.shuffle();
    animalesParaJuego = disponibles.take(cantidadPares).toList();

    List<Map<String, String>> duplicado = [
      ...animalesParaJuego,
      ...animalesParaJuego,
    ];
    duplicado.shuffle();
    tablero = duplicado;
    seleccionados = [];
    cartasBloqueadas = List.filled(tablero.length, false);
    paresEncontrados = 0;
    movimientos = 0;
    juegoCompletado = false;
    esperando = false;
    juegoActivo = true;
    tiempoRestante = tiempoLimite;

    setState(() {
      juegoIniciado = true;
    });

    if (tiempoLimite > 0) {
      timer?.cancel();
      timer = Timer.periodic(Duration(seconds: 1), (t) {
        if (mounted && juegoActivo && tiempoRestante > 0 && !juegoCompletado) {
          setState(() {
            tiempoRestante--;
          });
          if (tiempoRestante == 0) {
            t.cancel();
            _mostrarGameOver();
          }
        }
      });
    }
  }

  void _seleccionarCarta(int index) {
    if (juegoCompletado) return;
    if (!juegoActivo) return;
    if (esperando) return;
    if (cartasBloqueadas[index]) return;
    if (seleccionados.contains(index)) return;
    if (seleccionados.length == 2) return;

    setState(() {
      seleccionados.add(index);
      movimientos++;
    });

    if (seleccionados.length == 2) {
      _verificarPar();
    }
  }

  void _verificarPar() async {
    esperando = true;

    int idx1 = seleccionados[0];
    int idx2 = seleccionados[1];

    await Future.delayed(Duration(milliseconds: 600));

    if (tablero[idx1]["nombre"] == tablero[idx2]["nombre"]) {
      setState(() {
        cartasBloqueadas[idx1] = true;
        cartasBloqueadas[idx2] = true;
        paresEncontrados++;
        seleccionados.clear();
        esperando = false;
      });

      if (paresEncontrados == cantidadPares) {
        juegoCompletado = true;
        juegoActivo = false;
        timer?.cancel();
        _mostrarVictoria();
      }
    } else {
      setState(() {
        seleccionados.clear();
        esperando = false;
      });
    }
  }

  void _mostrarGameOver() {
    juegoActivo = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.timer_off, color: Colors.red, size: 30),
            SizedBox(width: 10),
            Text("¡Tiempo agotado!"),
          ],
        ),
        content: Text("Completaste $paresEncontrados de $cantidadPares pares."),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                juegoIniciado = false;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
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

  void _mostrarVictoria() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emoji_events, color: Colors.amber, size: 30),
            SizedBox(width: 10),
            Text("¡Ganaste!"),
          ],
        ),
        content: Text(
          "Completaste $cantidadPares pares en $movimientos movimientos.\n"
          "${tiempoLimite > 0 ? "Tiempo restante: ${tiempoRestante}s" : "¡Sin tiempo!"}",
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _iniciarJuego();
              Navigator.pop(context);
              setState(() {});
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text("Jugar de nuevo"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                juegoIniciado = false;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: Text("Configurar"),
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
    // Solo la parte de configuración (al inicio del build)
    if (!juegoIniciado) {
      return Scaffold(
        appBar: AppBar(
          title: Text("🎴 Memoria de Animales"),
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
              Icon(Icons.memory, size: 80, color: Colors.orange),
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
                      "🎴 Cantidad de pares",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildParBoton(4),
                        SizedBox(width: 15),
                        _buildParBoton(6),
                        SizedBox(width: 15),
                        _buildParBoton(8),
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

    return WillPopScope(
      onWillPop: () async {
        timer?.cancel();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Memoria de Animales"),
          backgroundColor: Colors.orange,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              timer?.cancel();
              setState(() {
                juegoIniciado = false;
              });
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
              child: Text(
                "🎴 $paresEncontrados/$cantidadPares",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "🖱️ $movimientos",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            if (tiempoLimite > 0)
              LinearProgressIndicator(
                value: tiempoRestante / tiempoLimite,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(
                  tiempoRestante < 10 ? Colors.red : Colors.orange,
                ),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: tablero.length,
                  itemBuilder: (context, index) {
                    bool cartaVisible =
                        seleccionados.contains(index) ||
                        cartasBloqueadas[index];
                    return GestureDetector(
                      onTap: () => _seleccionarCarta(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cartaVisible ? Colors.white : Colors.blue[100],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: cartaVisible
                                ? Colors.orange
                                : Colors.blue[200]!,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: cartaVisible
                              ? Image.asset(
                                  tablero[index]["imagen"]!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )
                              : Text("?", style: TextStyle(fontSize: 32)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParBoton(int pares) {
    return FilterChip(
      selected: cantidadPares == pares,
      label: Text("$pares pares"),
      onSelected: (_) => setState(() => cantidadPares = pares),
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
