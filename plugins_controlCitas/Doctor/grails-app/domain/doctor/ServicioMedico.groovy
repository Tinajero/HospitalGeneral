package doctor

import java.util.Date;

class ServicioMedico {
	
	String nombre
	String descripcion
	
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
		return "[nombre:" + nombre + ", descripcion:" + descripcion +
				 ", fechaBaja:" + fechaBaja +
				 ", fechaModificacion:" + fechaModificacion +
				 ", fechaCreacion:" + fechaCreacion + ", usuarioBajaId:" +
				 usuarioBajaId + ", usuarioModificacionId:" +
				 usuarioModificacionId + ", usuarioCreacionId:" +
				 usuarioCreacionId + "]";
	}
	
	
}
