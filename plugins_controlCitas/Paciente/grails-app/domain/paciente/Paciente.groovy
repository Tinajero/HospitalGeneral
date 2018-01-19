package paciente

import java.util.Date;
/*
 * Clase que guardara la informacion de los pacientes, en este caso
 * solo necesita de el nombre y el string que se genera con el expediente
 * 
 * 
 * 
 */
class Paciente {

	String apellidoPaterno
	String apellidoMaterno
	String nombre
	String expediente
	String curp
	String folioSeguroPopular
	String edad
	String numeroTelefono
	String poblacion
	
	Date fechaBaja
	Date fechaModificacion
	Date fechaCreacion
	
	Integer usuarioBajaId
	Integer usuarioModificacionId
	Integer usuarioCreacionId
	
	
    static constraints = {
    	apellidoPaterno blank: false
    	apellidoMaterno blank: false
    	nombre blank:false
    	expediente blank: true, matches: '\\d{2}\\-\\d{2}\\-\\d{2}', nullable: true
    	numeroTelefono blank:false, nullable:false
    	poblacion blank: false
    	curp nullable: true
    	folioSeguroPopular nullable: true
    	edad nullable:true
		
		fechaBaja nullable:true
		fechaModificacion nullable:true
		usuarioBajaId nullable:true
		usuarioModificacionId nullable:true
    }
    static mapping = {
    	edad formula: "controlCitaDB.calcular_edad_curp(curp)"
    }
	
	void setNombre(String s){
		nombre = s?.toUpperCase()
	}
	void setApellidoPaterno(String s){
		apellidoPaterno = s?.toUpperCase()
	}
	void setApellidoMaterno(String s){
		apellidoMaterno = s?.toUpperCase()
	}
	void setCurp(String s){
		curp = s?.toUpperCase()
	}
	void setFolioSeguroPopular(String s){
		folioSeguroPopular = s?.toUpperCase()
	}
	void setPoblacion(String s){
		poblacion = s?.toUpperCase()
	}

    /*Esta es la function que se debe de crear en la base de datos.
	   CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_edad_curp`( curp VARCHAR(20)) RETURNS int(11)
	BEGIN
		
		DECLARE EDAD INTEGER;
	    
	    IF (curp is not null and 
			substring(CURP, 5, 6) REGEXP '^-?[0-9]+$' = 0) THEN
	        SET edad = null;
		ELSE
				IF (curp is not null and substring(CURP, 17,1) REGEXP '^-?[0-9]+$' > 0) THEN
					SET EDAD = TIMESTAMPDIFF(YEAR, concat( '19',substring(curp, 5,2),'-' ,substring(curp, 7,2), '-',substring(curp, 9,2) ), CURDATE());
				ELSEIF curp is not null then
					SET EDAD = TIMESTAMPDIFF(YEAR, concat( '20',substring(curp, 5,2),'-' ,substring(curp, 7,2), '-',substring(curp, 9,2) ), CURDATE());
				ELSE
					SET edad = null;
			END IF;
	    end if;
		RETURN EDAD;
	END
    */
}
