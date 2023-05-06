package doctor

import java.util.Date;
import org.grails.databinding.BindingFormat

class DiaSinCita {
	
	Doctor medico;
	@org.grails.databinding.BindingFormat('yyyy-MM-dd')
	Date fechaInicio;
	@org.grails.databinding.BindingFormat('yyyy-MM-dd')
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


	@Override
	public String toString() {
		return "DiaSinCita [medico=" + medico + ", fechaInicio=" + fechaInicio + ", fechaFin=" + fechaFin + ", fechaBaja=" + fechaBaja
				+ ", fechaModificacion=" + fechaModificacion
				+ ", fechaCreacion=" + fechaCreacion + ", usuarioBajaId="
				+ usuarioBajaId + ", usuarioModificacionId="
				+ usuarioModificacionId + ", usuarioCreacionId="
				+ usuarioCreacionId + "]";
	}

		

}
