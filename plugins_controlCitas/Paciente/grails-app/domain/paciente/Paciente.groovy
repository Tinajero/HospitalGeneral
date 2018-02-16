package paciente

import java.util.Date;


import com.sun.java.util.jar.pack.Attribute.FormatException;
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
	Calendar fechaNacimiento;
	String numeroTelefono
	String poblacion
	String sexo
	String entidadFederativa
	
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
    	fechaNacimiento nullable:true
		sexo nullable:true
		entidadFederativa nullable:true
		
		fechaBaja nullable:true
		fechaModificacion nullable:true
		usuarioBajaId nullable:true
		usuarioModificacionId nullable:true
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
		if(s != null && !s.isEmpty()){
			curp = s?.toUpperCase()
			
			setSexo(curp);
			setEntidadFederativa(curp);
			setFechaNacimiento(curp);	
		}			
	}
	
	void setFolioSeguroPopular(String s){
		folioSeguroPopular = s?.toUpperCase()
	}
	
	void setPoblacion(String s){
		poblacion = s?.toUpperCase()
	}

	void setSexo(String curp){
		if (curp != null && curp.size() > 11){
			char c = curp.charAt(10)
			if(c == 'h' || c == 'H'){
				sexo = "1";	
			} else {
				sexo = "2";
			}
		}
	}
	
	void setSexo(Integer i){
		sexo = i
	}
	
	void setEntidadFederativa(String curp){
		if(curp != null && curp.size() > 12){
			String clave = curp.substring(11, 13);
			entidadFederativa = clave;
		}
	}
	
	void setFechaNacimiento(String curp){
		try{
			if (curp != null && !curp.isEmpty()){
				Calendar fecha = Calendar.getInstance();
				String anio = curp.substring(4, 6);
				String mes = curp.substring(6, 8);
				String dia = curp.substring(8, 10);

				int intMes = Integer.parseInt(mes) - 1;
				int intDia = Integer.parseInt(dia)
								
				int intAnio = Integer.parseInt("19" + anio)
				
				if (intAnio < 50){
					intAnio += 100;
				}
				
				fecha.set(intAnio, intMes, intDia)
				
												
				fechaNacimiento = fecha;								
			}
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	void setFechaNacimiento(Calendar date){
		if(date != null){
			fechaNacimiento = date;
		}	
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
