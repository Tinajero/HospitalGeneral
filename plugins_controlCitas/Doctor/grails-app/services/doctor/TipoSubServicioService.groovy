package doctor

import grails.transaction.Transactional

@Transactional
class TipoSubServicioService {

	def obtieneLosTipoSubServiciosDeUnSubServicio(servicio){
		def query = SubServicio.get(servicio)
//		print query.tipoSubServicios;
		
		return query.tipoSubServicios
	}
	
	def obtienesLosTipoSubServicios(){
		def query = TipoSubServicio.executeQuery("from TipoSubServicio tipoSubServicio where tipoSubServicio.fechaBaja is null");
//		print query;
		return query;
	}
	
	
	def serviceMethod() {

    }
}
