package doctor

import grails.transaction.Transactional

@Transactional
class SubServicioService {

    def serviceMethod() {

    }
	
	def obtieneLosSubServiciosDeUnServicio(servicio){
		def query = Servicio.get(servicio)
		//print query.subServicios;
		
		return query.subServicios		
	}
	
	def obtienesLosSubServicios(){
		def query = Servicio.executeQuery("from ServicioMedico servicioMedico where servicioMedico.fechaBaja is null and servicioMedico.class = 'doctor.SubServicio'");
		//print query;
		return query;
	}
}
