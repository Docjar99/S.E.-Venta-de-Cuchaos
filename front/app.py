from flask import Flask, render_template, request
import subprocess
import os

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/bienvenido')
def bienvenido():
    return render_template('bienvenido.html')

@app.route('/ingresardatos')
def ingresardatos():
    return render_template('ingresardatos.html')

@app.route('/procesar', methods=['POST'])
def procesar():
    datos = {
        "edad": request.form['edad'],
        "genero": request.form['genero'].lower(),
        "ingresos": request.form['ingresos'],
        "ocupacion": request.form['ocupacion'].lower(),
        "ubicacion": request.form['ubicacion'].lower(),
        "estiloPersonalidad": request.form['estiloPersonalidad'].lower(),
        "presupuesto": request.form['presupuesto'],
        "usoPrincipal": request.form['usoPrincipal'].lower(),
        "esPrimerVehiculo": "yes" if 'esPrimerVehiculo' in request.form else "no",
        "necesitaFinanciacion": "yes" if 'necesitaFinanciacion' in request.form else "no",
        "buscaUsado": "yes" if 'buscaUsado' in request.form else "no",
        "tieneHijos": "yes" if 'tieneHijos' in request.form else "no",
        "cantidadHijos": request.form['cantidadHijos'],
        "tieneMascotas": "yes" if 'tieneMascotas' in request.form else "no",
        "tipoMascota": request.form['tipoMascota'].lower(),
        "preferenciaMarca": request.form['preferenciaMarca'].lower(),
        "evitarMarca": request.form['evitarMarca'].lower(),
        "tipoCombustiblePreferido": request.form['tipoCombustiblePreferido'].lower(),
        "transmisionPreferida": request.form['transmisionPreferida'].lower(),
        "historialConduccion": request.form['historialConduccion'],
        "rechazosConsecutivos": 0
    }

    with open("entrada_usuario.clp", "w") as f:
        f.write("(deffacts datos-iniciales\n")
        f.write("   (usuario\n")
        for key, value in datos.items():
            if value in ["yes", "no"]:  
                f.write(f"      ({key} {value})\n")
            elif isinstance(value, str) and not value.replace('.', '').isdigit():  
                value = value.replace(" ", "_").lower()
                f.write(f"      ({key} {value})\n")
            else:  
                f.write(f"      ({key} {value})\n")
        f.write("      (vehiculosVistos)\n")
        f.write("   )\n")
        f.write(")\n")

 
    ruta_clips = r"C:\Program Files\SSS\CLIPS 6.4.2\clipsdos.exe"
    

    with open("ejecucion.clp", "w") as f:
        f.write("(load sistema.clp)\n")
        f.write("(load entrada_usuario.clp)\n")
        f.write("(reset)\n")
        f.write("(run)\n")
    

    with open("salida.txt", "w") as salida:
        subprocess.run([ruta_clips, "-f2", "ejecucion.clp"], stdout=salida, stderr=subprocess.STDOUT)

  
    if os.path.exists("ejecucion.clp"):
        os.remove("ejecucion.clp")
    if os.path.exists("entrada_usuario.clp"):
        os.remove("entrada_usuario.clp")

   
    recomendaciones = []
    if os.path.exists("salida.txt"):
        with open("salida.txt", "r", encoding="utf-8") as f:
            for linea in f:
                if "Recomendación:" in linea:
                    recomendaciones.append(linea.strip())
        os.remove("salida.txt")

    return render_template("resultado.html", recomendaciones=recomendaciones)

@app.route('/resultado')
def resultado():
    return render_template("resultado.html")

if __name__ == '__main__':
    app.run(debug=True)