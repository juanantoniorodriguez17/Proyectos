class Perfil {
  String nombre;
  int edad;
  String colorTema;
  List<String> favoritos;
  bool primerIngreso; // 👈 NUEVO: para saber si es primera vez

  Perfil({
    required this.nombre,
    required this.edad,
    required this.colorTema,
    this.favoritos = const [],
    this.primerIngreso = true, // 👈 Por defecto, es primera vez
  });
}

// Perfil global (se inicializará después)
late Perfil perfilActual;
