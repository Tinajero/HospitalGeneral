package doctor

import grails.transaction.Transactional

@Transactional
class ServicioService {
	
	def CitaService
	def DoctorService
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
				SubServicio s = SubServicio.get(it.value);				
				servicio.subServicios.add(s);
			}
		}
		return servicio;
	}

    def serviceMethod() {

    }
	
	def tieneCitas(servicio) {
		def citas = CitaService.getCitasByServicio(servicio)
		print "Citas retornadas que tienen este servicio " + citas
		!citas.empty
	}
	
	def haveDoctors(servicio) {
		!DoctorService.getByTipoCitaActive(servicio).empty
	}
	
	def safe_delete(servicio, usuarioModificacionId) {
		servicio.usuarioBajaId = usuarioModificacionId
		servicio.fechaBaja = new Date();
		servicio.save flush:true
	}
}
