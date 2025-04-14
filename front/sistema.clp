;; ==================== DEFINICIÓN DE VARIABLES GLOBALES ====================
(defglobal ?*salida* = (open "salida.txt" "w"))

;; ==================== DEFINICIÓN DE PLANTILLAS ====================
(deftemplate recomendaciones-generadas
   (slot estado (type SYMBOL)) ; yes/no


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
   (slot esPrimerVehiculo (type SYMBOL)) ; no/no
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
   (slot asistenciaConduccion (type SYMBOL)) ; TRUE/no
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
      (id 1) (marca Audi) (modelo A4) (ano 2015)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion delantera) (potencia 190) (consumo 6.5) (seguridad 5)
      (espacioPasajeros 4) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 32000.0) (disponible TRUE) (tieneBonoPrimerAuto no)
      (planFinanciamiento TRUE) (calificacionVentas 4) (garantia 3)
   )
   
   (vehiculo 
      (id 2) (marca Audi) (modelo A3) (ano 2019)
      (tipo hatchback) (tipoCombustible gasolina) (transmision automatica)
      (traccion delantera) (potencia 150) (consumo 5.8) (seguridad 5)
      (espacioPasajeros 3) (espacioMaletero 2) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 28000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento no) (calificacionVentas 5) (garantia 3)
   )
   
   ;; Segmento Familiar
   (vehiculo 
      (id 5) (marca Toyota) (modelo Camry) (ano 2017)
      (tipo sedan) (tipoCombustible gasolina) (transmision automatica)
      (traccion delantera) (potencia 178) (consumo 7.1) (seguridad 4)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 3)
      (nivelTecnologico 4) (asistenciaConduccion no) (conectividad TRUE)
      (precio 22000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento no) (calificacionVentas 4) (garantia 5)
   )
   
   ;; SUV Medianos
   (vehiculo 
      (id 8) (marca Mazda) (modelo CX-5) (ano 2017)
      (tipo suv) (tipoCombustible gasolina) (transmision automatica)
      (traccion 4x4) (potencia 187) (consumo 6.8) (seguridad 4)
      (espacioPasajeros 5) (espacioMaletero 4) (asientosIsofix 3)
      (nivelTecnologico 4) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 27000.0) (disponible TRUE) (tieneBonoPrimerAuto no)
      (planFinanciamiento TRUE) (calificacionVentas 5) (garantia 3)
   )
   
   ;; Vehículos Pequeños/Económicos
   (vehiculo 
      (id 11) (marca Toyota) (modelo Corolla) (ano 2019)
      (tipo compacto) (tipoCombustible gasolina) (transmision manual)
      (traccion delantera) (potencia 132) (consumo 5.7) (seguridad 4)
      (espacioPasajeros 4) (espacioMaletero 2) (asientosIsofix 2)
      (nivelTecnologico 3) (asistenciaConduccion no) (conectividad TRUE)
      (precio 18000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento no) (calificacionVentas 4) (garantia 3)
   )
   
   ;; Vehículos Eléctricos/Híbridos
   (vehiculo 
      (id 16) (marca Toyota) (modelo Prius) (ano 2016)
      (tipo hatchback) (tipoCombustible hibrido) (transmision automatica)
      (traccion delantera) (potencia 121) (consumo 3.7) (seguridad 4)
      (espacioPasajeros 4) (espacioMaletero 2) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 25000.0) (disponible TRUE) (tieneBonoPrimerAuto TRUE)
      (planFinanciamiento no) (calificacionVentas 4) (garantia 5)
   )
   
   ;; Vehículos Nuevos (2024-2025)
   (vehiculo 
      (id 101) (marca Mercedes_Benz) (modelo EQS_Sedan) (ano 2025)
      (tipo sedan) (tipoCombustible electrico) (transmision automatica)
      (traccion trasera) (potencia 536) (consumo 16.0) (seguridad 5)
      (espacioPasajeros 5) (espacioMaletero 3) (asientosIsofix 2)
      (nivelTecnologico 5) (asistenciaConduccion TRUE) (conectividad TRUE)
      (precio 120000.0) (disponible TRUE) (tieneBonoPrimerAuto no)
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
   (modify ?vf (puntuacion (+ ?punt 10.0)))  ;; Aumentamos la puntuación si la marca es preferida
   (assert (preferencia-marca-aplicada ?id))  ;; Marcamos esta regla como aplicada
)

(defrule evaluar-evitar-marca
   (usuario (evitarMarca ?marca))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (marca ?marca))
   (not (evitar-marca-aplicada ?id))
   =>
   (modify ?vf (puntuacion (- ?punt 10.0)))  ;; Restamos puntuación si se quiere evitar la marca
   (assert (evitar-marca-aplicada ?id))  ;; Marcamos esta regla como aplicada
)

(defrule evaluar-combustible-preferido
   (usuario (tipoCombustiblePreferido ?combustible))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tipoCombustible ?combustible))
   (not (combustible-preferido-aplicado ?id))
   =>
   (modify ?vf (puntuacion (+ ?punt 5.0)))  ;; Aumentamos la puntuación si el combustible preferido coincide
   (assert (combustible-preferido-aplicado ?id))  ;; Marcamos esta regla como aplicada
)

(defrule evaluar-transmision-preferida
   (usuario (transmisionPreferida ?transmision))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (transmision ?transmision))
   (not (transmision-preferida-aplicada ?id))
   =>
   (modify ?vf (puntuacion (+ ?punt 3.0)))  ;; Aumentamos la puntuación si la transmisión preferida coincide
   (assert (transmision-preferida-aplicada ?id))  ;; Marcamos esta regla como aplicada
)

(defrule evaluar-primer-vehiculo
   (usuario (esPrimerVehiculo TRUE))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (tieneBonoPrimerAuto TRUE))
   (not (primer-vehiculo-aplicado ?id))
   =>
   (modify ?vf (puntuacion (+ ?punt 5.0)))  ;; Aumentamos la puntuación si es el primer vehículo
   (assert (primer-vehiculo-aplicado ?id))
)

(defrule evaluar-necesita-financiacion
   (usuario (necesitaFinanciacion TRUE))
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt))
   ?v <- (vehiculo (id ?id) (planFinanciamiento TRUE))
   (not (necesita-financiacion-aplicado ?id))
   =>
   (modify ?vf (puntuacion (+ ?punt 4.0)))  ;; Aumentamos la puntuación si el usuario necesita financiación
   (assert (necesita-financiacion-aplicado ?id))
)



;; Regla para generar recomendaciones
(defrule generar-recomendaciones
   ?vf <- (vehiculo-filtrado (id ?id) (puntuacion ?punt&:(> ?punt 0)))
   ?v <- (vehiculo (id ?id) (marca ?marca) (modelo ?modelo))
   =>
   (printout t "Generando recomendación para: " ?marca " " ?modelo " con puntuación: " ?punt crlf)  ; Depuración
   (assert (recomendacion 
      (id-vehiculo ?id) 
      (puntuacion ?punt)
      (motivo (str-cat "Modelo " ?marca " " ?modelo " con puntuación " (format nil "%.1f" ?punt)))
   ))
   (assert (recomendaciones-generadas TRUE))  ; Establecemos el hecho a TRUE
   (printout t "Recomendaciones generadas: TRUE" crlf)  ; Depuración
)

;; Regla para escribir en el archivo de salida
(defrule procesar-recomendaciones
   ?r <- (recomendacion (id-vehiculo ?id) (puntuacion ?punt) (motivo ?motivo))
   =>
   (printout ?salida "Recomendación: " ?motivo crlf)  ; Escribe en el archivo de salida
)

;; Regla para cerrar el archivo de salida
(defrule cerrar-salida
   (declare (salience 100))  ; Alta prioridad para ejecutarse al final
   (recomendaciones-generadas TRUE)  ; Verifica que las recomendaciones hayan sido generadas
   =>
   (printout t "Cerrando el archivo salida.txt..." crlf)
   (close ?salida)  ; Cerrar el archivo
   (retract (recomendaciones-generadas TRUE))  ; Limpia el hecho después de cerrar
)

;; Iniciar el sistema
(defrule iniciar-sistema
   (initial-fact)
   =>
   (printout ?salida "===== SISTEMA DE RECOMENDACIÓN DE AUTOS =====" crlf)
   (printout ?salida "Cargando datos del usuario y vehículos..." crlf crlf)
)