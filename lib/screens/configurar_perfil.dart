import 'package:flutter/material.dart';
import '../models/perfil.dart';

class ConfigurarPerfil extends StatefulWidget {
  @override
  _ConfigurarPerfilState createState() => _ConfigurarPerfilState();
}

class _ConfigurarPerfilState extends State<ConfigurarPerfil> {
  late TextEditingController nombreController;
  late TextEditingController edadController;
  late String colorSeleccionado;
  String errorMessage = "";

  final List<Map<String, dynamic>> colores = [
    {"nombre": "azul", "color": Colors.blue},
    {"nombre": "verde", "color": Colors.green},
    {"nombre": "rosa", "color": Colors.pink},
    {"nombre": "rojo", "color": Colors.red},
    {"nombre": "naranja", "color": Colors.orange},
    {"nombre": "morado", "color": Colors.purple},
    {"nombre": "cian", "color": Colors.cyan},
    {"nombre": "amarillo", "color": Colors.amber},
    {"nombre": "gris", "color": Colors.grey},
    {"nombre": "teal", "color": Colors.teal},
    {"nombre": "indigo", "color": Colors.indigo},
    {"nombre": "lime", "color": Colors.lime},
  ];

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: perfilActual.nombre);
    edadController = TextEditingController(text: perfilActual.edad.toString());
    colorSeleccionado = perfilActual.colorTema;
  }

  void _guardarPerfil() {
    setState(() => errorMessage = "");

    if (nombreController.text.trim().isEmpty) {
      setState(() => errorMessage = "Ingresa tu nombre");
      return;
    }

    int? edad = int.tryParse(edadController.text);
    if (edad == null || edad < 1 || edad > 120) {
      setState(() => errorMessage = "Edad válida (1-120 años)");
      return;
    }

    setState(() {
      perfilActual.nombre = nombreController.text.trim();
      perfilActual.edad = edad;
      perfilActual.colorTema = colorSeleccionado;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Configurar Perfil")),
      body: SingleChildScrollView(
        // 👈 CAMBIO IMPORTANTE
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                labelText: "Nombre",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: edadController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Edad",
                prefixIcon: Icon(Icons.cake),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Elige tu color favorito",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            GridView.builder(
              shrinkWrap: true, // 👈 IMPORTANTE
              physics: NeverScrollableScrollPhysics(), // 👈 IMPORTANTE
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: colores.length,
              itemBuilder: (context, index) {
                final colorItem = colores[index];
                bool isSelected = colorSeleccionado == colorItem["nombre"];
                return GestureDetector(
                  onTap: () =>
                      setState(() => colorSeleccionado = colorItem["nombre"]),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorItem["color"],
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 3)
                          : null,
                    ),
                    child: isSelected
                        ? Center(child: Icon(Icons.check, color: Colors.white))
                        : null,
                  ),
                );
              },
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(errorMessage, style: TextStyle(color: Colors.red)),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarPerfil,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Guardar cambios",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
