package doctor

import grails.transaction.Transactional

@Transactional
class DiaSinCitaService {

    def serviceMethod() {

    }
	
	def isDiaSinCita(fechaQuery, medicoId) {
		def date = Date.parse("d-M-yyyy", fechaQuery)
		
		def query = DiaSinCita.where {
			medico.id == medicoId
			and {
				le('fechaInicio', date)
				ge('fechaFin', date)
			}
			
		}
		return query.size() > 0
	}
}
