import pandas as pd
from sklearn.tree import DecisionTreeClassifier, plot_tree, export_text
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import matplotlib
matplotlib.use('Agg') 
import matplotlib.pyplot as plt

print("=" * 60)
print("CLASIFICACIÓN DE LENTES DE CONTACTO")
print("=" * 60)


print("\n[1] Creando dataset...")

datos = []
for edad in [1, 2, 3]:
    for presc in [1, 2]:
        for astig in [1, 2]:
            for lag in [1, 2]:
                if astig == 2:
                    lente = 1
                else:
                    if edad == 3:
                        lente = 3
                    else:
                        lente = 2
                datos.append([edad, presc, astig, lag, lente])

df = pd.DataFrame(datos, columns=['Edad', 'Prescripcion', 'Astigmatismo', 'Lagrimas', 'Lente'])
print(f" Dataset creado: {len(df)} registros")


X = df[['Edad', 'Prescripcion', 'Astigmatismo', 'Lagrimas']]
y = df['Lente']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

print(f" Entrenamiento: {len(X_train)} | Prueba: {len(X_test)}")


print("\n[2] Entrenando árbol GINI...")
clf_gini = DecisionTreeClassifier(criterion="gini", random_state=42)
clf_gini.fit(X_train, y_train)
precision_gini = accuracy_score(y_test, clf_gini.predict(X_test))
profundidad_gini = clf_gini.get_depth()
print(f"    Precisión: {precision_gini*100:.2f}%")
print(f"    Profundidad: {profundidad_gini}")

# Guardar imagen del árbol GINI
plt.figure(figsize=(20, 12))
plot_tree(clf_gini, 
          feature_names=['Edad', 'Prescripcion', 'Astigmatismo', 'Lagrimas'],
          class_names=['Rigidos(1)', 'Blandas(2)', 'No_necesita(3)'],
          filled=True, rounded=True, fontsize=10)
plt.title(f"Arbol de Decision - GINI (Precision: {precision_gini*100:.2f}%)")
plt.savefig('arbol_gini.png', dpi=300, bbox_inches='tight')
plt.close()
print("     Imagen guardada: arbol_gini.png")


print("\n[3] Entrenando árbol ENTROPÍA...")
clf_entropy = DecisionTreeClassifier(criterion="entropy", random_state=42)
clf_entropy.fit(X_train, y_train)
precision_entropy = accuracy_score(y_test, clf_entropy.predict(X_test))
profundidad_entropy = clf_entropy.get_depth()
print(f"    Precisión: {precision_entropy*100:.2f}%")
print(f"    Profundidad: {profundidad_entropy}")

# Guardar imagen del árbol ENTROPÍA
plt.figure(figsize=(20, 12))
plot_tree(clf_entropy, 
          feature_names=['Edad', 'Prescripcion', 'Astigmatismo', 'Lagrimas'],
          class_names=['Rigidos(1)', 'Blandas(2)', 'No_necesita(3)'],
          filled=True, rounded=True, fontsize=10)
plt.title(f"Arbol de Decision - ENTROPIA (Precision: {precision_entropy*100:.2f}%)")
plt.savefig('arbol_entropy.png', dpi=300, bbox_inches='tight')
plt.close()
print("     Imagen guardada: arbol_entropy.png")


print("\n[4] Entrenando árbol LOG_LOSS...")
clf_logloss = DecisionTreeClassifier(criterion="log_loss", random_state=42)
clf_logloss.fit(X_train, y_train)
precision_logloss = accuracy_score(y_test, clf_logloss.predict(X_test))
profundidad_logloss = clf_logloss.get_depth()
print(f"    Precisión: {precision_logloss*100:.2f}%")
print(f"    Profundidad: {profundidad_logloss}")

# Guardar imagen del árbol LOG_LOSS
plt.figure(figsize=(20, 12))
plot_tree(clf_logloss, 
          feature_names=['Edad', 'Prescripcion', 'Astigmatismo', 'Lagrimas'],
          class_names=['Rigidos(1)', 'Blandas(2)', 'No_necesita(3)'],
          filled=True, rounded=True, fontsize=10)
plt.title(f"Arbol de Decision - LOG_LOSS (Precision: {precision_logloss*100:.2f}%)")
plt.savefig('arbol_logloss.png', dpi=300, bbox_inches='tight')
plt.close()
print("     Imagen guardada: arbol_logloss.png")

# ================= REPORTE FINAL =================
print("\n" + "=" * 60)
print("REPORTE FINAL")
print("=" * 60)

print("\n+-------------+------------------+----------------+")
print("| CRITERIO    | PRECISION         | PROFUNDIDAD    |")
print("+-------------+------------------+----------------+")
print(f"| GINI        | {precision_gini*100:>14.2f}% | {profundidad_gini:>14} |")
print(f"| ENTROPIA    | {precision_entropy*100:>14.2f}% | {profundidad_entropy:>14} |")
print(f"| LOG_LOSS    | {precision_logloss*100:>14.2f}% | {profundidad_logloss:>14} |")
print("+-------------+------------------+----------------+")

# Verificar objetivo >90%
print("\n" + "=" * 60)
print("VERIFICACION DEL OBJETIVO (precision > 90%)")
print("=" * 60)

if precision_gini > 0.9:
    print(f" GINI: CUMPLE ({precision_gini*100:.2f}% > 90%)")
else:
    print(f" GINI: NO CUMPLE ({precision_gini*100:.2f}% < 90%)")

if precision_entropy > 0.9:
    print(f" ENTROPIA: CUMPLE ({precision_entropy*100:.2f}% > 90%)")
else:
    print(f" ENTROPIA: NO CUMPLE ({precision_entropy*100:.2f}% < 90%)")

if precision_logloss > 0.9:
    print(f" LOG_LOSS: CUMPLE ({precision_logloss*100:.2f}% > 90%)")
else:
    print(f" LOG_LOSS: NO CUMPLE ({precision_logloss*100:.2f}% < 90%)")

# Mostrar el mejor
precisiones = {'GINI': precision_gini, 'ENTROPIA': precision_entropy, 'LOG_LOSS': precision_logloss}
mejor = max(precisiones, key=precisiones.get)
print(f"\n MEJOR CRITERIO: {mejor} con {precisiones[mejor]*100:.2f}% de precision")

# Importancia de atributos
print("\n" + "=" * 60)
print("IMPORTANCIA DE ATRIBUTOS")
print("=" * 60)
print(f"\n{'Atributo':<20} {'GINI':<12} {'ENTROPIA':<12} {'LOG_LOSS':<12}")
print("-" * 56)
for i, attr in enumerate(['Edad', 'Prescripcion', 'Astigmatismo', 'Lagrimas']):
    print(f"{attr:<20} {clf_gini.feature_importances_[i]:<12.4f} {clf_entropy.feature_importances_[i]:<12.4f} {clf_logloss.feature_importances_[i]:<12.4f}")

print("\n" + "=" * 60)
print(" PROGRAMA COMPLETADO")
print(f"   Imagenes guardadas: arbol_gini.png, arbol_entropy.png, arbol_logloss.png")
print("=" * 60)