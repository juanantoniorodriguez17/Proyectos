import '../models/juego.dart';

List<Juego> juegos = [
  Juego(
    nombre: "Memoria de Animales",
    descripcion: "Encuentra las parejas de animales",
    icono: "🎴",
    edadMinima: 3,
    tipo: "memoria",
  ),
  Juego(
    nombre: "¿Preguntas?",
    descripcion: "Responde correctamente la preguntas",
    icono: "🍎",
    edadMinima: 5,
    tipo: "preguntas",
  ),
  Juego(
    nombre: "Clasifica Animales",
    descripcion: "Ordena los animales por categoría",
    icono: "📁",
    edadMinima: 6,
    tipo: "clasificar",
  ),
];
