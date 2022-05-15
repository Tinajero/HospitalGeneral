package doctor

import grails.transaction.Transactional

@Transactional
class SubServicioService {

	def CitaService
	def serviceMethod() {

	}
	
	def obtieneLosSubServiciosDeUnServicio(servicio){
		def query = Servicio.get(servicio)
		
		return query.subServicios		
	}
	
	def obtienesLosSubServicios(){
		def query = SubServicio.executeQuery("from SubServicio subServicio where subServicio.fechaBaja is null ");
		return query;
	}
	
	def can_be_deleted(subServiceId) {
		def citas = CitaService.getCitasBySubService(subServiceId)
		print "Citas retornadas que tienen este subservicio " + citas
		return citas == null || citas.count == 0
	}
	
}
