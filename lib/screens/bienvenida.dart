import 'package:flutter/material.dart';
import '../models/perfil.dart';
import 'inicio.dart';

class BienvenidaScreen extends StatefulWidget {
  @override
  _BienvenidaScreenState createState() => _BienvenidaScreenState();
}

class _BienvenidaScreenState extends State<BienvenidaScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController edadController = TextEditingController();

  String colorSeleccionado = "azul";
  String errorMessage = "";

  final List<Map<String, dynamic>> colores = [
    {"nombre": "azul", "color": Colors.blue, "icono": Icons.color_lens},
    {"nombre": "verde", "color": Colors.green, "icono": Icons.color_lens},
    {"nombre": "rosa", "color": Colors.pink, "icono": Icons.color_lens},
    {"nombre": "rojo", "color": Colors.red, "icono": Icons.color_lens},
    {"nombre": "naranja", "color": Colors.orange, "icono": Icons.color_lens},
    {"nombre": "morado", "color": Colors.purple, "icono": Icons.color_lens},
    {"nombre": "cian", "color": Colors.cyan, "icono": Icons.color_lens},
    {"nombre": "amarillo", "color": Colors.amber, "icono": Icons.color_lens},
    {"nombre": "gris", "color": Colors.grey, "icono": Icons.color_lens},
    {"nombre": "teal", "color": Colors.teal, "icono": Icons.color_lens},
  ];

  void _guardarPerfil() {
    setState(() {
      errorMessage = "";
    });

    if (nombreController.text.trim().isEmpty) {
      setState(() {
        errorMessage = "Por favor, ingresa tu nombre";
      });
      return;
    }

    int? edad = int.tryParse(edadController.text);
    if (edad == null || edad < 1 || edad > 120) {
      setState(() {
        errorMessage = "Por favor, ingresa una edad válida (1-120 años)";
      });
      return;
    }

    // Guardar perfil
    perfilActual = Perfil(
      nombre: nombreController.text.trim(),
      edad: edad,
      colorTema: colorSeleccionado,
      favoritos: [],
      primerIngreso: false,
    );

    // Ir a la pantalla principal
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => Inicio()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.orange.shade400, Colors.pink.shade400],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icono de bienvenida
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(Icons.pets, size: 80, color: Colors.orange),
                  ),
                  SizedBox(height: 30),

                  Text(
                    "¡Bienvenido a AnimalLearn!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Configura tu perfil para comenzar",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),

                  // Formulario de configuración
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          // Campo de nombre
                          TextField(
                            controller: nombreController,
                            decoration: InputDecoration(
                              labelText: "Tu nombre",
                              hintText: "Ejemplo: Juanito",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Campo de edad
                          TextField(
                            controller: edadController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Tu edad",
                              hintText: "Ejemplo: 8",
                              prefixIcon: Icon(Icons.cake),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Selector de color de tema
                          Text(
                            "Elige tu color favorito",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15),

                          GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                            itemCount: colores.length,
                            itemBuilder: (context, index) {
                              final colorItem = colores[index];
                              bool isSelected =
                                  colorSeleccionado == colorItem["nombre"];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    colorSeleccionado = colorItem["nombre"];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: colorItem["color"],
                                    shape: BoxShape.circle,
                                    border: isSelected
                                        ? Border.all(
                                            color: Colors.white,
                                            width: 3,
                                          )
                                        : null,
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Center(
                                    child: isSelected
                                        ? Icon(Icons.check, color: Colors.white)
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),

                          // Mensaje de error
                          if (errorMessage.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                errorMessage,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),

                          SizedBox(height: 30),

                          // Botón de comenzar
                          ElevatedButton(
                            onPressed: _guardarPerfil,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Comenzar",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
