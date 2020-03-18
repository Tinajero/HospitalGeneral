package doctor

import grails.transaction.Transactional

@Transactional
class ServicioService {
	
	
	def listaTiposCita(){
		def query = ServicioMedico.executeQuery("from ServicioMedico servicioMedico where servicioMedico.fechaBaja is null" +
				" and servicioMedico.class = 'doctor.Servicio'");
//		print query;
		return query;
	}
	
	def listaTiposSubServicio(){
		
	}
	
	def agregarSubServicios(params, Servicio servicio){
		servicio.subServicios = []
		if(params?.subServicio != null){
			params.subServicio.id.each {
				SubServicio s = SubServicio.get(it);
				servicio.subServicios.add(s);
			}
		}
		return servicio;
	}

    def serviceMethod() {

    }
}
