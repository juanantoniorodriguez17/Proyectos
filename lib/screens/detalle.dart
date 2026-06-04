import 'package:flutter/material.dart';
import '../data/datos_animales.dart';
import '../models/animal.dart';
import '../models/perfil.dart';
import '../utils/sound_player.dart'; // 👈 IMPORTAR SONIDO

class DetalleCategoria extends StatefulWidget {
  final String categoria;
  DetalleCategoria({required this.categoria});

  @override
  _DetalleCategoriaState createState() => _DetalleCategoriaState();
}

class _DetalleCategoriaState extends State<DetalleCategoria> {
  TextEditingController buscarController = TextEditingController();

  List<Animal> getAnimalesFiltrados() {
    return animales
        .where(
          (a) =>
              a.categoria == widget.categoria &&
              perfilActual.edad >= a.edadMinima &&
              a.nombre.toLowerCase().contains(
                buscarController.text.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Animal> animalesFiltrados = getAnimalesFiltrados();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoria),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: buscarController,
              decoration: InputDecoration(
                hintText: "Buscar animal",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: animalesFiltrados.length,
              itemBuilder: (context, index) {
                Animal animal = animalesFiltrados[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        animal.imagen,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.pets, size: 40, color: Colors.grey),
                      ),
                    ),
                    title: Text(
                      animal.nombre,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Peso: ${animal.peso} | Tamaño: ${animal.tamano}",
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        perfilActual.favoritos.contains(animal.nombre)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: perfilActual.favoritos.contains(animal.nombre)
                            ? Colors.red
                            : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          if (perfilActual.favoritos.contains(animal.nombre)) {
                            perfilActual.favoritos.remove(animal.nombre);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${animal.nombre} eliminado de favoritos",
                                ),
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          } else {
                            perfilActual.favoritos.add(animal.nombre);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "${animal.nombre} agregado a favoritos ❤️",
                                ),
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.pink,
                              ),
                            );
                          }
                        });
                      },
                    ),
                    onTap: () {
                      _mostrarDialogo(context, animal);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogo(BuildContext context, Animal animal) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.pets, color: Colors.orange),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                animal.nombre,
                style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 👇 IMAGEN + BOTÓN DE SONIDO
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        animal.imagen,
                        height: 150,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image_not_supported, size: 100),
                      ),
                      // 👇 BOTÓN DE SONIDO (solo si tiene sonido)
                      if (animal.sonido != null && animal.sonido!.isNotEmpty)
                        SizedBox(height: 10),
                      if (animal.sonido != null && animal.sonido!.isNotEmpty)
                        ElevatedButton.icon(
                          onPressed: () => SoundPlayer.play(animal.sonido),
                          icon: Icon(Icons.volume_up),
                          label: Text("Escuchar su sonido"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 15),

                // Información básica
                _buildInfoTile(
                  Icons.description,
                  "Descripción",
                  animal.descripcion,
                ),
                _buildInfoTile(Icons.biotech, "Especie", animal.especie),
                _buildInfoTile(Icons.location_on, "Hábitat", animal.habitat),
                _buildInfoTile(
                  Icons.restaurant,
                  "Alimentación",
                  animal.alimentacion,
                ),

                Divider(),

                // Características físicas
                _buildInfoTile(Icons.monitor_weight, "Peso", animal.peso),
                _buildInfoTile(Icons.straighten, "Tamaño", animal.tamano),
                _buildInfoTile(
                  Icons.timer,
                  "Tiempo de vida",
                  animal.tiempoVida,
                ),
                _buildInfoTile(Icons.speed, "Velocidad", animal.velocidad),

                Divider(),

                // Dieta y depredadores
                _buildInfoTile(
                  Icons.dangerous,
                  "Peligro de extinción",
                  animal.peligroExtincion,
                ),
                _buildInfoTile(
                  Icons.lunch_dining,
                  "Dieta específica",
                  animal.dietaEspecifica,
                ),

                // Depredadores (con Wrap)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.pets, size: 18, color: Colors.red[400]),
                      SizedBox(width: 8),
                      Expanded(
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 3,
                          children: [
                            Text(
                              "Depredadores: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            ...animal.depredadores.map(
                              (dep) =>
                                  Text(dep, style: TextStyle(fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(),

                // Curiosidad
                _buildInfoTile(
                  Icons.emoji_objects,
                  "Curiosidad",
                  animal.curiosidades,
                ),

                // Datos interesantes
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.star, size: 18, color: Colors.amber),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Datos interesantes:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 5),
                            ...animal.datosInteresantes.map(
                              (dato) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("• ", style: TextStyle(fontSize: 13)),
                                    Expanded(
                                      child: Text(
                                        dato,
                                        style: TextStyle(fontSize: 12),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                // Edad recomendada
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber, color: Colors.orange[800]),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "🔞 Edad recomendada: ${animal.edadMinima}+ años",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[900],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (perfilActual.favoritos.contains(animal.nombre))
                  SizedBox(height: 10),
                if (perfilActual.favoritos.contains(animal.nombre))
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.favorite, color: Colors.red),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "❤️ Este animal está en tus favoritos",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              SoundPlayer.stop(); // 👈 Detener sonido al cerrar
              Navigator.pop(context);
            },
            child: Text("Cerrar", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    ).then((_) {
      SoundPlayer.stop(); // 👈 Detener sonido si se cierra de otra forma
    });
  }

  Widget _buildInfoTile(IconData icon, String titulo, String valor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.blue[600]),
          SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 13, color: Colors.black87),
                children: [
                  TextSpan(
                    text: "$titulo: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: valor),
                ],
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
