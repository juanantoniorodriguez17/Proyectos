# ==================================================
# CLASIFICADOR DE SPAM CON NAIVE BAYES
# ==================================
# Este programa entrena un modelo de Machine Learning
# para identificar si un correo electrónico es SPAM o NO SPAM
# ==================================================

# --------------------------------------------------
# IMPORTAR LIBRERÍAS NECESARIAS
# --------------------------------------------------

# CountVectorizer: Convierte texto en números (frecuencia de palabras)
# Por ejemplo: "Hola mundo hola" → {"hola":2, "mundo":1}
from sklearn.feature_extraction.text import CountVectorizer

# MultinomialNB: Algoritmo Naive Bayes para clasificación de texto
# Es ideal para datos que representan frecuencias (como conteo de palabras)
from sklearn.naive_bayes import MultinomialNB


# --------------------------------------------------
# FUNCIÓN 1: ENTRENAMIENTO DEL MODELO
# --------------------------------------------------
# Propósito: Leer correos de entrenamiento, convertirlos a números
#            y entrenar el modelo Naive Bayes
# Retorna: 
#   - modelo: el clasificador ya entrenado
#   - vectorizador: herramienta para convertir texto a números
# --------------------------------------------------

def entrenamiento():

    # --------------------------------------------------
    # PASO 1: CREAR LISTAS VACÍAS PARA ALMACENAR DATOS
    # --------------------------------------------------
    
    # Lista donde se guardarán los textos completos de los correos
    # Ejemplo: ["Hola amigos", "Gana dinero fácil", ...]
    correos = []

    # Lista donde se guardará la clasificación de cada correo
    # 1 = SPAM, 0 = NO SPAM
    # Ejemplo: [0, 1, 0, 1, 0]
    etiquetas = []

    # --------------------------------------------------
    # PASO 2: SOLICITAR CUÁNTOS CORREOS SE USARÁN
    # --------------------------------------------------
    
    print("=" * 50)
    print("FASE DE ENTRENAMIENTO DEL MODELO")
    print("=" * 50)
    print("¿Cuántos correos se usarán para el entrenamiento?")
    cantidad = int(input())  # Convertimos el texto ingresado a número entero

    # --------------------------------------------------
    # PASO 3: LEER CADA ARCHIVO Y SU CLASIFICACIÓN
    # --------------------------------------------------
    
    # Ciclo que se repite tantas veces como correos indique el usuario
    for i in range(cantidad):
        
        print("\n" + "-" * 30)
        print(f"Correo número {i+1} de {cantidad}")
        print("-" * 30)
        
        # Solicitar el nombre del archivo (sin extensión .txt)
        print("Nombre del archivo (sin .txt): ")
        nombre = input()
        
        # --------------------------------------------------
        # LEER EL CONTENIDO DEL ARCHIVO DE TEXTO
        # --------------------------------------------------
        # 'open' abre el archivo en modo lectura ('r')
        # 'encoding="utf-8"' permite leer caracteres especiales (ñ, á, é, etc.)
        # 'with open' es más seguro pero usamos el método tradicional
        archivo = open(nombre + ".txt", "r", encoding="utf-8")
        texto = archivo.read()  # Leer todo el contenido del archivo
        archivo.close()  # Cerrar el archivo para liberar recursos
        
        # Guardar el texto del correo en la lista 'correos'
        correos.append(texto)
        
        # --------------------------------------------------
        # SOLICITAR LA CLASIFICACIÓN (SPAM O NO SPAM)
        # --------------------------------------------------
        print("¿El correo es spam?")
        print("  1 = SI (es spam)")
        print("  0 = NO (es correo normal)")
        tipo = int(input())  # Convertir a entero (1 o 0)
        
        # Guardar la etiqueta en la lista 'etiquetas'
        etiquetas.append(tipo)
        
        # Mostrar confirmación al usuario
        if tipo == 1:
            print(f"✓ Archivo '{nombre}.txt' guardado como SPAM")
        else:
            print(f"✓ Archivo '{nombre}.txt' guardado como NO SPAM")

    # --------------------------------------------------
    # PASO 4: CONVERTIR TEXTO A MATRIZ NUMÉRICA
    # --------------------------------------------------
    # Explicación: Los algoritmos de Machine Learning NO entienden texto
    # Necesitamos convertir palabras a números (frecuencias)
    
    print("\n" + "=" * 50)
    print("CONVIRTIENDO TEXTO A NÚMEROS...")
    print("=" * 50)
    
    # Crear el vectorizador (herramienta de conversión)
    # CountVectorizer hace lo siguiente:
    #   1. Crea un diccionario con todas las palabras únicas
    #   2. Cuenta cuántas veces aparece cada palabra en cada correo
    #   3. Genera una matriz donde filas = correos, columnas = palabras
    vectorizador = CountVectorizer()
    
    # 'fit_transform' hace dos cosas:
    #   - fit: aprende el vocabulario (todas las palabras únicas)
    #   - transform: convierte los textos a números
    # El resultado X es una matriz numérica
    X = vectorizador.fit_transform(correos)
    
    # Mostrar información útil al usuario
    print(f"✓ Se encontraron {X.shape[1]} palabras únicas en todos los correos")
    print(f"✓ Matriz generada: {X.shape[0]} correos x {X.shape[1]} palabras")
    print("  (cada número representa la frecuencia de una palabra)")

    # --------------------------------------------------
    # PASO 5: ENTRENAR EL MODELO NAIVE BAYES
    # --------------------------------------------------
    # Explicación: Naive Bayes es un algoritmo probabilístico
    # Calcula la probabilidad de que un correo sea SPAM basado en
    # las palabras que contiene
    
    print("\n" + "=" * 50)
    print("ENTRENANDO MODELO NAIVE BAYES...")
    print("=" * 50)
    
    # Crear una instancia del clasificador Multinomial Naive Bayes
    # 'Multinomial' porque trabajamos con frecuencias de palabras
    modelo = MultinomialNB()
    
    # Entrenar el modelo con:
    #   X = datos numéricos (frecuencias de palabras)
    #   etiquetas = clasificaciones (1=spam, 0=no spam)
    modelo.fit(X, etiquetas)
    
    print("✓ Modelo entrenado exitosamente")
    print("✓ El modelo ahora puede clasificar nuevos correos")
    print("=" * 50)
    
    # Retornar el modelo y el vectorizador para usarlos después
    return modelo, vectorizador


# --------------------------------------------------
# FUNCIÓN 2: CLASIFICAR UN CORREO NUEVO
# --------------------------------------------------
# Propósito: Leer un correo nuevo y predecir si es SPAM o NO SPAM
# Parámetros:
#   - modelo: el clasificador entrenado
#   - vectorizador: herramienta para convertir texto a números
# --------------------------------------------------

def clasificar(modelo, vectorizador):
    
    print("\n" + "=" * 50)
    print("FASE DE CLASIFICACIÓN")
    print("=" * 50)
    
    # --------------------------------------------------
    # PASO 1: SOLICITAR EL CORREO A CLASIFICAR
    # --------------------------------------------------
    print("Nombre del archivo a clasificar (sin .txt):")
    nombre = input()
    
    # --------------------------------------------------
    # PASO 2: LEER EL CONTENIDO DEL ARCHIVO
    # --------------------------------------------------
    try:
        archivo = open(nombre + ".txt", "r", encoding="utf-8")
        texto = archivo.read()
        archivo.close()
        print(f"✓ Archivo '{nombre}.txt' leído correctamente")
    except FileNotFoundError:
        print(f"❌ ERROR: No se encontró el archivo '{nombre}.txt'")
        print("   Asegúrate de que el archivo existe en la misma carpeta")
        return  # Salir de la función si no encuentra el archivo
    
    # --------------------------------------------------
    # PASO 3: CONVERTIR EL TEXTO A FORMATO NUMÉRICO
    # --------------------------------------------------
    # IMPORTANTE: Usamos 'transform' NO 'fit_transform'
    # Porque ya aprendimos el vocabulario durante el entrenamiento
    # Debemos usar el MISMO vocabulario para mantener consistencia
    X_nuevo = vectorizador.transform([texto])  # [texto] es una lista con un solo elemento
    
    # --------------------------------------------------
    # PASO 4: REALIZAR LA PREDICCIÓN
    # --------------------------------------------------
    # predict() analiza las frecuencias de palabras y decide
    # Retorna un array: [0] para NO SPAM o [1] para SPAM
    resultado = modelo.predict(X_nuevo)
    
    # --------------------------------------------------
    # PASO 5: MOSTRAR EL RESULTADO AL USUARIO
    # --------------------------------------------------
    print("\n" + "-" * 30)
    print("RESULTADO DE LA CLASIFICACIÓN:")
    print("-" * 30)
    
    if resultado[0] == 1:
        # Si la predicción es 1, es SPAM
        print("⚠️  El correo fue clasificado como: SPAM")
        print("   Este correo probablemente contiene publicidad o es sospechoso")
    else:
        # Si la predicción es 0, NO es SPAM
        print("✅ El correo fue clasificado como: NO SPAM")
        print("   Este correo parece ser legítimo o normal")
    
    print("-" * 30)


# --------------------------------------------------
# PROGRAMA PRINCIPAL
# --------------------------------------------------
# Punto de entrada del programa
# El código dentro de este bloque solo se ejecuta si
# ejecutamos este script directamente (no si se importa)
# --------------------------------------------------

if __name__ == "__main__":
    
    # --------------------------------------------------
    # MOSTRAR BANNER DE INICIO
    # --------------------------------------------------
    print("\n" + "█" * 50)
    print("   CLASIFICADOR DE SPAM CON NAIVE BAYES")
    print("   Machine Learning para correos electrónicos")
    print("█" * 50)
    
    # --------------------------------------------------
    # PASO 1: ENTRENAR EL MODELO
    # --------------------------------------------------
    # Llamamos a la función entrenamiento() que:
    #   1. Pide los correos de entrenamiento
    #   2. Convierte texto a números
    #   3. Entrena el modelo
    #   4. Retorna el modelo y el vectorizador
    modelo, vectorizador = entrenamiento()
    
    # --------------------------------------------------
    # PASO 2: CLASIFICAR CORREOS (EN CICLO)
    # --------------------------------------------------
    # Variable para controlar si el usuario quiere continuar
    continuar = "s"
    
    # Mientras el usuario ingrese 's' (sí), seguimos clasificando
    while continuar == "s":
        
        # Llamar a la función para clasificar un correo
        clasificar(modelo, vectorizador)
        
        # Preguntar si desea clasificar otro correo
        print("\n¿Deseas clasificar otro correo?")
        print("   s = sí, continuar")
        print("   n = no, salir")
        continuar = input()
        
        # Si el usuario ingresa algo diferente a 's', salir del ciclo
        # Nota: Podríamos aceptar también 'S' mayúscula
    
    # --------------------------------------------------
    # MENSAJE DE DESPEDIDA
    # --------------------------------------------------
    print("\n" + "=" * 50)
    print("¡GRACIAS POR USAR EL CLASIFICADOR DE SPAM!")
    print("=" * 50)