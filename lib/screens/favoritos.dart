import 'package:flutter/material.dart';
import '../data/datos_animales.dart';
import '../models/animal.dart';
import '../models/perfil.dart';

class FavoritosScreen extends StatefulWidget {
  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  @override
  Widget build(BuildContext context) {
    // Filtrar animales que están en favoritos
    List<Animal> animalesFavoritos = animales
        .where((animal) => perfilActual.favoritos.contains(animal.nombre))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("❤️ Mis Favoritos"),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: animalesFavoritos.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    "No tienes animales favoritos aún",
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Ve a cualquier animal y presiona el ❤️ para agregarlo",
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: animalesFavoritos.length,
              itemBuilder: (context, index) {
                Animal animal = animalesFavoritos[index];
                return _buildFavoritoCard(context, animal);
              },
            ),
    );
  }

  Widget _buildFavoritoCard(BuildContext context, Animal animal) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
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
        subtitle: Text(animal.categoria),
        trailing: IconButton(
          icon: Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            _eliminarDeFavoritos(context, animal);
          },
        ),
        onTap: () {
          _mostrarDetalle(context, animal);
        },
      ),
    );
  }

  void _eliminarDeFavoritos(BuildContext context, Animal animal) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Eliminar de favoritos"),
        content: Text("¿Quieres eliminar a ${animal.nombre} de tus favoritos?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                perfilActual.favoritos.remove(animal.nombre);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${animal.nombre} eliminado de favoritos"),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Eliminar"),
          ),
        ],
      ),
    );
  }

  void _mostrarDetalle(BuildContext context, Animal animal) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.pets, color: Colors.orange),
            SizedBox(width: 10),
            Text(animal.nombre),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  animal.imagen,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image_not_supported, size: 150),
                ),
              ),
              SizedBox(height: 15),
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
              SizedBox(height: 10),
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
                    Text(
                      "En tus favoritos ❤️",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String titulo, String valor) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
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
            ),
          ),
        ],
      ),
    );
  }
}
