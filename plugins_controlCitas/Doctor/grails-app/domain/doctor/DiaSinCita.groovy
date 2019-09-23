package doctor

import java.util.Date;

class DiaSinCita {
	
	Doctor medico;
	Date fechaInicio;
	Date fechaFin; 
	
	Date fechaBaja
	Date fechaModificacion
	Date fechaCreacion
	
	Integer usuarioBajaId
	Integer usuarioModificacionId
	Integer usuarioCreacionId
	

    static constraints = {
		fechaBaja nullable:true
		fechaModificacion nullable:true
		usuarioBajaId nullable:true
		usuarioModificacionId nullable:true		
    }
}
