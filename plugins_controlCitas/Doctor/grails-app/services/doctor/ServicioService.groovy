package doctor

import grails.transaction.Transactional

@Transactional
class ServicioService {
	
	
	def listaTiposCita(){
		def query = Servicio.executeQuery("from Servicio servicio where servicio.fechaBaja is null");
		print query;
		return query;
	}

    def serviceMethod() {

    }
}
