Proceso SistemaRecomendacionAutosCompleto
    // ==================== ESTRUCTURAS DE DATOS ====================
    Definir usuario Como Registro:
        // Datos demográficos
        edad: Entero
        genero: Cadena
        ingresos: Real
        ocupacion: Cadena
        ubicacion: Cadena
        
        // Preferencias y necesidades
        estiloPersonalidad: Cadena
        presupuesto: Real
        usoPrincipal: Cadena
        esPrimerVehiculo: Logico
        necesitaFinanciacion: Logico
        buscaUsado: Logico
        
        // Factores de estilo de vida
        tieneHijos: Logico
        cantidadHijos: Entero
        tieneMascotas: Logico
        tipoMascota: Cadena
        
        // Preferencias específicas
        preferenciaMarca: Cadena
        evitarMarca: Cadena
        tipoCombustiblePreferido: Cadena
        transmisionPreferida: Cadena
        
        // Historial e interacciones
        historialConduccion: Entero  // 1-5 (novato-experto)
        rechazosConsecutivos: Entero
        vehiculosVistos: Arreglo de Entero
    FinRegistro

    Definir vehiculo Como Registro:
        // Identificación
        id: Entero
        marca: Cadena
        modelo: Cadena
        año: Entero
        
        // Características técnicas
        tipo: Cadena  // sedan, suv, hatchback, etc.
        tipoCombustible: Cadena
        transmision: Cadena
        traccion: Cadena
        potencia: Entero  // HP
        consumo: Real  // l/100km o kWh/100km
        
        // Seguridad y comodidad
        seguridad: Entero  // 1-5
        espacioPasajeros: Entero  // 1-5
        espacioMaletero: Entero  // 1-5
        asientosIsofix: Entero
        
        // Tecnología
        nivelTecnologico: Entero  // 1-5
        asistenciaConduccion: Logico
        conectividad: Logico
        
        // Financiamiento
        precio: Real
        disponible: Logico
        tieneBonoPrimerAuto: Logico
        planFinanciamiento: Logico
        
        // Datos comerciales
        calificacionVentas: Entero  // 1-5
        garantia: Entero  // años
    FinRegistro

    // ==================== VARIABLES GLOBALES ====================
    Definir vehiculosDisponibles Como Arreglo de vehiculo
    Definir recomendaciones Como Arreglo de Entero  // IDs de vehículos
    Definir puntuaciones Como Arreglo de Real
    Definir umbralSeguridad <- 4
    Definir maxRechazos <- 3

    // ==================== FUNCIONES PRINCIPALES ====================
    Función GenerarRecomendaciones()
        usuario <- ObtenerDatosUsuario()
        vehiculosDisponibles <- CargarBaseDatosVehiculos()
        
        // Etapa 1: Filtrado inicial
        vehiculosFiltrados <- FiltrarVehiculos(vehiculosDisponibles, usuario)
        
        // Etapa 2: Evaluación y puntuación
        Para cada v en vehiculosFiltrados Hacer
            puntuacion <- 0.0
            
            // Aplicar todas las reglas de puntuación
            puntuacion <- puntuacion + EvaluarEstiloPersonalidad(v, usuario)
            puntuacion <- puntuacion + EvaluarDemograficos(v, usuario)
            puntuacion <- puntuacion + EvaluarEstiloVida(v, usuario)
            puntuacion <- puntuacion + EvaluarTecnologia(v, usuario)
            puntuacion <- puntuacion + EvaluarFinanciacion(v, usuario)
            puntuacion <- puntuacion + EvaluarPreferenciasMarca(v, usuario)
            puntuacion <- puntuacion + EvaluarHistorialConduccion(v, usuario)
            puntuacion <- puntuacion + EvaluarContextoGeografico(v, usuario)
            
            Si usuario.buscaUsado Entonces
                puntuacion <- puntuacion + EvaluarVehiculosUsados(v, usuario)
            FinSi
            
            // Añadir a recomendaciones si supera umbral mínimo
            Si puntuacion > 0 Entonces
                Agregar(recomendaciones, v.id)
                Agregar(puntuaciones, puntuacion)
            FinSi
        FinPara
        
        // Ordenar recomendaciones por puntuación
        recomendaciones <- OrdenarPorPuntuacion(recomendaciones, puntuaciones)
        
        // Etapa 3: Gestión de recomendaciones
        cicloRecomendacion <- 0
        Mientras Verdadero Hacer
            MostrarRecomendaciones(recomendaciones, cicloRecomendacion)
            feedback <- ObtenerFeedbackUsuario()
            
            Si feedback = "aceptado" Entonces
                RegistrarSeleccion(usuario, recomendaciones[0])
                Terminar
            Sino Si feedback = "rechazado" Entonces
                usuario.rechazosConsecutivos <- usuario.rechazosConsecutivos + 1
                Agregar(usuario.vehiculosVistos, recomendaciones[0])
                
                Si usuario.rechazosConsecutivos >= maxRechazos Entonces
                    RecalibrarPreferencias(usuario)
                    GenerarRecomendaciones()  // Reiniciar proceso
                    Retornar
                Sino
                    recomendaciones <- RotarOpciones(recomendaciones)
                    cicloRecomendacion <- cicloRecomendacion + 1
                FinSi
            FinSi
        FinMientras
    FinFunción

    // ==================== FUNCIONES DE FILTRADO ====================
    Función vehiculosFiltrados <- FiltrarVehiculos(vehiculos, usuario)
        vehiculosFiltrados <- Arreglo vacío
        
        Para cada v en vehiculos Hacer
            cumple <- Verdadero
            
            // Aplicar filtros obligatorios
            Si NO v.disponible O v.seguridad < umbralSeguridad O v.precio > usuario.presupuesto Entonces
                cumple <- Falso
            FinSi
            
            // Filtros condicionales
            Si usuario.buscaUsado Y v.año > AñoActual() - 3 Entonces
                cumple <- Falso
            FinSi
            
            Si cumple Entonces
                Agregar(vehiculosFiltrados, v)
            FinSi
        FinPara
        
        Retornar vehiculosFiltrados
    FinFunción

    // ==================== FUNCIONES DE EVALUACIÓN ====================
    // Cada función de evaluación devuelve un valor entre 0 y 10 puntos
    
    Función puntos <- EvaluarEstiloPersonalidad(v, usuario)
        puntos <- 0
        
        Segun usuario.estiloPersonalidad Hacer
            Caso "aventurero":
                Si v.tipo = "suv" O v.tipo = "4x4" Entonces
                    puntos <- 8
                FinSi
            Caso "práctico":
                Si v.tipo = "hatchback" O v.tipo = "compacto" Entonces
                    puntos <- 7
                FinSi
            Caso "sofisticado":
                Si v.marca = "premium" Y v.nivelTecnologico >= 4 Entonces
                    puntos <- 9
                FinSi
            // ... otros estilos
        FinSegun
        
        Retornar puntos
    FinFunción

    Función puntos <- EvaluarDemograficos(v, usuario)
        puntos <- 0
        
        // Evaluación por edad
        Si usuario.edad < 25 Entonces
            Si v.nivelTecnologico >= 4 Y v.conectividad Entonces
                puntos <- puntos + 3
            FinSi
        Sino Si usuario.edad >= 60 Entonces
            Si v.asistenciaConduccion Entonces
                puntos <- puntos + 4
            FinSi
        FinSi
        
        // Evaluación por ingresos
        Si usuario.ingresos < 30000 Entonces
            Si v.precio < usuario.presupuesto * 0.8 Entonces
                puntos <- puntos + 2
            FinSi
        Sino Si usuario.ingresos > 100000 Entonces
            Si v.marca = "premium" Entonces
                puntos <- puntos + 3
            FinSi
        FinSi
        
        Retornar puntos
    FinFunción

    Función puntos <- EvaluarEstiloVida(v, usuario)
        puntos <- 0
        
        // Evaluación para familias
        Si usuario.tieneHijos Entonces
            Si v.asientosIsofix >= usuario.cantidadHijos Y v.espacioPasajeros >= 4 Entonces
                puntos <- puntos + 5
            FinSi
            
            Si usuario.cantidadHijos > 2 Y v.tipo = "minivan" Entonces
                puntos <- puntos + 3
            FinSi
        FinSi
        
        // Evaluación para mascotas
        Si usuario.tieneMascotas Y usuario.tipoMascota = "grande" Entonces
            Si v.espacioMaletero >= 4 Entonces
                puntos <- puntos + 3
            FinSi
        FinSi
        
        // Evaluación por uso principal
        Segun usuario.usoPrincipal Hacer
            Caso "urbano":
                Si v.tipo = "compacto" O v.tipo = "hatchback" Entonces
                    puntos <- puntos + 4
                FinSi
            Caso "carretera":
                Si v.consumo < 6.0 Y v.seguridad >= 4 Entonces
                    puntos <- puntos + 5
                FinSi
            // ... otros usos
        FinSegun
        
        Retornar puntos
    FinFunción

    // ... (continuar con las demás funciones de evaluación)

    // ==================== FUNCIONES AUXILIARES ====================
    Función RecalibrarPreferencias(usuario)
        // Generar preguntas basadas en patrones de rechazo
        preguntas <- GenerarPreguntasContextuales(usuario.vehiculosVistos)
        
        Para cada p en preguntas Hacer
            respuesta <- MostrarPreguntaYCapturarRespuesta(p)
            ActualizarPerfilUsuario(usuario, p, respuesta)
        FinPara
        
        usuario.rechazosConsecutivos <- 0
    FinFunción

    Función nuevasRecs <- RotarOpciones(recomendaciones)
        // Mover la primera recomendación al final
        nuevasRecs <- recomendaciones[1..-1] + [recomendaciones[0]]
        Retornar nuevasRecs
    FinFunción

    // ==================== EJECUCIÓN PRINCIPAL ====================
    Inicio
        GenerarRecomendaciones()
    Fin
FinProceso

// ==================== HECHOS DE VEHÍCULOS USADOS==============
// Estructura: (id, marca, modelo, año, tipo, tipoCombustible, transmision, traccion, potencia, consumo, seguridad, 
//             espacioPasajeros, espacioMaletero, asientosIsofix, nivelTecnologico, asistenciaConduccion, 
//             conectividad, precio, disponible, tieneBonoPrimerAuto, planFinanciamiento, calificacionVentas, garantia)

// --- Segmento Premium ---
(1, "Audi", "A4", 2015, "sedan", "gasolina", "automatica", "delantera", 190, 6.5, 5, 4, 3, 2, 5, Verdadero, Verdadero, 32000, Verdadero, Falso, Verdadero, 4, 3)
(2, "Audi", "A3", 2019, "hatchback", "gasolina", "automatica", "delantera", 150, 5.8, 5, 3, 2, 2, 5, Verdadero, Verdadero, 28000, Verdadero, Verdadero, Falso, 5, 3)
(3, "BMW", "X5", 2017, "suv", "diesel", "automatica", "4x4", 300, 8.2, 5, 5, 4, 3, 5, Verdadero, Verdadero, 45000, Verdadero, Falso, Verdadero, 5, 5)
(4, "Mercedes Benz", "C-Class", 2019, "sedan", "hibrido", "automatica", "trasera", 245, 5.9, 5, 4, 3, 2, 5, Verdadero, Verdadero, 42000, Verdadero, Falso, Verdadero, 5, 4)

// --- Segmento Familiar ---
(5, "Toyota", "Camry", 2017, "sedan", "gasolina", "automatica", "delantera", 178, 7.1, 4, 5, 3, 3, 4, Falso, Verdadero, 22000, Verdadero, Verdadero, Falso, 4, 5)
(6, "Kia", "Carnival", 2019, "people_mover", "diesel", "automatica", "delantera", 200, 8.5, 5, 5, 5, 4, 4, Falso, Verdadero, 35000, Verdadero, Verdadero, Verdadero, 4, 7)
(7, "Honda", "Odyssey", 2016, "people_mover", "gasolina", "automatica", "delantera", 185, 8.1, 4, 5, 4, 4, 4, Verdadero, Verdadero, 30000, Verdadero, Verdadero, Falso, 4, 5)

// --- SUV Medianos ---
(8, "Mazda", "CX-5", 2017, "suv", "gasolina", "automatica", "4x4", 187, 6.8, 4, 5, 4, 3, 4, Verdadero, Verdadero, 27000, Verdadero, Falso, Verdadero, 5, 3)
(9, "Hyundai", "Tucson", 2019, "suv", "hibrido", "automatica", "delantera", 177, 6.2, 4, 5, 3, 3, 4, Verdadero, Verdadero, 26000, Verdadero, Verdadero, Falso, 4, 5)
(10, "Subaru", "Forester", 2018, "suv", "gasolina", "automatica", "4x4", 182, 7.3, 5, 5, 4, 3, 4, Verdadero, Verdadero, 29000, Verdadero, Falso, Verdadero, 5, 3)

// --- Vehículos Pequeños/Económicos ---
(11, "Toyota", "Corolla", 2019, "compacto", "gasolina", "manual", "delantera", 132, 5.7, 4, 4, 2, 2, 3, Falso, Verdadero, 18000, Verdadero, Verdadero, Falso, 4, 3)
(12, "Hyundai", "i30", 2017, "hatchback", "gasolina", "automatica", "delantera", 120, 6.0, 3, 4, 2, 2, 3, Falso, Verdadero, 16000, Verdadero, Verdadero, Verdadero, 4, 5)
(13, "Suzuki", "Swift", 2017, "compacto", "gasolina", "manual", "delantera", 82, 4.9, 2, 4, 1, 1, 2, Falso, Falso, 12000, Verdadero, Verdadero, Falso, 3, 3)

// --- Vehículos Comerciales ---
(14, "Ford", "Ranger", 2016, "pickup", "diesel", "manual", "4x4", 200, 8.7, 4, 3, 5, 0, 3, Falso, Verdadero, 32000, Verdadero, Falso, Verdadero, 4, 3)
(15, "Toyota", "Hilux", 2019, "pickup", "diesel", "automatica", "4x4", 150, 7.8, 5, 3, 5, 0, 3, Falso, Verdadero, 35000, Verdadero, Falso, Verdadero, 5, 5)

// --- Vehículos Eléctricos/Híbridos ---
(16, "Toyota", "Prius", 2016, "hatchback", "hibrido", "automatica", "delantera", 121, 3.7, 4, 4, 2, 2, 5, Verdadero, Verdadero, 25000, Verdadero, Verdadero, Falso, 4, 5)
(17, "Hyundai", "Kona Electric", 2019, "suv", "electrico", "automatica", "delantera", 201, 14.3, 5, 4, 3, 2, 5, Verdadero, Verdadero, 38000, Verdadero, Verdadero, Verdadero, 5, 5)
// ==================== VEHÍCULOS NUEVOS (2024-2025) ====================  
// Estructura: (id, marca, modelo, año, tipo, tipoCombustible, transmision, traccion, potencia, consumo, seguridad,  
//             espacioPasajeros, espacioMaletero, asientosIsofix, nivelTecnologico, asistenciaConduccion,  
//             conectividad, precio, disponible, tieneBonoPrimerAuto, planFinanciamiento, calificacionVentas, garantia)  

// --- Segmento Premium/Lujo ---  
(101, "Mercedes-Benz", "EQS Sedan", 2025, "sedan", "electrico", "automatica", "trasera", 536, 16.0, 5, 5, 3, 2, 5, Verdadero, Verdadero, 120000, Verdadero, Falso, Verdadero, 5, 4)  // 700 km autonomía  
(102, "BMW", "i7 xDrive60", 2025, "sedan", "electrico", "automatica", "4x4", 544, 18.1, 5, 5, 4, 3, 5, Verdadero, Verdadero, 135000, Verdadero, Falso, Verdadero, 5, 5)  // Pantalla 31" trasera  
(103, "Audi", "Q8 e-tron", 2025, "suv", "electrico", "automatica", "4x4", 408, 19.5, 5, 5, 5, 4, 5, Verdadero, Verdadero, 90000, Verdadero, Falso, Verdadero, 4, 4)  // Carga ultrarrápida  
(104, "Porsche", "Taycan Turbo S", 2025, "deportivo", "electrico", "automatica", "4x4", 952, 20.3, 5, 4, 2, 0, 5, Verdadero, Verdadero, 250000, Verdadero, Falso, Falso, 5, 3)  // 0-100 km/h en 2.4s  
(105, "Lexus", "RZ 450e", 2025, "suv", "electrico", "automatica", "4x4", 313, 15.6, 5, 5, 4, 3, 5, Verdadero, Verdadero, 75000, Verdadero, Falso, Verdadero, 4, 6)  // Dirección por cable  

// --- Segmento SUV Familiares ---  
(106, "Volvo", "EX90", 2025, "suv", "electrico", "automatica", "4x4", 517, 17.8, 5, 7, 5, 5, 5, Verdadero, Verdadero, 85000, Verdadero, Verdadero, Verdadero, 5, 5)  // 7 asientos  
(107, "Tesla", "Model Y", 2025, "suv", "electrico", "automatica", "4x4", 384, 15.2, 5, 5, 4, 3, 5, Verdadero, Verdadero, 55000, Verdadero, Verdadero, Falso, 5, 4)  // Autopilot estándar  
(108, "Hyundai", "Ioniq 7", 2025, "suv", "electrico", "automatica", "4x4", 320, 16.5, 5, 6, 5, 4, 4, Verdadero, Verdadero, 60000, Verdadero, Verdadero, Verdadero, 4, 5)  // Asientos giratorios  
(109, "Kia", "EV9", 2025, "suv", "electrico", "automatica", "4x4", 379, 16.0, 5, 6, 4, 4, 4, Verdadero, Verdadero, 65000, Verdadero, Verdadero, Verdadero, 4, 5)  // 541 km autonomía  
(110, "Ford", "Explorer EV", 2025, "suv", "electrico", "automatica", "4x4", 450, 18.0, 5, 7, 5, 4, 4, Verdadero, Verdadero, 70000, Verdadero, Falso, Verdadero, 4, 4)  // Plataforma Volkswagen  

// --- Segmento Sedanes/Compactos ---  
(111, "Toyota", "Camry Hybrid", 2025, "sedan", "hibrido", "automatica", "delantera", 225, 4.3, 5, 5, 3, 3, 4, Verdadero, Verdadero, 35000, Verdadero, Verdadero, Verdadero, 5, 5)  // 50 km/l  
(112, "Honda", "Accord Hybrid", 2025, "sedan", "hibrido", "automatica", "delantera", 204, 4.5, 5, 5, 3, 3, 4, Verdadero, Verdadero, 38000, Verdadero, Verdadero, Falso, 4, 5)  // Asistente IA  
(113, "Volkswagen", "ID.7", 2025, "sedan", "electrico", "automatica", "trasera", 286, 14.0, 5, 5, 2, 2, 5, Verdadero, Verdadero, 50000, Verdadero, Verdadero, Verdadero, 4, 4)  // 700 km autonomía  
(114, "BYD", "Seal", 2025, "sedan", "electrico", "automatica", "4x4", 530, 13.5, 5, 5, 2, 2, 5, Verdadero, Verdadero, 45000, Verdadero, Verdadero, Falso, 4, 6)  // Tecnología Blade Battery  
(115, "Nissan", "Leaf e+", 2025, "compacto", "electrico", "automatica", "delantera", 217, 13.8, 4, 4, 2, 2, 4, Falso, Verdadero, 32000, Verdadero, Verdadero, Falso, 4, 5)  // 385 km autonomía  

// --- Segmento Económico/Ciudad ---  
(116, "Chevrolet", "Bolt EUV", 2025, "hatchback", "electrico", "automatica", "delantera", 200, 12.5, 4, 4, 2, 2, 3, Falso, Verdadero, 28000, Verdadero, Verdadero, Falso, 4, 3)  // 400 km autonomía  
(117, "Renault", "Zoe E-Tech", 2025, "hatchback", "electrico", "automatica", "delantera", 135, 11.8, 3, 4, 1, 1, 3, Falso, Verdadero, 22000, Verdadero, Verdadero, Falso, 3, 4)  // Ideal para ciudad  
(118, "MG", "MG4", 2025, "hatchback", "electrico", "automatica", "delantera", 203, 12.0, 4, 4, 2, 2, 4, Falso, Verdadero, 25000, Verdadero, Verdadero, Verdadero, 4, 5)  // 450 km autonomía  
(119, "Fiat", "500e", 2025, "compacto", "electrico", "automatica", "delantera", 118, 10.5, 3, 4, 1, 1, 3, Falso, Verdadero, 23000, Verdadero, Verdadero, Falso, 3, 3)  // Diseño retro  
(120, "Toyota", "bZ3", 2025, "sedan", "electrico", "automatica", "delantera", 245, 13.0, 4, 5, 2, 2, 4, Verdadero, Verdadero, 35000, Verdadero, Verdadero, Falso, 4, 5)  // Colaboración BYD  

// --- Segmento Comerciales/Pickups ---  
(121, "Ford", "F-150 Lightning", 2025, "pickup", "electrico", "automatica", "4x4", 580, 21.0, 5, 3, 5, 0, 4, Verdadero, Verdadero, 70000, Verdadero, Falso, Verdadero, 5, 3)  // 480 km autonomía  
(122, "Tesla", "Cybertruck", 2025, "pickup", "electrico", "automatica", "4x4", 845, 22.5, 5, 3, 5, 0, 5, Verdadero, Verdadero, 90000, Verdadero, Falso, Falso, 5, 4)  // Blindaje opcional  
(123, "Rivian", "R1T", 2025, "pickup", "electrico", "automatica", "4x4", 835, 20.0, 5, 3, 5, 0, 5, Verdadero, Verdadero, 85000, Verdadero, Falso, Verdadero, 5, 5)  // 640 km autonomía  
(124, "Toyota", "Hilux Hybrid", 2025, "pickup", "hibrido", "automatica", "4x4", 204, 8.5, 4, 3, 5, 0, 4, Falso, Verdadero, 45000, Verdadero, Falso, Verdadero, 5, 5)  // Resistencia probada  
(125, "Chevrolet", "Silverado EV", 2025, "pickup", "electrico", "automatica", "4x4", 664, 21.5, 5, 3, 5, 0, 4, Verdadero, Verdadero, 80000, Verdadero, Falso, Verdadero, 5, 3)  // 640 km autonomía
