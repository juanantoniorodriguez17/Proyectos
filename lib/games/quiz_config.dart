class Pregunta {
  final String texto;
  final List<String> opciones;
  final int respuestaCorrecta; // índice de la opción correcta
  final String explicacion;
  final String dificultad; // "facil", "medio", "dificil"

  Pregunta({
    required this.texto,
    required this.opciones,
    required this.respuestaCorrecta,
    required this.explicacion,
    required this.dificultad,
  });
}

// Banco de preguntas clasificadas por dificultad
// Banco de preguntas clasificadas por dificultad
List<Pregunta> bancoPreguntas = [
  // ==================== PREGUNTAS FÁCILES ====================

  // Mamíferos fáciles
  Pregunta(
    texto: "¿Qué animal es conocido como el 'Rey de la Selva'?",
    opciones: ["Tigre", "León", "Elefante", "Jaguar"],
    respuestaCorrecta: 1,
    explicacion:
        "El león es conocido como el 'Rey de la Selva' por su imponente melena.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal tiene rayas blancas y negras?",
    opciones: ["Tigre", "Cebra", "Panda", "Mapache"],
    respuestaCorrecta: 1,
    explicacion:
        "La cebra es famosa por sus rayas blancas y negras únicas como huella digital.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Cuál es el animal terrestre más rápido?",
    opciones: ["León", "Guepardo (Chita)", "Cebra", "Avestruz"],
    respuestaCorrecta: 1,
    explicacion: "El guepardo puede alcanzar 120 km/h en cortas distancias.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal es conocido como el mejor amigo del hombre?",
    opciones: ["Gato", "Caballo", "Perro", "Loro"],
    respuestaCorrecta: 2,
    explicacion:
        "El perro es el mejor amigo del hombre por su lealtad desde hace miles de años.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal tiene una joroba para almacenar grasa?",
    opciones: ["Elefante", "Rinoceronte", "Camello", "Bisonte"],
    respuestaCorrecta: 2,
    explicacion:
        "El camello almacena grasa en su joroba, no agua, para sobrevivir en el desierto.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal vive en el Polo Sur?",
    opciones: ["Oso Polar", "Pingüino", "Morsa", "Foca"],
    respuestaCorrecta: 1,
    explicacion:
        "Los pingüinos viven en la Antártida (Polo Sur). Los osos polares viven en el Polo Norte.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal tiene el cuello más largo?",
    opciones: ["Elefante", "Jirafa", "Avestruz", "Alpaca"],
    respuestaCorrecta: 1,
    explicacion:
        "La jirafa tiene el cuello más largo, hasta 2.4 metros, para alcanzar hojas altas.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal puede cambiar de color?",
    opciones: ["Iguana", "Camaleón", "Serpiente", "Rana"],
    respuestaCorrecta: 1,
    explicacion:
        "El camaleón cambia de color para camuflarse, comunicarse y regular temperatura.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal tiene una trompa larga?",
    opciones: ["Elefante", "Tapir", "Morsa", "Jabalí"],
    respuestaCorrecta: 0,
    explicacion:
        "El elefante usa su trompa para respirar, beber, agarrar objetos y comunicarse.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal dice 'guau guau'?",
    opciones: ["Gato", "Perro", "Vaca", "Pato"],
    respuestaCorrecta: 1,
    explicacion:
        "El perro ladra diciendo 'guau guau'. Los gatos maúllan, las vacas mugen y los patos graznan.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal tiene una cola muy grande y peluda?",
    opciones: ["Conejo", "Ardilla", "Zorro", "Todos los anteriores"],
    respuestaCorrecta: 3,
    explicacion:
        "El conejo, la ardilla y el zorro tienen colas grandes y peludas.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal nada y tiene aletas?",
    opciones: ["Pez", "Ballena", "Delfín", "Todos los anteriores"],
    respuestaCorrecta: 3,
    explicacion:
        "Los peces, ballenas y delfines tienen aletas y viven en el agua.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal vuela y tiene plumas?",
    opciones: ["Murciélago", "Ave", "Mariposa", "Todos los anteriores"],
    respuestaCorrecta: 1,
    explicacion:
        "Las aves son los únicos animales con plumas. Los murciélagos tienen pelo y las mariposas tienen alas escamosas.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal es conocido por construir represas?",
    opciones: ["Castor", "Topo", "Rata", "Nutria"],
    respuestaCorrecta: 0,
    explicacion:
        "El castor construye represas en los ríos con troncos y barro.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué animal tiene una concha en su espalda?",
    opciones: ["Caracol", "Tortuga", "Erizo", "Todos los anteriores"],
    respuestaCorrecta: 1,
    explicacion:
        "La tortuga tiene un caparazón duro en su espalda. El caracol tiene concha pero no en la espalda.",
    dificultad: "facil",
  ),

  // Aves fáciles
  Pregunta(
    texto: "¿Qué ave no puede volar pero corre muy rápido?",
    opciones: ["Avestruz", "Pingüino", "Kiwi", "Emú"],
    respuestaCorrecta: 0,
    explicacion:
        "El avestruz es el ave más grande y puede correr a 70 km/h, pero no vuela.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué ave es símbolo de la paz?",
    opciones: ["Águila", "Paloma", "Loro", "Búho"],
    respuestaCorrecta: 1,
    explicacion: "La paloma blanca es símbolo universal de la paz.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué ave es conocida por imitar la voz humana?",
    opciones: ["Cuervo", "Loro", "Urraca", "Todos los anteriores"],
    respuestaCorrecta: 3,
    explicacion:
        "Los loros, cuervos y urracas pueden imitar sonidos y palabras humanas.",
    dificultad: "facil",
  ),

  // Insectos fáciles
  Pregunta(
    texto: "¿Qué insecto produce miel?",
    opciones: ["Avispa", "Abeja", "Hormiga", "Mariposa"],
    respuestaCorrecta: 1,
    explicacion: "Las abejas producen miel a partir del néctar de las flores.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué insecto es famoso por su luz en la oscuridad?",
    opciones: ["Luciérnaga", "Mosquito", "Grillo", "Cucaracha"],
    respuestaCorrecta: 0,
    explicacion:
        "La luciérnaga produce luz propia (bioluminiscencia) para atraer pareja.",
    dificultad: "facil",
  ),
  Pregunta(
    texto: "¿Qué insecto vive en colonias organizadas?",
    opciones: ["Hormiga", "Abeja", "Termita", "Todos los anteriores"],
    respuestaCorrecta: 3,
    explicacion:
        "Las hormigas, abejas y termitas viven en colonias muy organizadas con castas.",
    dificultad: "facil",
  ),

  // ==================== PREGUNTAS MEDIAS ====================

  // Mamíferos medios
  Pregunta(
    texto: "¿Cuál es el animal más grande del océano?",
    opciones: ["Tiburón Blanco", "Calamar Gigante", "Ballena Azul", "Orca"],
    respuestaCorrecta: 2,
    explicacion:
        "La ballena azul es el animal más grande del planeta, alcanzando 30 metros.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué animal tiene la picadura más dolorosa del mundo?",
    opciones: [
      "Araña Violinista",
      "Hormiga Bala",
      "Viuda Negra",
      "Escorpión Amarillo",
    ],
    respuestaCorrecta: 1,
    explicacion:
        "La Hormiga Bala tiene la picadura más dolorosa, comparada con un disparo.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué animal puede vivir más de 100 años sin envejecer?",
    opciones: ["Elefante", "Ballena", "Langosta", "Tortuga"],
    respuestaCorrecta: 2,
    explicacion:
        "La langosta tiene inmortalidad biológica, no envejece y puede vivir más de 100 años.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué animal tiene la mordida más fuerte entre los felinos?",
    opciones: ["León", "Tigre", "Jaguar", "Puma"],
    respuestaCorrecta: 2,
    explicacion:
        "El jaguar tiene la mordida más fuerte, capaz de perforar cráneos y caparazones.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué animal puede regenerar sus extremidades?",
    opciones: ["Lagartija", "Ajolote", "Salamandra", "Todos los anteriores"],
    respuestaCorrecta: 3,
    explicacion:
        "El ajolote, salamandras y lagartijas pueden regenerar cola y extremidades.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué animal es el más alto del mundo?",
    opciones: ["Elefante", "Jirafa", "Oso Polar", "Rinoceronte"],
    respuestaCorrecta: 1,
    explicacion:
        "La jirafa es el animal más alto, alcanzando hasta 5.5 metros de altura.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué animal tiene la trompa más larga?",
    opciones: ["Elefante Africano", "Elefante Asiático", "Tapir", "Morsa"],
    respuestaCorrecta: 0,
    explicacion:
        "El elefante africano tiene la trompa más larga, hasta 2.5 metros.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué animal duerme más horas al día?",
    opciones: ["Koala", "Perezoso", "León", "Gato"],
    respuestaCorrecta: 0,
    explicacion:
        "El koala duerme hasta 20-22 horas al día por su dieta baja en calorías.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué animal es conocido como el 'fósil viviente'?",
    opciones: ["Tortuga", "Náutilo", "Cocodrilo", "Tuatara"],
    respuestaCorrecta: 1,
    explicacion:
        "El nautilo ha cambiado muy poco en más de 500 millones de años.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué animal tiene los cuernos más grandes?",
    opciones: ["Alce", "Búfalo", "Bisonte", "Rinoceronte"],
    respuestaCorrecta: 0,
    explicacion:
        "El alce tiene los cuernos más grandes, pueden medir hasta 2 metros de ancho.",
    dificultad: "medio",
  ),

  // Aves medias
  Pregunta(
    texto: "¿Qué ave es considerada la más peligrosa del mundo?",
    opciones: ["Águila Real", "Casuario", "Búho", "Picozapato"],
    respuestaCorrecta: 1,
    explicacion:
        "El casuario tiene garras de 12 cm y puede matar de una patada.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué ave produce el sonido más fuerte?",
    opciones: ["Loro", "Águila", "Campanero Blanco", "Pavo Real"],
    respuestaCorrecta: 2,
    explicacion:
        "El Campanero Blanco alcanza 125 decibeles, como un martillo neumático.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué ave pone los huevos más grandes?",
    opciones: ["Águila", "Avestruz", "Emú", "Pingüino"],
    respuestaCorrecta: 1,
    explicacion: "El avestruz pone los huevos más grandes, pesan hasta 1.5 kg.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué ave no puede volar pero nada muy bien?",
    opciones: ["Avestruz", "Pingüino", "Kiwi", "Emú"],
    respuestaCorrecta: 1,
    explicacion:
        "El pingüino no vuela pero es excelente nadador, usando sus alas como aletas.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué ave tiene la envergadura más grande?",
    opciones: ["Águila Real", "Albatros", "Cóndor", "Pelícano"],
    respuestaCorrecta: 1,
    explicacion:
        "El albatros tiene la envergadura más grande, hasta 3.5 metros.",
    dificultad: "medio",
  ),

  // Reptiles medios
  Pregunta(
    texto: "¿Cuál es la serpiente más larga del mundo?",
    opciones: ["Anaconda", "Cobra Real", "Pitón Reticulada", "Mamba Negra"],
    respuestaCorrecta: 2,
    explicacion: "La Pitón Reticulada puede superar los 10 metros de longitud.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Cuál es la serpiente más pesada del mundo?",
    opciones: [
      "Pitón Reticulada",
      "Anaconda Verde",
      "Cobra Real",
      "Boa Constrictora",
    ],
    respuestaCorrecta: 1,
    explicacion:
        "La Anaconda Verde es la más pesada, pudiendo superar los 250 kg.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué reptil puede cambiar de color?",
    opciones: ["Iguana", "Camaleón", "Gecko", "Lagartija"],
    respuestaCorrecta: 1,
    explicacion:
        "El camaleón puede cambiar de color para camuflarse y comunicarse.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué tortuga puede pesar más de 500 kg?",
    opciones: [
      "Tortuga Marina",
      "Tortuga Galápagos",
      "Tortuga Caimán",
      "Tortuga Laúd",
    ],
    respuestaCorrecta: 1,
    explicacion: "La tortuga gigante de Galápagos puede pesar más de 500 kg.",
    dificultad: "medio",
  ),

  // Insectos medios
  Pregunta(
    texto: "¿Qué insecto puede levantar 50 veces su peso?",
    opciones: ["Hormiga", "Escarabajo", "Abeja", "Todos los anteriores"],
    respuestaCorrecta: 3,
    explicacion:
        "Las hormigas pueden cargar 50 veces su peso, los escarabajos hasta 850 veces.",
    dificultad: "medio",
  ),
  Pregunta(
    texto: "¿Qué insecto forma enjambres de millones de individuos?",
    opciones: ["Abeja", "Langosta", "Hormiga", "Termita"],
    respuestaCorrecta: 1,
    explicacion:
        "Las langostas forman enjambres de miles de millones que devastan cultivos.",
    dificultad: "medio",
  ),

  // ==================== PREGUNTAS DIFÍCILES ====================

  // Mamíferos difíciles
  Pregunta(
    texto: "¿Qué animal tiene la lengua más larga en proporción a su cuerpo?",
    opciones: ["Camaleón", "Oso Hormiguero", "Pájaro Carpintero", "Serpiente"],
    respuestaCorrecta: 0,
    explicacion:
        "La lengua del camaleón puede medir hasta el doble de la longitud de su cuerpo.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué animal es el único mamífero que puede volar realmente?",
    opciones: ["Ardilla Voladora", "Murciélago", "Pez Volador", "Colugo"],
    respuestaCorrecta: 1,
    explicacion:
        "El murciélago es el único mamífero con vuelo verdadero (los demás solo planean).",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué animal tiene sangre azul?",
    opciones: ["Pulpo", "Calamar", "Langosta", "Todos los anteriores"],
    respuestaCorrecta: 3,
    explicacion:
        "Estos animales usan cobre en lugar de hierro en su sangre (hemocianina).",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué animal tiene tres corazones?",
    opciones: ["Pulpo", "Calamar", "Sepia", "Todos los anteriores"],
    respuestaCorrecta: 3,
    explicacion:
        "Los cefalópodos (pulpo, calamar, sepia) tienen tres corazones.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué animal tiene los ojos más grandes del reino animal?",
    opciones: ["Ballena", "Calamar Gigante", "Búho", "Tiburón"],
    respuestaCorrecta: 1,
    explicacion:
        "El calamar gigante tiene ojos de hasta 27 cm de diámetro (como un balón).",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué animal puede sobrevivir una semana sin cabeza?",
    opciones: ["Cucaracha", "Hormiga", "Araña", "Mosca"],
    respuestaCorrecta: 0,
    explicacion:
        "La cucaracha respira por todo el cuerpo, no por la cabeza, por eso sobrevive.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué animal es inmune al veneno de la anémona?",
    opciones: ["Pez Payaso", "Medusa", "Tortuga", "Estrella de Mar"],
    respuestaCorrecta: 0,
    explicacion:
        "El pez payaso tiene una capa de moco que lo protege del veneno de la anémona.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué animal tiene el veneno más potente del mundo?",
    opciones: [
      "Cobra Real",
      "Mamba Negra",
      "Serpiente Marina",
      "Araña Errante",
    ],
    respuestaCorrecta: 2,
    explicacion:
        "La serpiente marina tiene el veneno más potente, pero es tímida y rara vez ataca.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué animal puede detectar sangre a kilómetros de distancia?",
    opciones: ["Tiburón", "Lobo", "Águila", "Perro"],
    respuestaCorrecta: 0,
    explicacion:
        "El tiburón puede detectar una gota de sangre en 100 litros de agua a km de distancia.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué animal tiene la piel más gruesa?",
    opciones: ["Elefante", "Rinoceronte", "Hipopótamo", "Ballena"],
    respuestaCorrecta: 3,
    explicacion: "La ballena tiene la piel más gruesa, hasta 30 cm de espesor.",
    dificultad: "dificil",
  ),

  // Aves difíciles
  Pregunta(
    texto: "¿Qué ave tiene el huevo más grande en proporción a su cuerpo?",
    opciones: ["Avestruz", "Kiwi", "Emú", "Pingüino"],
    respuestaCorrecta: 1,
    explicacion:
        "El kiwi pone el huevo más grande en proporción: 1/4 del tamaño de su cuerpo.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué ave tiene la lengua más larga?",
    opciones: ["Pájaro Carpintero", "Colibrí", "Loro", "Tucán"],
    respuestaCorrecta: 0,
    explicacion:
        "El pájaro carpintero tiene una lengua muy larga que envuelve su cráneo.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué ave es endémica de Nueva Zelanda?",
    opciones: ["Emú", "Kiwi", "Casuario", "Pingüino"],
    respuestaCorrecta: 1,
    explicacion:
        "El kiwi es un ave endémica de Nueva Zelanda y su símbolo nacional.",
    dificultad: "dificil",
  ),

  // Reptiles difíciles
  Pregunta(
    texto: "¿Cuál es la tortuga más longeva del mundo?",
    opciones: [
      "Tortuga Marina",
      "Tortuga Galápagos",
      "Tortuga Caimán",
      "Tortuga Laúd",
    ],
    respuestaCorrecta: 1,
    explicacion: "La tortuga gigante de Galápagos puede vivir más de 150 años.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué serpiente tiene el veneno más potente?",
    opciones: ["Cobra Real", "Taipán", "Serpiente Marina", "Mamba Negra"],
    respuestaCorrecta: 2,
    explicacion: "La serpiente marina tiene el veneno más potente del mundo.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué lagarto puede correr sobre el agua?",
    opciones: ["Iguana", "Basilisco", "Gecko", "Camaleón"],
    respuestaCorrecta: 1,
    explicacion:
        "El basilisco, conocido como 'lagarto Jesucristo', puede correr sobre el agua.",
    dificultad: "dificil",
  ),

  // Insectos difíciles
  Pregunta(
    texto: "¿Qué insecto tiene la picadura más dolorosa?",
    opciones: ["Avispa", "Hormiga Bala", "Escorpión", "Abeja"],
    respuestaCorrecta: 1,
    explicacion:
        "La hormiga bala tiene la picadura más dolorosa, comparada con un disparo.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué insecto puede volar hacia atrás?",
    opciones: ["Libélula", "Mosca", "Abeja", "Mariposa"],
    respuestaCorrecta: 0,
    explicacion:
        "La libélula es la única que puede volar hacia atrás y quedarse quieta en el aire.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué insecto produce luz fría (bioluminiscencia)?",
    opciones: ["Luciérnaga", "Cucaracha", "Grillo", "Mosquito"],
    respuestaCorrecta: 0,
    explicacion:
        "La luciérnaga produce luz fría (100% eficiente, no produce calor).",
    dificultad: "dificil",
  ),

  // Animales marinos difíciles
  Pregunta(
    texto: "¿Qué animal marino tiene tres corazones y sangre azul?",
    opciones: ["Pulpo", "Calamar", "Sepia", "Todos los anteriores"],
    respuestaCorrecta: 3,
    explicacion:
        "Los cefalópodos tienen tres corazones y sangre azul (hemocianina).",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué animal marino puede regenerar sus brazos si los pierde?",
    opciones: ["Estrella de Mar", "Pulpo", "Cangrejo", "Todos los anteriores"],
    respuestaCorrecta: 3,
    explicacion:
        "Las estrellas de mar, pulpos y cangrejos pueden regenerar brazos o patas perdidas.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué animal marino tiene el ojo más grande del mundo?",
    opciones: ["Ballena Azul", "Calamar Gigante", "Tiburón Ballena", "Pulpo"],
    respuestaCorrecta: 1,
    explicacion:
        "El calamar gigante tiene ojos de 27 cm de diámetro (como un balón de fútbol).",
    dificultad: "dificil",
  ),

  // Anfibios difíciles
  Pregunta(
    texto: "¿Qué anfibio puede regenerar su corazón y cerebro?",
    opciones: ["Salamandra", "Ajolote", "Rana", "Tritón"],
    respuestaCorrecta: 1,
    explicacion:
        "El ajolote puede regenerar extremidades, corazón y partes del cerebro.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué rana es la más venenosa del mundo?",
    opciones: [
      "Rana Dardo Dorada",
      "Rana Flecha Azul",
      "Rana Arbórea",
      "Rana Toro",
    ],
    respuestaCorrecta: 0,
    explicacion:
        "La rana dardo dorada tiene veneno suficiente para matar 10 humanos.",
    dificultad: "dificil",
  ),
  Pregunta(
    texto: "¿Qué anfibio tiene branquias externas toda su vida?",
    opciones: ["Ajolote", "Salamandra", "Tritón", "Rana"],
    respuestaCorrecta: 0,
    explicacion:
        "El ajolote nunca completa su metamorfosis y conserva sus branquias externas.",
    dificultad: "dificil",
  ),
];
