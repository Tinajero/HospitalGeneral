package doctor

import grails.transaction.Transactional

@Transactional
class TipoSubServicioService {

	def obtieneLosSubServiciosDeUnServicio(servicio){
		def query = Servicio.get(servicio)
		print query.subServicios;
		
		return query.subServicios
	}
	
	def obtienesLosTipoSubServicios(){
		def query = Servicio.executeQuery("from ServicioMedico servicioMedico where servicioMedico.fechaBaja is null and servicioMedico.class = 'doctor.TipoSubServicio'");
		print query;
		return query;
	}
	
	
	def serviceMethod() {

    }
}
