package doctor

import grails.transaction.Transactional

@Transactional
class SubServicioService {

    def serviceMethod() {

    }
	
	def obtieneLosSubServiciosDeUnServicio(servicio){
		def query = Servicio.get(servicio)
		print query.subServicios;
		
		return query.subServicios		
	}
	
	def obtienesLosSubServicios(){
		def query = SubServicio.executeQuery("from Servicio servicio where servicio.fechaBaja is null and servicio.class = 'doctor.SubServicio'");
		print query;
		return query;
	}
}
