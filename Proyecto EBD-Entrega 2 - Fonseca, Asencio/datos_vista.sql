# Carga de datos de la BD vuelos

USE vuelos;

DELETE FROM  reserva_vuelo_clase;
DELETE FROM  reservas;
DELETE FROM  posee;
DELETE FROM  brinda;
DELETE FROM  pasajeros;
DELETE FROM  empleados;
DELETE FROM  comodidades;
DELETE FROM  clases;
DELETE FROM  instancias_vuelo; 
DELETE FROM  salidas;
DELETE FROM  vuelos_programados;
DELETE FROM  modelos_avion;
DELETE FROM  aeropuertos;
DELETE FROM  ubicaciones;

DELIMITER !
 
 CREATE FUNCTION dia(fecha DATE) RETURNS CHAR(2)
 BEGIN
   DECLARE i INT;   
   SELECT DAYOFWEEK(fecha) INTO i;
   CASE i
		WHEN 1 THEN RETURN 'Do';
		WHEN 2 THEN RETURN 'Lu';
		WHEN 3 THEN RETURN 'Ma';
		WHEN 4 THEN RETURN 'Mi';
		WHEN 5 THEN RETURN 'Ju';
		WHEN 6 THEN RETURN 'Vi';
		WHEN 7 THEN RETURN 'Sa';
	END CASE; 	
 END; !
 
 DELIMITER ;


#---------------------------------------------------------------------------------------------------------------------------
# UBICACIONES
	
	INSERT INTO ubicaciones(pais,estado,ciudad,huso)
	VALUES ('Argentina', 'Buenos Aires', 'Buenos Aires', 0);
	INSERT INTO ubicaciones(pais,estado,ciudad,huso) 
	VALUES ('Argentina', 'Cordoba', 'Cordoba', 0);
	INSERT INTO ubicaciones(pais,estado,ciudad,huso)
	VALUES ('Argentina', 'Buenos Aires', 'Ezeiza', 0);
 	INSERT INTO ubicaciones(pais,estado,ciudad,huso) 
	VALUES ('Argentina', 'Buenos Aires', 'Mar del Plata', 0);
	INSERT INTO ubicaciones(pais,estado,ciudad,huso)
	VALUES ('Argentina', 'Mendoza', 'Mendoza', 0);
	
#---------------------------------------------------------------------------------------------------------------------------
# AEROPUERTOS


INSERT INTO aeropuertos(codigo,nombre,telefono,direccion,pais,estado,ciudad)
 VALUES ('AEP', 'Aeroparque Jorge Newbery', '(54)45765300', 'direaep', 'Argentina', 'Buenos Aires', 'Buenos Aires');
INSERT INTO aeropuertos(codigo,nombre,telefono,direccion,pais,estado,ciudad)
 VALUES ('COR', 'Ing.Aer.A.L.V. Taravella', '(54)03514750874', 'direcor', 'Argentina', 'Cordoba', 'Cordoba');
INSERT INTO aeropuertos(codigo,nombre,telefono,direccion,pais,estado,ciudad)
 VALUES ('EZE', 'Ministro Pistarini', '(54)44802514', 'direeze', 'Argentina', 'Buenos Aires', 'Ezeiza');
INSERT INTO aeropuertos(codigo,nombre,telefono,direccion,pais,estado,ciudad)
 VALUES ('MDQ', 'Brig. Gral. Bartolom� de Colina', '(54)02234785811', 'diremdq', 'Argentina', 'Buenos Aires', 'Mar del Plata');
INSERT INTO aeropuertos(codigo,nombre,telefono,direccion,pais,estado,ciudad) 
VALUES ('MDZ', 'Gdor. Francisco Gabrielli', '(54)02614480017', 'diremdz', 'Argentina', 'Mendoza', 'Mendoza');


#---------------------------------------------------------------------------------------------------------------------------
# VUELOS_PROGRAMADOS
    # dos vuelos de Buenos aires a Cordoba
	INSERT INTO vuelos_programados(numero, aeropuerto_salida, aeropuerto_llegada)
	VALUES ('BC1', 'AEP', 'COR');

	INSERT INTO vuelos_programados(numero, aeropuerto_salida, aeropuerto_llegada)
	VALUES ('BC3', 'AEP', 'COR');
	
	# dos vuelos de Cordoba a Buenos Aires
	INSERT INTO vuelos_programados(numero, aeropuerto_salida, aeropuerto_llegada)
	VALUES ('CB2', 'COR', 'AEP');
	    
	# un vuelo de Buenos aires a Mar del Plata
	INSERT INTO vuelos_programados(numero, aeropuerto_salida, aeropuerto_llegada)
	VALUES ('BM', 'AEP', 'MDQ');

	# un vuelo de  Mar del Plata a Buenos aires
	INSERT INTO vuelos_programados(numero, aeropuerto_salida, aeropuerto_llegada)
	VALUES ('MB', 'MDQ', 'AEP');
	
		
#---------------------------------------------------------------------------------------------------------------------------
# MODELOS_AVION

	INSERT INTO modelos_avion(modelo, fabricante, cabinas, cant_asientos)
	VALUES ('B-737', 'Boeing', 2, 60);
	INSERT INTO modelos_avion(modelo, fabricante,cabinas, cant_asientos) 
	VALUES ('B-747', 'Boeing', 2, 90);
	INSERT INTO modelos_avion(modelo, fabricante,cabinas, cant_asientos) 
	VALUES ('B-757', 'Boeing', 2, 120);
	INSERT INTO modelos_avion(modelo, fabricante,cabinas, cant_asientos) 
	VALUES ('B-767', 'Boeing', 2, 150);

#---------------------------------------------------------------------------------------------------------------------------
# SALIDAS

    INSERT INTO salidas(vuelo, dia, hora_sale, hora_llega, modelo_avion) 
    VALUES ('BC1', dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02')), '08:00:00', '09:00:00', 'B-737');
	
    INSERT INTO salidas(vuelo, dia, hora_sale, hora_llega, modelo_avion) 
    VALUES ('CB2', dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-05')), '17:00:00', '18:10:00', 'B-737');

    INSERT INTO salidas(vuelo, dia, hora_sale, hora_llega, modelo_avion) 
    VALUES ('BC3', dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-03')), '08:00:00', '09:00:00', 'B-737');

#---------------------------------------------------------------------------------------------------------------------------
# INSTACIAS_VUELO

# '2013 -> CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'
# dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02'))


	INSERT INTO instancias_vuelo( vuelo, fecha, dia, estado) 
	VALUES ('BC1', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02'), dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02')), 'a tiempo');
	
	INSERT INTO instancias_vuelo( vuelo, fecha, dia, estado) 
	VALUES ('CB2', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-05'), dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-05')), 'demorado');

	INSERT INTO instancias_vuelo( vuelo, fecha, dia, estado) 
	VALUES ('BC3', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-03'), dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-03')), 'a tiempo');
	
	
	
#---------------------------------------------------------------------------------------------------------------------------
# CLASES

	INSERT INTO clases(nombre, porcentaje) VALUES ('Turista', 0.67);
	INSERT INTO clases(nombre, porcentaje) VALUES ('Ejecutiva', 0.5);
	INSERT INTO clases(nombre, porcentaje) VALUES ('Primera', 0.34);

#---------------------------------------------------------------------------------------------------------------------------
# COMODIDADES

	INSERT INTO comodidades(codigo,descripcion) VALUES (1, 'Asientos grandes');
	INSERT INTO comodidades(codigo,descripcion) VALUES (2, 'Comida rica');
	INSERT INTO comodidades(codigo,descripcion) VALUES (3, 'Azafata amable');
	INSERT INTO comodidades(codigo,descripcion) VALUES (4, 'Internet');

#---------------------------------------------------------------------------------------------------------------------------
# PASAJEROS

	INSERT INTO pasajeros(doc_tipo, doc_nro, nombre, apellido, direccion, telefono, nacionalidad) 
	VALUES ('DNI', 1, 'Julieta', 'Marcos', 'Roca 850', '02932 424565', 'Argentina');
	INSERT INTO pasajeros(doc_tipo, doc_nro, nombre, apellido, direccion, telefono, nacionalidad)
	VALUES ('DNI', 2, 'Luciano', 'Tamargo', 'Alem 222', '0291 45222', 'Argentino');
	INSERT INTO pasajeros(doc_tipo, doc_nro, nombre, apellido, direccion, telefono, nacionalidad)
	VALUES ('DNI', 3, 'Diego', 'Garcia', '12 de Octubre 333', '0291 45333', 'Argentino');
	INSERT INTO pasajeros(doc_tipo, doc_nro, nombre, apellido, direccion, telefono, nacionalidad)
	VALUES ('DNI', 4, 'Juan', 'Perez', 'Belgrano 14', '0291 4556733', 'Argentino');
	INSERT INTO pasajeros(doc_tipo, doc_nro, nombre, apellido, direccion, telefono, nacionalidad)
	VALUES ('DNI', 5, 'Julian', 'Gomez', 'Donado 533', '0291 4543563', 'Argentino');
	

#---------------------------------------------------------------------------------------------------------------------------
# EMPLEADOS
    
	INSERT INTO empleados(legajo, password, doc_tipo, doc_nro, nombre, apellido, direccion, telefono) 
	VALUES (101,MD5('emp101'),'DNI', 101, 'Nombre_Emp101', 'Apellido_Emp101', 'Dir_Emp101' , '0291-4540101');
	INSERT INTO empleados(legajo, password, doc_tipo, doc_nro, nombre, apellido, direccion, telefono) 
	VALUES (102,MD5('emp102'),'DNI', 102, 'Nombre_Emp102', 'Apellido_Emp102', 'Dir_Emp102' , '0291-4540102');
	INSERT INTO empleados(legajo, password, doc_tipo, doc_nro, nombre, apellido, direccion, telefono) 
	VALUES (103,MD5('emp103'),'DNI', 103, 'Nombre_Emp103', 'Apellido_Emp103', 'Dir_Emp103' , '0291-4540103');
	INSERT INTO empleados(legajo, password, doc_tipo, doc_nro, nombre, apellido, direccion, telefono) 
	VALUES (104,MD5('emp104'),'DNI', 104, 'Nombre_Emp104', 'Apellido_Emp104', 'Dir_Emp104' , '0291-4540104');
	INSERT INTO empleados(legajo, password, doc_tipo, doc_nro, nombre, apellido, direccion, telefono) 
	VALUES (105,MD5('emp105'),'DNI', 105, 'Nombre_Emp105', 'Apellido_Emp105', 'Dir_Emp105' , '0291-4540105');
	

#---------------------------------------------------------------------------------------------------------------------------
# BRINDA

	INSERT INTO brinda(vuelo, dia, clase, precio, cant_asientos) 
	VALUES ('BC1', dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02')), 'Turista',  100.00, 3);	
	INSERT INTO brinda(vuelo, dia, clase, precio, cant_asientos) 
	VALUES ('BC1', dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02')), 'Primera',  200.00, 3);	
	INSERT INTO brinda(vuelo, dia, clase, precio, cant_asientos) 
	VALUES ('BC1', dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02')), 'Ejecutiva', 300.00, 2);	

	INSERT INTO brinda(vuelo, dia, clase, precio, cant_asientos)
	VALUES ('CB2', dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-05')), 'Turista',  100.00, 3);	
	INSERT INTO brinda(vuelo, dia, clase, precio, cant_asientos)
	VALUES ('CB2', dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-05')), 'Primera',  200.00, 3);	

	
	INSERT INTO brinda(vuelo, dia, clase, precio, cant_asientos) 
	VALUES ('BC3', dia(CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-03')), 'Ejecutiva', 300.00, 10);	
	
	
	

#---------------------------------------------------------------------------------------------------------------------------
# POSEE

	INSERT INTO posee(clase, comodidad) VALUES ('Turista', 3);
	
	INSERT INTO posee(clase, comodidad) VALUES ('Ejecutiva', 3);
	INSERT INTO posee(clase, comodidad) VALUES ('Ejecutiva', 4);	
	
	INSERT INTO posee(clase, comodidad) VALUES ('Primera', 1);
	INSERT INTO posee(clase, comodidad) VALUES ('Primera', 2);
	INSERT INTO posee(clase, comodidad) VALUES ('Primera', 3);
	INSERT INTO posee(clase, comodidad) VALUES ('Primera', 4);
	
#---------------------------------------------------------------------------------------------------------------------------
# RESERVAS

# '2012 -> CONCAT(YEAR(NOW()),'

        # reservas de BC1
	INSERT INTO reservas(numero, doc_tipo, doc_nro, legajo, fecha, vencimiento, estado) 
        VALUES (1, 'DNI', 1, 101, CONCAT(YEAR(NOW()),'-10-01'), CONCAT(YEAR(NOW()),'-12-01'), 'Confirmada');
	INSERT INTO reservas(numero, doc_tipo, doc_nro, legajo, fecha, vencimiento, estado) 
        VALUES (2, 'DNI', 2, 102, CONCAT(YEAR(NOW()),'-10-01'), CONCAT(YEAR(NOW()),'-12-01'), 'Confirmada');	
	INSERT INTO reservas(numero, doc_tipo, doc_nro, legajo, fecha, vencimiento, estado) 
        VALUES (3, 'DNI', 3, 103, CONCAT(YEAR(NOW()),'-10-01'), CONCAT(YEAR(NOW()),'-12-01'), 'Confirmada');	
	INSERT INTO reservas(numero, doc_tipo, doc_nro, legajo, fecha, vencimiento, estado) 
        VALUES (4, 'DNI', 4, 104,CONCAT(YEAR(NOW()),'-10-01'), CONCAT(YEAR(NOW()),'-12-01'), 'En Espera');	

	INSERT INTO reservas(numero, doc_tipo, doc_nro, legajo, fecha, vencimiento, estado) 
        VALUES (5, 'DNI', 5, 105,CONCAT(YEAR(NOW()),'-10-01'), CONCAT(YEAR(NOW()),'-12-01'), 'Confirmada');

	INSERT INTO reservas(numero, doc_tipo, doc_nro, legajo, fecha, vencimiento, estado) 
        VALUES (11, 'DNI', 5,105,CONCAT(YEAR(NOW()),'-10-01'), CONCAT(YEAR(NOW()),'-12-01'), 'Confirmada');
        
        # reservas de CB2
	INSERT INTO reservas(numero, doc_tipo, doc_nro, legajo, fecha, vencimiento, estado) 
        VALUES (6, 'DNI', 1, 101, CONCAT(YEAR(NOW()),'-10-01'), CONCAT(YEAR(NOW()),'-12-01'), 'Confirmada');
	INSERT INTO reservas(numero, doc_tipo, doc_nro, legajo, fecha, vencimiento, estado) 
        VALUES (7, 'DNI', 2, 102, CONCAT(YEAR(NOW()),'-10-01'), CONCAT(YEAR(NOW()),'-12-01'), 'Confirmada');	
	INSERT INTO reservas(numero, doc_tipo, doc_nro, legajo, fecha, vencimiento, estado) 
        VALUES (8, 'DNI', 3, 103, CONCAT(YEAR(NOW()),'-10-01'), CONCAT(YEAR(NOW()),'-12-01'), 'Confirmada');	
	INSERT INTO reservas(numero, doc_tipo, doc_nro, legajo, fecha, vencimiento, estado) 
        VALUES (9, 'DNI', 4, 104, CONCAT(YEAR(NOW()),'-10-01'), CONCAT(YEAR(NOW()),'-12-01'), 'En Espera');	

	INSERT INTO reservas(numero, doc_tipo, doc_nro, legajo, fecha, vencimiento, estado) 
        VALUES (10, 'DNI', 5, 105, CONCAT(YEAR(NOW()),'-10-01'), CONCAT(YEAR(NOW()),'-12-01'), 'Confirmada');
        INSERT INTO reservas(numero, doc_tipo, doc_nro, legajo, fecha, vencimiento, estado) 
        VALUES (12, 'DNI', 5, 105,CONCAT(YEAR(NOW()),'-10-01'), CONCAT(YEAR(NOW()),'-12-01'), 'Confirmada');
	
	# reservas de BC3 no tiene

#---------------------------------------------------------------------------------------------------------------------------
# RESERVA_VUELO_CLASE

        # reservas de BC1       
	INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) 
        VALUES (1, 'BC1', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02'), 'Turista');
	INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) 
        VALUES (2, 'BC1', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02'), 'Turista');
	INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) 
        VALUES (3, 'BC1', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02'), 'Turista');
	INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) 
        VALUES (4, 'BC1', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02'), 'Turista');

	INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) 
        VALUES (5, 'BC1', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02'), 'Primera');

	INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) 
        VALUES (11, 'BC1', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-02'), 'Ejecutiva');


        # reservas de CB2
        INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) 
        VALUES (6, 'CB2', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-05'), 'Turista');
	INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) 
        VALUES (7, 'CB2', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-05'), 'Turista');
	INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) 
        VALUES (8, 'CB2', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-05'), 'Turista');
	INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) 
        VALUES (9, 'CB2', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-05'), 'Turista');

	INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) 
        VALUES (10, 'CB2', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-05'), 'Primera');
	INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) 
        VALUES (12, 'CB2', CONCAT(YEAR(DATE_ADD(NOW(), INTERVAL 1 YEAR)),'-01-05'), 'Primera');

	
#---------------------------------------------------------------------------------------------------------------------------



DROP FUNCTION dia;
