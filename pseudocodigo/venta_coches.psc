Proceso SistemaRecomendacionAutosMejorado
    Definir usuario Como Registro:
        edad, genero, ingresos, estilo, preferencias, uso, presupuesto,
        esPrimerVehiculo, necesitaFinanciacion, vehiculoIntercambio,
        rechazosConsecutivos
    FinRegistro
    
    Definir vehiculos Como Arreglo de Registro:
        id, marca, modelo, tipo, año, precio, seguridad, fiabilidad,
        tecnologia, autonomia, garantia, disponible, calificacionVentas
    FinRegistro
    
    Definir recomendaciones Como Arreglo
    Definir puntuaciones Como Arreglo de Entero
    
    // 1. Función principal 
    Funcion GenerarRecomendaciones()
        // Cargar datos
        usuario <- ObtenerDatosUsuario()
        vehiculos <- CargarBaseDatos()
        
        // Sistema de puntuación adaptativo
        Para cada vehiculo en vehiculos Hacer
            puntuacion <- 0
            
            // Sistema de reglas con pesos
            puntuacion <- puntuacion + EvaluarEstilosPersonalidad(vehiculo, usuario)
            puntuacion <- puntuacion + EvaluarInteraccionesDemograficas(vehiculo, usuario)
            puntuacion <- puntuacion + EvaluarFactoresTecnoAmbientales(vehiculo, usuario)
            puntuacion <- puntuacion + EvaluarFinanciacion(vehiculo, usuario)
            
            Si usuario.buscaUsado Entonces
                puntuacion <- puntuacion + EvaluarUsados(vehiculo, usuario)
            FinSi
            
            // Aplicar filtros 
            Si vehiculo.disponible Y vehiculo.seguridad >= 4 Y CumplePresupuesto(vehiculo, usuario) Entonces
                AgregarPuntuacion(puntuaciones, vehiculo.id, puntuacion)
            FinSi
        FinPara
        
        // Ordenando y seleccionando mejores opciones
        recomendaciones <- OrdenarPorPuntuacion(vehiculos, puntuaciones)
        
        // Aplicando reglas de respaldo 
        recomendaciones <- AplicarRespaldoDinamico(recomendaciones, usuario)
        
        // Mostrando resultados con sistema de feedback
        Mientras Verdadero Hacer
            MostrarRecomendaciones(recomendaciones)
            Si ObtenerFeedbackUsuario() = "aceptado" Entonces
                Terminar
            Sino
                usuario.rechazosConsecutivos <- usuario.rechazosConsecutivos + 1
                Si usuario.rechazosConsecutivos >= 3 Entonces
                    RecalibrarPreferencias(usuario)
                    GenerarRecomendaciones()  // Reiniciar proceso con nuevos datos
                Sino
                    recomendaciones <- RotarOpciones(recomendaciones)
                FinSi
            FinSi
        FinMientras
    FinFuncion

    // 2. Sistema de evaluación ponderada
    Funcion resultado <- EvaluarEstilosPersonalidad(vehiculo, usuario)
        resultado <- 0
        Segun usuario.estilo Hacer
            "perfeccionista":
                Si vehiculo.seguridad >= 5 Entonces resultado <- resultado + 40 FinSi
                Si vehiculo.fiabilidad >= 90 Entonces resultado <- resultado + 30 FinSi
            
            "hedonista":
                Si vehiculo.tecnologia >= 8 Entonces resultado <- resultado + 50 FinSi
                Si vehiculo.diseno = "deportivo" Entonces resultado <- resultado + 20 FinSi
            
            "ecologico_extremo":
                Si vehiculo.autonomia >= 300 Entonces resultado <- resultado + 60 FinSi
                
        FinSegun
    FinFuncion

    // 3. Interacciones demográficas
    Funcion resultado <- EvaluarInteraccionesDemograficas(vehiculo, usuario)
        resultado <- 0
        
        // Género y edad combinados
        Si usuario.genero = "mujer" Y usuario.edad >= 40 Entonces
            Si vehiculo.tipo = "SUV_mediano" Entonces resultado <- resultado + 25 FinSi
        FinSi
        
        Si usuario.genero = "hombre" Y usuario.edad < 30 Entonces
            Si vehiculo.tecnologia >= 7 Entonces resultado <- resultado + 35 FinSi
        FinSi
        
        // Perfiles especializados
        Si usuario.ocupacion = "estudiante" Entonces
            Si vehiculo.precio < 15000 Entonces resultado <- resultado + 45 FinSi
        FinSi
    FinFuncion

    // 4. Gestión inteligente de vehículos usados
    Funcion resultado <- EvaluarUsados(vehiculo, usuario)
        resultado <- 0
        Si vehiculo.año >= (AñoActual() - 5) Entonces
            resultado <- resultado + 20
            Si vehiculo.garantia = "extendida" Entonces resultado <- resultado + 15 FinSi
        FinSi
        
        Si usuario.ingresos = "bajos" Y vehiculo.costoMantenimiento < 100 Entonces
            resultado <- resultado + 30
        FinSi
    FinFuncion

    // 5. Sistema de respaldo adaptativo
    Funcion recomendaciones <- AplicarRespaldoDinamico(recomendaciones, usuario)
        Si Longitud(recomendaciones) < 3 Entonces
            // Fusión de estrategias: top ventas + perfil demográfico
            recomendaciones <- Combinar(
                ObtenerTopVentas(usuario.demografia),
                FiltrarPorTendencias(usuario)
            )
        FinSi
        
        // Actualización en tiempo real de disponibilidad
        Para cada vehiculo en recomendaciones Hacer
            Si No vehiculo.disponible Entonces
                vehiculo <- ObtenerAlternativaSimilar(vehiculo)
            FinSi
        FinPara
        
        Retornar recomendaciones
    FinFuncion

    // 6. Mecanismo de recalibración de preferencias
    Funcion RecalibrarPreferencias(usuario)
        // Sistema de preguntas adaptativas basado en rechazos previos
        preguntas <- GenerarPreguntasContextuales(recomendaciones, usuario.historial)
        Para cada pregunta en preguntas Hacer
            respuesta <- ObtenerRespuestaUsuario(pregunta)
            ActualizarPerfilUsuario(usuario, respuesta)
        FinPara
    FinFuncion
FinProceso
