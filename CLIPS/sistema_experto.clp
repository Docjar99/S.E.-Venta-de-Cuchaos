
;; ==================== DEFINICIÓN DE PLANTILLAS ====================
(deftemplate usuario
   (slot edad (type INTEGER))
   (slot genero (type SYMBOL))
   (slot ingresos (type FLOAT))
   (slot ocupacion (type SYMBOL))
   (slot ubicacion (type SYMBOL))
   (slot estiloPersonalidad (type SYMBOL))
   (slot presupuesto (type FLOAT))
   (slot usoPrincipal (type SYMBOL))
   (slot esPrimerVehiculo (type SYMBOL)) ; TRUE/FALSE
   (slot necesitaFinanciacion (type SYMBOL))
   (slot buscaUsado (type SYMBOL))
   (slot tieneHijos (type SYMBOL))
   (slot cantidadHijos (type INTEGER))
   (slot tieneMascotas (type SYMBOL))
   (slot tipoMascota (type SYMBOL))
   (slot preferenciaMarca (type SYMBOL))
   (slot evitarMarca (type SYMBOL))
   (slot tipoCombustiblePreferido (type SYMBOL))
   (slot transmisionPreferida (type SYMBOL))
   (slot historialConduccion (type INTEGER))
   (slot rechazosConsecutivos (type INTEGER))
   (multislot vehiculosVistos)
)

(deftemplate vehiculo
   (slot id (type INTEGER))
   (slot marca (type SYMBOL))
   (slot modelo (type SYMBOL))
   (slot ano (type INTEGER))
   (slot tipo (type SYMBOL))
   (slot tipoCombustible (type SYMBOL))
   (slot transmision (type SYMBOL))
   (slot traccion (type SYMBOL))
   (slot potencia (type INTEGER))
   (slot consumo (type FLOAT))
   (slot seguridad (type INTEGER))
   (slot espacioPasajeros (type INTEGER))
   (slot espacioMaletero (type INTEGER))
   (slot asientosIsofix (type INTEGER))
   (slot nivelTecnologico (type INTEGER))
   (slot asistenciaConduccion (type SYMBOL)) ; TRUE/FALSE
   (slot conectividad (type SYMBOL))
   (slot precio (type FLOAT))
   (slot disponible (type SYMBOL))
   (slot tieneBonoPrimerAuto (type SYMBOL))
   (slot planFinanciamiento (type SYMBOL))
   (slot calificacionVentas (type INTEGER))
   (slot garantia (type INTEGER))
)

(deftemplate vehiculo-filtrado
   (slot id (type INTEGER))
   (slot puntuacion (type FLOAT))
)

(deftemplate recomendacion
   (slot id-vehiculo (type INTEGER))
   (slot puntuacion (type FLOAT))
   (slot motivo (type STRING))
)

;; ==================== BASE DE DATOS DE VEHÍCULOS ====================
(deffacts vehiculos-disponibles
   ;; Segmento Premium
   ;; Vehículos ya existentes
   (vehiculo 
      (id 1) (marca Audi) (modelo A4) (ano 2015)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion delantera) (potencia 190) (consumo 6.5) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 32000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 4) (garantia 3)
   )
   
   (vehiculo 
      (id 2) (marca Audi) (modelo A3) (ano 2019)
      (tipo hatchback) (tipoCombustible gasolina) (transmision automatica)
      (traccion delantera) (potencia 150) (consumo 5.8) (seguridad 5)
      (espacioPasajeros 3) (espacioMaletero 2) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 28000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento FALSE) (calificacionVentas 5) (garantia 3)
   )

   (vehiculo 
      (id 3) (marca BMW) (modelo Serie_3) (ano 2020)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 255) (consumo 6.4) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 41000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )

   (vehiculo 
      (id 4) (marca Mercedes_Benz) (modelo Clase_C) (ano 2021)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 255) (consumo 6.9) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 45000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 4) (garantia 4)
   )

   (vehiculo 
      (id 5) (marca Lexus) (modelo ES_300h) (ano 2022)
      (tipo sedan) (tipoCombustible hibrido) (transmision automatica)
      (traccion delantera) (potencia 215) (consumo 5.5) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 43000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 4) (garantia 5)
   )

   (vehiculo 
      (id 6) (marca Volvo) (modelo S60) (ano 2021)
      (tipo sedan) (tipoCombustible hibrido) (transmision automatica)
      (traccion integral) (potencia 250) (consumo 6.2) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 3)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 47000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 7) (marca Jaguar) (modelo XE) (ano 2018)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 240) (consumo 7.0) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 39000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 8) (marca Infiniti) (modelo Q50) (ano 2017)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 300) (consumo 7.2) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 4) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 37000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 4) (garantia 4)
   )
   
   (vehiculo 
      (id 9) (marca Cadillac) (modelo ATS) (ano 2014)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 273) (consumo 7.5) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 4) (asistenciaConduccion FALSE) (conectividad TRUE)
      (precio 36000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 4) (garantia 4)
   )
   
   (vehiculo 
      (id 10) (marca Alfa_Romeo) (modelo Giulia) (ano 2020)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 280) (consumo 7.0) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 42000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 11) (marca Tesla) (modelo Model_S) (ano 2021)
      (tipo sedan) (tipoCombustible electrico) (transmision automatica)
      (traccion integral) (potencia 670) (consumo 0.0) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 4) (asientosIsofix 3)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 85000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 5)
   )
   
   (vehiculo 
      (id 12) (marca Porsche) (modelo Panamera) (ano 2019)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 330) (consumo 8.0) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 78000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 13) (marca Audi) (modelo A6) (ano 2015)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion integral) (potencia 265) (consumo 7.0) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 40000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 14) (marca BMW) (modelo Serie_5) (ano 2016)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 320) (consumo 7.5) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 45000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 15) (marca Mercedes_Benz) (modelo Clase_E) (ano 2018)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 300) (consumo 7.0) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 50000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 5)
   )
   
   (vehiculo 
      (id 16) (marca Lexus) (modelo LS) (ano 2013)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion delantera) (potencia 306) (consumo 8.0) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 4) (asientosIsofix 3)
      (nivelTecnologico 4) (asistenciaConduccion FALSE) (conectividad TRUE)
      (precio 55000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 4) (garantia 5)
   )
   
   (vehiculo 
      (id 17) (marca Maserati) (modelo Ghibli) (ano 2020)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 350) (consumo 9.0) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 60000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 18) (marca Bentley) (modelo Flying_Spur) (ano 2022)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 626) (consumo 10.0) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 4) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 240000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 5)
   )
   
   (vehiculo 
      (id 19) (marca Aston_Martin) (modelo Rapide) (ano 2019)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 450) (consumo 11.0) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 150000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 20) (marca Rolls_Royce) (modelo Ghost) (ano 2020)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 563) (consumo 12.0) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 300000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 5)
   )
   
   (vehiculo 
      (id 21) (marca Porsche) (modelo Taycan) (ano 2022)
      (tipo sedan) (tipoCombustible electrico) (transmision automatica)
      (traccion integral) (potencia 750) (consumo 0.0) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 105000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 22) (marca Audi) (modelo A8) (ano 2021)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion integral) (potencia 420) (consumo 8.5) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 3)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 65000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 5)
   )
   
   (vehiculo 
      (id 23) (marca BMW) (modelo Serie_7) (ano 2023)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 530) (consumo 9.0) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 4) (asientosIsofix 3)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 75000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 24) (marca Mercedes_Benz) (modelo S_Class) (ano 2024)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 550) (consumo 9.5) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 4) (asientosIsofix 3)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 80000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 5)
   )
   
   (vehiculo 
      (id 25) (marca Jaguar) (modelo XJ) (ano 2015)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 380) (consumo 8.0) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 4) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 48000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 4) (garantia 4)
   )
   
   (vehiculo 
      (id 26) (marca Maserati) (modelo Quattroporte) (ano 2017)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 404) (consumo 9.0) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 4) (asientosIsofix 3)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 52000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 27) (marca Lexus) (modelo IS) (ano 2014)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion delantera) (potencia 200) (consumo 6.5) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 4) (asistenciaConduccion FALSE) (conectividad TRUE)
      (precio 35000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 4) (garantia 4)
   )
   
   (vehiculo 
      (id 28) (marca Infiniti) (modelo Q70) (ano 2018)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion trasera) (potencia 300) (consumo 7.2) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 4) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 39000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 4) (garantia 4)
   )
   
   (vehiculo 
      (id 29) (marca Volvo) (modelo S90) (ano 2020)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion integral) (potencia 310) (consumo 7.0) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 3)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 47000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 30) (marca Genesis) (modelo G80) (ano 2025)
      (tipo sedan) (tipoCombustible hibrido) (transmision automatica)
      (traccion delantera) (potencia 290) (consumo 6.7) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 40000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   ;; Segmento Familiar
   (vehiculo 
      (id 5) (marca Toyota) (modelo Camry) (ano 2017)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion delantera) (potencia 178) (consumo 7.1) (seguridad 4)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 3)
      (nivelTecnologico 4) (asistenciaConduccion FALSE) (conectividad TRUE)
      (precio 22000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento FALSE) (calificacionVentas 4) (garantia 5)
   )
   
   ;; SUV Medianos
   (vehiculo 
      (id 8) (marca Mazda) (modelo CX-5) (ano 2017)
      (tipo suv) (tipoCombustible gasolina) (transmision automatica)
      (traccion 4x4) (potencia 187) (consumo 6.8) (seguridad 4)
      (espacioPasajeros 5) (espacioMaletero 4) (asientosIsofix 3)
      (nivelTecnologico 4) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 27000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 3)
   )
   
   ;; Vehículos Pequeños/Económicos
   (vehiculo 
      (id 11) (marca Toyota) (modelo Corolla) (ano 2019)
      (tipo compacto) (tipoCombustible gasolina) (transmision manual)
      (traccion delantera) (potencia 132) (consumo 5.7) (seguridad 4)
      (espacioPasajeros 4) (espacioMaletero 2) (asientosIsofix 2)
      (nivelTecnologico 3) (asistenciaConduccion FALSE) (conectividad TRUE)
      (precio 18000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento FALSE) (calificacionVentas 4) (garantia 3)
   )
   
   ;; Vehículos Eléctricos/Híbridos
   (vehiculo 
      (id 16) (marca Toyota) (modelo Prius) (ano 2016)
      (tipo hatchback) (tipoCombustible hibrido) (transmision automatica)
      (traccion delantera) (potencia 121) (consumo 3.7) (seguridad 4)
      (espacioPasajeros 4) (espacioMaletero 2) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 25000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento FALSE) (calificacionVentas 4) (garantia 5)
   )
   
   ;; Vehículos Nuevos (2024-2025)
   (vehiculo 
      (id 101) (marca Mercedes_Benz) (modelo EQS_Sedan) (ano 2025)
      (tipo sedan) (tipoCombustible electrico) (transmision automatica)
      (traccion trasera) (potencia 536) (consumo 16.0) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 120000.0) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 111) (marca Toyota) (modelo Camry_Hybrid) (ano 2025)
      (tipo sedan) (tipoCombustible hibrido) (transmision automatica)
      (traccion delantera) (potencia 225) (consumo 4.3) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 3)
      (nivelTecnologico 4) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 35000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 5)
   )
)

;; ==================== REGLAS DE FILTRADO INICIAL ====================
;; Se elimina el uso de "if" en el test, por lo que si se requiere evaluar según el tipo (usado/nuevo)
;; se recomienda dividir esta regla en dos (ejemplo de reglas separadas mostradas en documentación avanzada).
(defrule filtrar-vehiculos
   ?u <- (usuario (presupuesto ?presupuesto) 
                  (buscaUsado ?usado)
                  (vehiculosVistos $?vistos))
   ?v <- (vehiculo (id ?id) 
                   (precio ?precio) 
                   (seguridad ?seg) 
                   (disponible ?disp)
                   (ano ?ano))
   (test (and (eq ?disp TRUE)
              (>= ?seg 4)
              (<= ?precio ?presupuesto)
              (or (and (eq ?usado TRUE) (<= ?ano (- 2024 3)))
                  (and (neq ?usado TRUE) TRUE))))
   =>
   (assert (vehiculo-filtrado (id ?id) (puntuacion 0.0)))
)

;; ==================== REGLAS DE EVALUACIÓN ====================
;; 1. Estilo de Personalidad
(defrule evaluar-estilo-aventurero
   (usuario (estiloPersonalidad aventurero))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tipo ?tipo))
   (not (estilo-aventurero-aplicado ?id))
   (test (or (eq ?tipo suv) (eq ?tipo 4x4)))
   =>
   (modify ?vf (puntuacion (+ ?punt 8.0)))
   (assert (estilo-aventurero-aplicado ?id))
)

(defrule evaluar-estilo-practico
   (usuario (estiloPersonalidad practico))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tipo ?tipo))
   (not (estilo-practico-aplicado ?id)) ; Evita reactivación
   (test (or (eq ?tipo hatchback) (eq ?tipo compacto)))
   =>
   (modify ?vf (puntuacion (+ ?punt 7.0)))
   (assert (estilo-practico-aplicado ?id)) ; Marca como aplicado
)

(defrule evaluar-estilo-sofisticado
   (usuario (estiloPersonalidad sofisticado))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (marca ?marca) (nivelTecnologico ?tec))
   (not (estilo-sofisticado-aplicado ?id))
   (test (and (or (eq ?marca Audi) 
                  (eq ?marca Mercedes_Benz) 
                  (eq ?marca BMW))
              (>= ?tec 4)))
   =>
   (modify ?vf (puntuacion (+ ?punt 9.0)))
   (assert (estilo-sofisticado-aplicado ?id))
)

;; 2. Demográficos
(defrule evaluar-demograficos-joven
   (usuario (edad ?e&:(< ?e 25)))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (nivelTecnologico ?tec) (conectividad ?conec))
   (not (demografico-joven-aplicado ?id))
   (test (and (>= ?tec 4) (eq ?conec TRUE)))
   =>
   (modify ?vf (puntuacion (+ ?punt 3.0)))
   (assert (demografico-joven-aplicado ?id))
)

(defrule evaluar-demograficos-mayor
   (usuario (edad ?e&:(>= ?e 60)))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (asistenciaConduccion ?asis))
   (not (demografico-mayor-aplicado ?id))
   (test (eq ?asis TRUE))
   =>
   (modify ?vf (puntuacion (+ ?punt 4.0)))
   (assert (demografico-mayor-aplicado ?id))
)

(defrule evaluar-demograficos-ingresos-bajos
   (usuario (ingresos ?i&:(< ?i 30000)))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (precio ?precio))
   ?u <- (usuario (presupuesto ?presup))
   (not (demografico-bajo-aplicado ?id))
   (test (< ?precio (* ?presup 0.8)))
   =>
   (modify ?vf (puntuacion (+ ?punt 2.0)))
   (assert (demografico-bajo-aplicado ?id))
)

(defrule evaluar-demograficos-ingresos-altos
   (usuario (ingresos ?i&:(> ?i 100000)))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (marca ?marca))
   (not (demografico-alto-aplicado ?id))
   (test (or (eq ?marca Audi) 
             (eq ?marca Mercedes_Benz) 
             (eq ?marca BMW)))
   =>
   (modify ?vf (puntuacion (+ ?punt 3.0)))
   (assert (demografico-alto-aplicado ?id))
)

;; 3. Estilo de Vida
(defrule evaluar-familia-con-hijos
   (usuario (tieneHijos TRUE) (cantidadHijos ?hijos))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (asientosIsofix ?isofix) (espacioPasajeros ?espacio))
   (not (familia-con-hijos-aplicada ?id))
   (test (and (>= ?isofix ?hijos) (>= ?espacio 4)))
   =>
   (modify ?vf (puntuacion (+ ?punt 5.0)))
   (assert (familia-con-hijos-aplicada ?id))
)

(defrule evaluar-familia-numerosa
   (usuario (tieneHijos TRUE) (cantidadHijos ?hijos&:(> ?hijos 2)))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tipo minivan))
   (not (familia-numerosa-aplicada ?id))
   =>
   (modify ?vf (puntuacion (+ ?punt 3.0)))
   (assert (familia-numerosa-aplicada ?id))
)

(defrule evaluar-mascotas-grandes
   (usuario (tieneMascotas TRUE) (tipoMascota grande))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (espacioMaletero ?maletero))
   (not (mascotas-grandes-aplicada ?id))
   (test (>= ?maletero 4))
   =>
   (modify ?vf (puntuacion (+ ?punt 3.0)))
   (assert (mascotas-grandes-aplicada ?id))
)

(defrule evaluar-uso-urbano
   (usuario (usoPrincipal urbano))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tipo ?tipo))
   (not (uso-urbano-aplicado ?id))
   (test (or (eq ?tipo compacto) (eq ?tipo hatchback)))
   =>
   (modify ?vf (puntuacion (+ ?punt 4.0)))
   (assert (uso-urbano-aplicado ?id))
)

(defrule evaluar-uso-carretera
   (usuario (usoPrincipal carretera))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (consumo ?consumo) (seguridad ?seg))
   (not (uso-carretera-aplicado ?id))
   (test (and (< ?consumo 6.0) (>= ?seg 4)))
   =>
   (modify ?vf (puntuacion (+ ?punt 5.0)))
   (assert (uso-carretera-aplicado ?id))
)

;; 4. Preferencias específicas
(defrule evaluar-preferencia-marca
   (usuario (preferenciaMarca ?marca))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (marca ?marca))
   (not (preferencia-marca-aplicada ?id))
   =>
   (modify ?vf (puntuacion (+ ?punt 10.0)))
   (assert (preferencia-marca-aplicada ?id))
)

(defrule evaluar-evitar-marca
   (usuario (evitarMarca ?marca))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (marca ?marca))
   (not (evitar-marca-aplicada ?id))
   =>
   (modify ?vf (puntuacion (- ?punt 10.0)))
   (assert (evitar-marca-aplicada ?id))
)

(defrule evaluar-combustible-preferido
   (usuario (tipoCombustiblePreferido ?combustible))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tipoCombustible ?combustible))
   (not (combustible-preferido-aplicado ?id))
   =>
   (modify ?vf (puntuacion (+ ?punt 5.0)))
   (assert (combustible-preferido-aplicado ?id))
)

(defrule evaluar-transmision-preferida
   (usuario (transmisionPreferida ?transmision))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (transmision ?transmision))
   (not (transmision-preferida-aplicada ?id))
   =>
   (modify ?vf (puntuacion (+ ?punt 3.0)))
   (assert (transmision-preferida-aplicada ?id))
)

;; 5. Primer vehículo y financiación
(defrule evaluar-primer-vehiculo
   (usuario (esPrimerVehiculo TRUE))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tieneBonoPrimerAuto TRUE))
   (not (primer-vehiculo-aplicado ?id))
   =>
   (modify ?vf (puntuacion (+ ?punt 5.0)))
   (assert (primer-vehiculo-aplicado ?id))
)

(defrule evaluar-necesita-financiacion
   (usuario (necesitaFinanciacion TRUE))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (planFinanciamiento TRUE))
   (not (necesita-financiacion-aplicado ?id))
   =>
   (modify ?vf (puntuacion (+ ?punt 4.0)))
   (assert (necesita-financiacion-aplicado ?id))
)

;; ==================== REGLAS FINALES ====================
(defrule generar-recomendaciones
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt&:(> ?punt 0)))
   ?v <- (vehiculo (id ?id) (marca ?marca) (modelo ?modelo))
   =>
   (assert (recomendacion 
      (id-vehiculo ?id) 
      (puntuacion ?punt)
      (motivo (str-cat "Modelo " ?marca " " ?modelo " con puntuación " (format nil "%.1f" ?punt)))
   ))
)



;; ==================== INICIALIZACIÓN DEL SISTEMA ====================
(deffacts datos-iniciales
   (usuario 
      (edad 35)
      (genero masculino)
      (ingresos 45000.0)
      (ocupacion profesional)
      (ubicacion urbano)
      (estiloPersonalidad practico)
      (presupuesto 30000.0)
      (usoPrincipal urbano)
      (esPrimerVehiculo FALSE)
      (necesitaFinanciacion TRUE)
      (buscaUsado FALSE)
      (tieneHijos TRUE)
      (cantidadHijos 2)
      (tieneMascotas TRUE)
      (tipoMascota grande)
      (preferenciaMarca Toyota)
      (evitarMarca NINGUNA)
      (tipoCombustiblePreferido hibrido)
      (transmisionPreferida automatica)
      (historialConduccion 4)
      (rechazosConsecutivos 0)
      (vehiculosVistos)
   )
)

(defrule mostrar-recomendaciones
   (declare (salience -10)) ; Baja prioridad para ejecutarse al final
   ?r <- (recomendacion (id-vehiculo ?id) (puntuacion ?punt) (motivo ?motivo))
   =>
   (printout t "Recomendación: " ?motivo crlf)
   (retract ?r)
)

(defrule iniciar-sistema
   (initial-fact)
   =>
   (printout t "===== SISTEMA DE RECOMENDACIÓN DE AUTOS =====" crlf)
   (printout t "Cargando datos del usuario y vehiculos..." crlf crlf)
)
