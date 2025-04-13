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
   (slot año (type INTEGER))
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
   (vehiculo 
      (id 1) (marca Audi) (modelo A4) (año 2015)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion delantera) (potencia 190) (consumo 6.5) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 32000) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 4) (garantia 3)
   )
   
   (vehiculo 
      (id 2) (marca Audi) (modelo A3) (año 2019)
      (tipo hatchback) (tipoCombustible gasolina) (transmision automatica)
      (traccion delantera) (potencia 150) (consumo 5.8) (seguridad 5)
      (espacioPasajeros 3) (espacioMaletero 2) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 28000) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento FALSE) (calificacionVentas 5) (garantia 3)
   )
   
   ;; Segmento Familiar
   (vehiculo 
      (id 5) (marca Toyota) (modelo Camry) (año 2017)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion delantera) (potencia 178) (consumo 7.1) (seguridad 4)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 3)
      (nivelTecnologico 4) (asistenciaConduccion FALSE) (conectividad TRUE)
      (precio 22000) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento FALSE) (calificacionVentas 4) (garantia 5)
   )
   
   ;; SUV Medianos
   (vehiculo 
      (id 8) (marca Mazda) (modelo CX-5) (año 2017)
      (tipo suv) (tipoCombustible gasolina) (transmision automatica)
      (traccion 4x4) (potencia 187) (consumo 6.8) (seguridad 4)
      (espacioPasajeros 5) (espacioMaletero 4) (asientosIsofix 3)
      (nivelTecnologico 4) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 27000) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 3)
   )
   
   ;; Vehículos Pequeños/Económicos
   (vehiculo 
      (id 11) (marca Toyota) (modelo Corolla) (año 2019)
      (tipo compacto) (tipoCombustible gasolina) (transmision manual)
      (traccion delantera) (potencia 132) (consumo 5.7) (seguridad 4)
      (espacioPasajeros 4) (espacioMaletero 2) (asientosIsofix 2)
      (nivelTecnologico 3) (asistenciaConduccion FALSE) (conectividad TRUE)
      (precio 18000) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento FALSE) (calificacionVentas 4) (garantia 3)
   )
   
   ;; Vehículos Eléctricos/Híbridos
   (vehiculo 
      (id 16) (marca Toyota) (modelo Prius) (año 2016)
      (tipo hatchback) (tipoCombustible hibrido) (transmision automatica)
      (traccion delantera) (potencia 121) (consumo 3.7) (seguridad 4)
      (espacioPasajeros 4) (espacioMaletero 2) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 25000) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento FALSE) (calificacionVentas 4) (garantia 5)
   )
   
   ;; Vehículos Nuevos (2024-2025)
   (vehiculo 
      (id 101) (marca Mercedes-Benz) (modelo EQS-Sedan) (año 2025)
      (tipo sedan) (tipoCombustible electrico) (transmision automatica)
      (traccion trasera) (potencia 536) (consumo 16.0) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 120000) (disponible TRUE) (tieneBonoPrimerAuto FALSE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 4)
   )
   
   (vehiculo 
      (id 111) (marca Toyota) (modelo Camry-Hybrid) (año 2025)
      (tipo sedan) (tipoCombustible hibrido) (transmision automatica)
      (traccion delantera) (potencia 225) (consumo 4.3) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 3)
      (nivelTecnologico 4) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 35000) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 5)
   )
)

;; ==================== REGLAS DE FILTRADO INICIAL ====================
(defrule filtrar-vehiculos
   ?u <- (usuario (presupuesto ?presupuesto) 
                  (buscaUsado ?usado)
                  (vehiculosVistos $?vistos))
   
   ?v <- (vehiculo (id ?id) 
                   (precio ?precio) 
                   (seguridad ?seg) 
                   (disponible ?disp)
                   (año ?año))
   
   (test (and (eq ?disp TRUE)
              (>= ?seg 4)
              (<= ?precio ?presupuesto)
              (if (eq ?usado TRUE)
                  then (<= ?año (- 2024 3))  ; Asumiendo año actual 2024
                  else TRUE)))
   
   =>
   (assert (vehiculo-filtrado (id ?id) (puntuacion 0.0)))
)

;; ==================== REGLAS DE EVALUACIÓN ====================
;; 1. Estilo de Personalidad
(defrule evaluar-estilo-aventurero
   (usuario (estiloPersonalidad aventurero))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tipo ?tipo))
   
   (test (or (eq ?tipo suv) (eq ?tipo 4x4)))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 8.0)))
)

(defrule evaluar-estilo-practico
   (usuario (estiloPersonalidad practico))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tipo ?tipo))
   
   (test (or (eq ?tipo hatchback) (eq ?tipo compacto)))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 7.0)))
)

(defrule evaluar-estilo-sofisticado
   (usuario (estiloPersonalidad sofisticado))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (marca ?marca) (nivelTecnologico ?tec))
   
   (test (and (or (eq ?marca Audi) (eq ?marca Mercedes-Benz) (eq ?marca BMW))
              (>= ?tec 4)))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 9.0)))
)

;; 2. Demográficos
(defrule evaluar-demograficos-joven
   (usuario (edad ?e&:(< ?e 25)))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (nivelTecnologico ?tec) 
                   (conectividad ?conec))
   
   (test (and (>= ?tec 4) (eq ?conec TRUE)))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 3.0)))
)

(defrule evaluar-demograficos-mayor
   (usuario (edad ?e&:(>= ?e 60)))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (asistenciaConduccion ?asis))
   
   (test (eq ?asis TRUE))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 4.0)))
)

(defrule evaluar-demograficos-ingresos-bajos
   (usuario (ingresos ?i&:(< ?i 30000)))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (precio ?precio))
   ?u <- (usuario (presupuesto ?presup))
   
   (test (< ?precio (* ?presup 0.8)))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 2.0)))
)

(defrule evaluar-demograficos-ingresos-altos
   (usuario (ingresos ?i&:(> ?i 100000)))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (marca ?marca))
   
   (test (or (eq ?marca Audi) (eq ?marca Mercedes-Benz) (eq ?marca BMW)))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 3.0)))
)

;; 3. Estilo de Vida
(defrule evaluar-familia-con-hijos
   (usuario (tieneHijos TRUE) (cantidadHijos ?hijos))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (asientosIsofix ?isofix) 
                   (espacioPasajeros ?espacio))
   
   (test (and (>= ?isofix ?hijos) (>= ?espacio 4)))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 5.0)))
)

(defrule evaluar-familia-numerosa
   (usuario (tieneHijos TRUE) (cantidadHijos ?hijos&:(> ?hijos 2)))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tipo minivan))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 3.0)))
)

(defrule evaluar-mascotas-grandes
   (usuario (tieneMascotas TRUE) (tipoMascota grande))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (espacioMaletero ?maletero))
   
   (test (>= ?maletero 4))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 3.0)))
)

(defrule evaluar-uso-urbano
   (usuario (usoPrincipal urbano))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tipo ?tipo))
   
   (test (or (eq ?tipo compacto) (eq ?tipo hatchback)))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 4.0)))
)

(defrule evaluar-uso-carretera
   (usuario (usoPrincipal carretera))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (consumo ?consumo) (seguridad ?seg))
   
   (test (and (< ?consumo 6.0) (>= ?seg 4)))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 5.0)))
)

;; 4. Preferencias específicas
(defrule evaluar-preferencia-marca
   (usuario (preferenciaMarca ?marca))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (marca ?marca))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 10.0)))
)

(defrule evaluar-evitar-marca
   (usuario (evitarMarca ?marca))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (marca ?marca))
   
   =>
   (modify ?vf (puntuacion (- ?punt 10.0)))
)

(defrule evaluar-combustible-preferido
   (usuario (tipoCombustiblePreferido ?combustible))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tipoCombustible ?combustible))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 5.0)))
)

(defrule evaluar-transmision-preferida
   (usuario (transmisionPreferida ?transmision))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (transmision ?transmision))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 3.0)))
)

;; 5. Primer vehículo y financiación
(defrule evaluar-primer-vehiculo
   (usuario (esPrimerVehiculo TRUE))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tieneBonoPrimerAuto TRUE))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 5.0)))
)

(defrule evaluar-necesita-financiacion
   (usuario (necesitaFinanciacion TRUE))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (planFinanciamiento TRUE))
   
   =>
   (modify ?vf (puntuacion (+ ?punt 4.0)))
)

;; ==================== REGLAS FINALES ====================
(defrule generar-recomendaciones
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt&:(> ?punt 0)))
   ?v <- (vehiculo (id ?id) (marca ?marca) (modelo ?modelo))
   
   =>
   (assert (recomendacion 
      (id-vehiculo ?id) 
      (puntuacion ?punt)
      (motivo (str-cat "Modelo " ?marca " " ?modelo " con puntuación " ?punt))
   ))
)

(defrule mostrar-recomendaciones
   (declare (salience -10))
   ?u <- (usuario)
   =>
   (bind ?recoms (find-all-facts ((?r recomendacion)) TRUE))
   (if (> (length ?recoms) 0)
      then
      (printout t crlf "=== RECOMENDACIONES FINALES ===" crlf)
      (printout t "Perfil del usuario:" crlf)
      (printout t "Edad: " (fact-slot-value ?u edad) crlf)
      (printout t "Presupuesto: $" (fact-slot-value ?u presupuesto) crlf)
      (printout t "Uso principal: " (fact-slot-value ?u usoPrincipal) crlf crlf)
      
      (printout t "Vehículos recomendados:" crlf)
      (foreach ?r ?recoms
         (bind ?vid (fact-slot-value ?r id-vehiculo))
         (bind ?v (find-fact ((?v vehiculo)) (eq ?v:id ?vid)))
         (printout t 
            "ID: " ?vid " | " 
            (fact-slot-value ?v marca) " " (fact-slot-value ?v modelo) " | "
            "Puntuación: " (fact-slot-value ?r puntuacion) " | "
            "Precio: $" (fact-slot-value ?v precio) " | "
            "Tipo: " (fact-slot-value ?v tipo) crlf
         )
      )
      else
      (printout t "No se encontraron vehículos adecuados para tu perfil" crlf)
   )
)

;; ==================== INICIALIZACIÓN DEL SISTEMA ====================
(deffacts datos-iniciales
   (usuario 
      (edad 35)
      (genero masculino)
      (ingresos 45000)
      (ocupacion profesional)
      (ubicacion urbano)
      (estiloPersonalidad practico)
      (presupuesto 30000)
      (usoPrincipal ciudad)
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

(defrule iniciar-sistema
   (initial-fact)
   =>
   (printout t "===== SISTEMA DE RECOMENDACIÓN DE AUTOS =====" crlf)
   (printout t "Cargando datos del usuario y vehículos..." crlf crlf)
)

;; ==================== EJECUCIÓN ====================
(reset)
(run)