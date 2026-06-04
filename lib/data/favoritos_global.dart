import 'package:flutter/material.dart';
import 'package:enciclopedia_animal/models/animal.dart';
import 'package:enciclopedia_animal/screens/detalle.dart';

List<Animal> favoritos = [];

class Favoritos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favoritos"), centerTitle: true),
      body: favoritos.isEmpty
          ? Center(
              child: Text(
                "No tienes animales favoritos aún.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final animal = favoritos[index];
                return ListTile(
                  leading: Image.asset(
                    animal.imagen,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(animal.nombre),
                  subtitle: Text(animal.especie),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetalleCategoria(categoria: animal.categoria),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
