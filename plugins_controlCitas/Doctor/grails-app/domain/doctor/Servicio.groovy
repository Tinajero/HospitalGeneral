package doctor

import java.util.Date;

class Servicio {

	String nombre
	String descripcion
	static hasMany = [subServicios: SubServicio]
	
	Date fechaBaja
	Date fechaModificacion
	Date fechaCreacion
	
	Integer usuarioBajaId
	Integer usuarioModificacionId
	Integer usuarioCreacionId
	
		
    static constraints = {
		//subServicios nullable: true
		
		fechaBaja nullable:true
		fechaModificacion nullable:true
		usuarioBajaId nullable:true
		usuarioModificacionId nullable:true
    }


	@Override
	public String toString() {
		return "Servicio [nombre=" + nombre + ", descripcion=" + descripcion
				+ ", subServicio=" + subServicio + ", fechaBaja=" + fechaBaja
				+ ", fechaModificacion=" + fechaModificacion
				+ ", fechaCreacion=" + fechaCreacion + ", usuarioBajaId="
				+ usuarioBajaId + ", usuarioModificacionId="
				+ usuarioModificacionId + ", usuarioCreacionId="
				+ usuarioCreacionId + "]";
	}
	
	
}
