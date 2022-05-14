package doctor

import grails.transaction.Transactional

@Transactional
class SubServicioService {

		def CitaService
    def serviceMethod() {

    }
	
	def obtieneLosSubServiciosDeUnServicio(servicio){
		def query = Servicio.get(servicio)
//		print query.subServicios;
		
		return query.subServicios		
	}
	
//	def agregartipoSubServicios(params, SubServicio subServicio){
//		if(subServicio.tipoSubServicios == null){
//			
//			subServicio.tipoSubServicios = []
//		}
//		
//		//println "parametros agregartipoSubServicios" + params
//		if(params.tipoSubServicios != null){
//			params.tipoSubServicios.id.each {
//				ServicioMedico s = ServicioMedico.get(it);
//				subServicio.tipoSubServicios.add(s);
//			}
//		}
//		
//		//println "SubServicio " + subServicio
//		return subServicio;
//	}
	
	def obtienesLosSubServicios(){
		def query = SubServicio.executeQuery("from SubServicio subServicio where subServicio.fechaBaja is null ");
		//print query;
		return query;
	}
	
	def can_be_deleted(subServiceId) {
		citas = CitaService.getCitasBySubService(subServiceId)
		return citas.count > 0
	}
	
}
