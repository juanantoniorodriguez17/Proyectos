class Animal {
  final String nombre;
  final String descripcion;
  final String imagen;
  final String especie;
  final String categoria;
  final String habitat;
  final String alimentacion;
  final String curiosidades;
  final int edadMinima;
  final String peso;
  final String tamano;
  final String tiempoVida;
  final String peligroExtincion;
  final String velocidad;
  final String dietaEspecifica;
  final List<String> depredadores;
  final List<String> datosInteresantes;
  final String? sonido;

  Animal({
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.especie,
    required this.categoria,
    required this.habitat,
    required this.alimentacion,
    required this.curiosidades,
    required this.edadMinima,
    required this.peso,
    required this.tamano,
    required this.tiempoVida,
    required this.peligroExtincion,
    required this.velocidad,
    required this.dietaEspecifica,
    required this.depredadores,
    required this.datosInteresantes,
    this.sonido,
  });
}
