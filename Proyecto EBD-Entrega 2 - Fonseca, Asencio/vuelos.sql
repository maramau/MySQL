/*
	Proyecto N°2
	Asencio - Fonseca
	Creación de tablas, vistas y usuarios para la base de datos "vuelos"
*/

#Creo la base de datos
CREATE DATABASE vuelos;

# Selecciono la base de datos sobre la cual voy a hacer modificaciones
USE vuelos;

#-----------------------------------------------------#

#CREO LAS TABLAS PARA LAS ENTIDADES

CREATE TABLE ubicaciones(
	pais VARCHAR(20) NOT NULL,
	estado VARCHAR(20) NOT NULL,
	ciudad VARCHAR(20) NOT NULL,
	huso SMALLINT NOT NULL, 
	
	CONSTRAINT pk_ubicaciones
	PRIMARY KEY(pais,estado,ciudad)
)ENGINE=InnoDB;

CREATE TABLE aeropuertos(
	codigo VARCHAR(3) NOT NULL, 
	nombre VARCHAR(80) NOT NULL,
	telefono VARCHAR(20) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	pais VARCHAR(20) NOT NULL,
	estado VARCHAR(20) NOT NULL,
	ciudad VARCHAR(20) NOT NULL,
	
	CONSTRAINT pk_aeropuertos
	PRIMARY KEY(codigo),
	
	CONSTRAINT FK_aeropuertos
	FOREIGN KEY(pais,estado,ciudad) REFERENCES ubicaciones(pais,estado,ciudad)
	ON DELETE RESTRICT ON UPDATE CASCADE
	
)ENGINE=InnoDB;

CREATE TABLE vuelos_programados(
	numero VARCHAR(10) NOT NULL,
	aeropuerto_salida VARCHAR(3) NOT NULL,
	aeropuerto_llegada VARCHAR(3) NOT NULL,
	
	CONSTRAINT pk_vuelos_programados
	PRIMARY KEY(numero),
	
	CONSTRAINT FK_vuelos_programados_salida
	FOREIGN KEY(aeropuerto_salida) REFERENCES aeropuertos(codigo)
	ON DELETE RESTRICT ON UPDATE CASCADE,
	
	CONSTRAINT FK_vuelos_programados_llegada
	FOREIGN KEY(aeropuerto_llegada) REFERENCES aeropuertos(codigo)
	ON DELETE RESTRICT ON UPDATE CASCADE
	
)ENGINE=InnoDB;

CREATE TABLE modelos_avion(
	modelo VARCHAR(20) NOT NULL,
	fabricante VARCHAR(20) NOT NULL,
	cabinas SMALLINT UNSIGNED NOT NULL,
	cant_asientos SMALLINT UNSIGNED NOT NULL,
	
	CONSTRAINT pk_modelos_avion
	PRIMARY KEY(modelo)
)ENGINE=InnoDB;

CREATE TABLE salidas(
	vuelo VARCHAR(10) NOT NULL,
	dia ENUM('Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'),
	hora_sale TIME NOT NULL,
	hora_llega TIME NOT NULL,
	modelo_avion VARCHAR(20) NOT NULL,
	
	CONSTRAINT pk_salidas
	PRIMARY KEY(vuelo, dia),
	
	CONSTRAINT FK_salidas_vuelos_programados
	FOREIGN KEY(vuelo) REFERENCES vuelos_programados(numero)
	ON DELETE RESTRICT ON UPDATE CASCADE,
	
	CONSTRAINT FK_salidas_modelos_avion
	FOREIGN KEY(modelo_avion) REFERENCES modelos_avion(modelo)
	ON DELETE RESTRICT ON UPDATE CASCADE
	
)ENGINE=InnoDB;

CREATE TABLE instancias_vuelo(
	vuelo VARCHAR(10) NOT NULL,
	fecha DATE NOT NULL,
	dia ENUM('Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa') NOT NULL,
	estado VARCHAR(20),
	
	CONSTRAINT pk_instancias_vuelo
	PRIMARY KEY(vuelo,fecha),
	
	CONSTRAINT FK_instancias_vuelo_salidas
	FOREIGN KEY(vuelo,dia) REFERENCES salidas(vuelo,dia)
	ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE clases(
	nombre VARCHAR(40) NOT NULL,
	porcentaje DECIMAL(2,2) UNSIGNED NOT NULL, 
	
	CONSTRAINT pk_clases
	PRIMARY KEY(nombre)
)ENGINE=InnoDB;

CREATE TABLE comodidades(
	codigo SMALLINT UNSIGNED NOT NULL,
	descripcion TEXT NOT NULL,
	
	CONSTRAINT pk_comodidades
	PRIMARY KEY(codigo)
)ENGINE=InnoDB;

CREATE TABLE pasajeros(
	doc_tipo VARCHAR(5) NOT NULL,
	doc_nro INT UNSIGNED NOT NULL,
	apellido VARCHAR(40) NOT NULL,
	nombre VARCHAR(40) NOT NULL,
	direccion VARCHAR(40) NOT NULL,
	telefono VARCHAR(20) NOT NULL,
	nacionalidad VARCHAR(15) NOT NULL,
	
	CONSTRAINT pk_pasajeros
	PRIMARY KEY(doc_tipo,doc_nro)
)ENGINE=InnoDB;

CREATE TABLE empleados(
	legajo INT UNSIGNED NOT NULL AUTO_INCREMENT,
	password VARCHAR(32) NOT NULL,
	doc_tipo VARCHAR(5) NOT NULL,
	doc_nro INT UNSIGNED NOT NULL,
	apellido VARCHAR(40) NOT NULL,
	nombre VARCHAR(40) NOT NULL,
	direccion VARCHAR(20) NOT NULL,
	telefono VARCHAR(20) NOT NULL,
	
	CONSTRAINT pk_empleados
	PRIMARY KEY(legajo),
	UNIQUE(doc_tipo,doc_nro)
)ENGINE=InnoDB;

CREATE TABLE reservas(
	numero INT UNSIGNED NOT NULL AUTO_INCREMENT,
	fecha DATE NOT NULL,
	vencimiento DATE NOT NULL,
	estado VARCHAR(10) NOT NULL,
	doc_tipo VARCHAR(5) NOT NULL,
	doc_nro INT UNSIGNED NOT NULL,
	legajo INT UNSIGNED NOT NULL,
	
	CONSTRAINT pk_reservas
	PRIMARY KEY(numero),
	
	CONSTRAINT FK_reservas_pasajeros
	FOREIGN KEY(doc_tipo,doc_nro) REFERENCES pasajeros(doc_tipo,doc_nro)
	ON DELETE RESTRICT ON UPDATE CASCADE,
	
	CONSTRAINT FK_reservas_empleados
	FOREIGN KEY(legajo) REFERENCES empleados(legajo)
	ON DELETE RESTRICT ON UPDATE CASCADE
	
)ENGINE=InnoDB;

#-------------------------------------------------------#

#Creo las tablas para las relaciones

CREATE TABLE brinda(
	vuelo VARCHAR(10) NOT NULL,
	dia ENUM('Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'),
	clase VARCHAR(40) NOT NULL,
	precio DECIMAL(7,2) UNSIGNED NOT NULL, 
	cant_asientos SMALLINT UNSIGNED NOT NULL,
	
	CONSTRAINT pk_brinda
	PRIMARY KEY(vuelo,dia,clase),
	
	CONSTRAINT FK_brinda_salidas
	FOREIGN KEY(vuelo,dia) REFERENCES salidas(vuelo,dia)
	ON DELETE RESTRICT ON UPDATE CASCADE,
	
	CONSTRAINT FK_brinda_clases
	FOREIGN KEY(clase) REFERENCES clases(nombre)
	ON DELETE RESTRICT ON UPDATE CASCADE
	
)ENGINE=InnoDB;

CREATE TABLE posee(
	clase VARCHAR(15) NOT NULL,
	comodidad SMALLINT UNSIGNED NOT NULL,	
	
	CONSTRAINT pk_posee
	PRIMARY KEY(clase,comodidad),
	
	CONSTRAINT FK_posee_clases
	FOREIGN KEY(clase) REFERENCES clases(nombre)
	ON DELETE RESTRICT ON UPDATE CASCADE,
	
	CONSTRAINT FK_posee_comodidades
	FOREIGN KEY(comodidad) REFERENCES comodidades(codigo)
	ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE reserva_vuelo_clase(
	numero INT UNSIGNED NOT NULL,
	vuelo VARCHAR(10) NOT NULL,
	fecha_vuelo DATE NOT NULL,
	clase VARCHAR(15) NOT NULL,
	
	CONSTRAINT pk_reserva_vuelo_clase
	PRIMARY KEY(numero,vuelo,fecha_vuelo),
	
	CONSTRAINT FK_reerva_vuelo_clase_reservas
	FOREIGN KEY(numero) REFERENCES reservas(numero)
	ON DELETE RESTRICT ON UPDATE CASCADE,
	
	CONSTRAINT FK_reserva_vuelo_clase_instancias_vuelo
	FOREIGN KEY(vuelo,fecha_vuelo) REFERENCES instancias_vuelo(vuelo,fecha)
	ON DELETE RESTRICT ON UPDATE CASCADE, 
	
	CONSTRAINT FK_reserva_vuelo_clase_clases
	FOREIGN KEY(clase) REFERENCES clases(nombre)
	ON DELETE RESTRICT ON UPDATE CASCADE
	
)ENGINE=InnoDB;

#---------------------------------------------------#

# Creo la vista
		
CREATE VIEW vuelos_disponibles AS 
   SELECT vuelo,fecha,dia,hora_sale,hora_llega,
       CASE
           WHEN hora_sale<hora_llega THEN TIMEDIFF(hora_llega,hora_sale)
           WHEN hora_sale >= hora_llega THEN ADDTIME(TIMEDIFF(hora_sale,hora_llega),'24:00:00')
       END AS tiempo_vuelo,
	   modelo_avion,codigo_origen,nombre_origen,ciudad_origen,estado_origen,pais_origen,
					codigo_destino,nombre_destino,ciudad_destino,estado_destino,pais_destino,
					clase,precio,cant_total_asientos,cant_asientos_disponibles
FROM
  (SELECT *
   FROM
     (SELECT vuelo,
             dia,
             hora_sale,
             hora_llega,
             modelo_avion,
             clase,
             precio,
             cant_asientos_disponibles,
             cant_total_asientos
      FROM salidas
      NATURAL JOIN (
                      (SELECT vuelo,
                              dia,
                              clase,
                              precio,
                              round(cant_asientos+cant_asientos*porcentaje)-cant_reservas AS cant_asientos_disponibles,
                              round(cant_asientos+cant_asientos*porcentaje) AS cant_total_asientos
                       FROM brinda
                       NATURAL JOIN
                         (SELECT *,
                                 count(*) AS cant_reservas
                          FROM reserva_vuelo_clase
                          NATURAL JOIN
                            (SELECT nombre AS clase,
                                    porcentaje
                             FROM clases) AS tabla2
                          GROUP BY vuelo,
                                   clase) tabla3)
                    UNION
                      (SELECT *
                       FROM
                         (SELECT vuelo,
                                 dia,
                                 clase,
                                 precio,
                                 round(cant_asientos+cant_asientos*porcentaje) AS cant_asientos_disponibles,
                                 round(cant_asientos+cant_asientos*porcentaje) AS cant_total_asientos
                          FROM brinda,
                               clases
                          WHERE clases.nombre=brinda.clase) otra
                       WHERE (vuelo,
                              clase) NOT IN
                           (SELECT vuelo,
                                   clase
                            FROM reserva_vuelo_clase))) tablaAux
      NATURAL JOIN
        (SELECT numero AS vuelo,
                aeropuerto_salida,
                aeropuerto_llegada
         FROM vuelos_programados) tablaAux2) auxAux
   NATURAL JOIN
     (SELECT *
      FROM
        (SELECT numero AS vuelo,
                codigo AS codigo_origen,
                nombre AS nombre_origen,
                ciudad AS ciudad_origen,
                estado AS estado_origen,
                pais AS pais_origen,
                aeropuerto_llegada AS codigo_destino
         FROM aeropuertos
         NATURAL JOIN
           (SELECT numero,
                   aeropuerto_salida AS codigo,
                   aeropuerto_llegada
            FROM vuelos_programados) tab) tab2
      NATURAL JOIN
        (SELECT codigo AS codigo_destino,
                nombre AS nombre_destino,
                ciudad AS ciudad_destino,
                estado AS estado_destino,
                pais AS pais_destino
         FROM aeropuertos) tab3) auxAux2 ) otraTabla
NATURAL JOIN
  (SELECT vuelo,
          fecha
   FROM instancias_vuelo) juroQueEsLaUltimaTabla ;
		

#----------------------------------------------------------#

#Otorgo los privilegios a los empleados

#Creo el usuario 'admin' con password 'admin'
CREATE USER admin@localhost IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON vuelos.* TO admin@localhost;

#Creo el usuario 'empleado' con password 'empleado'
CREATE USER empleado@'%' IDENTIFIED BY 'empleado';
GRANT SELECT ON vuelos.* TO empleado@'%';
GRANT INSERT, UPDATE, DELETE ON vuelos.reservas TO empleado@'%';
GRANT INSERT, UPDATE, DELETE ON vuelos.pasajeros TO empleado@'%';
GRANT INSERT, UPDATE, DELETE ON vuelos.reserva_vuelo_clase TO empleado@'%';


#Creo el usuario 'cliente' con password 'cliente'
CREATE USER cliente@'%' IDENTIFIED BY 'cliente';
GRANT SELECT ON vuelos.vuelos_disponibles TO cliente@'%';

#Elimino el usuario vacio del banco de usuarios
DROP USER IF EXISTS ''@localhost;



