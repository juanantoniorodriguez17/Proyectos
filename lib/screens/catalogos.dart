import 'package:flutter/material.dart';
import '../data/datos_animales.dart';
import '../models/perfil.dart';
import 'detalle.dart';

class Catalogos extends StatefulWidget {
  @override
  _CatalogosState createState() => _CatalogosState();
}

class _CatalogosState extends State<Catalogos> {
  TextEditingController buscarController = TextEditingController();
  List<String> categorias = [];

  @override
  void initState() {
    super.initState();
    categorias = animales
        .where((a) => perfilActual.edad >= a.edadMinima)
        .map((e) => e.categoria)
        .toSet()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categoriasFiltradas = categorias
        .where(
          (c) => c.toLowerCase().contains(buscarController.text.toLowerCase()),
        )
        .toList();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            controller: buscarController,
            decoration: InputDecoration(
              hintText: "Buscar categoría",
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
            itemCount: categoriasFiltradas.length,
            itemBuilder: (context, index) {
              String cat = categoriasFiltradas[index];
              return ListTile(
                title: Text(cat),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleCategoria(categoria: cat),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
