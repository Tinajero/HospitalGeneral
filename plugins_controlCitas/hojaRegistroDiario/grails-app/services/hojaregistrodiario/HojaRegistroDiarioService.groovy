package hojaregistrodiario

import grails.transaction.Transactional
import cita.Cita
@Transactional
class HojaRegistroDiarioService {

    def serviceMethod() {

    }

    //params incluye datos de fecha y tipo de cita
	def list(params){
		//obtener lista apratir de params
		//params {fecha:"", doctor:""}
  		
  		def resultados=[]
		  
  		resultados = Cita.executeQuery(
  			"select  c.fecha, d.nombre, d.apellidoPat, d.apellidoMat, p.nombre, p.apellidoPaterno, p.apellidoMaterno\
  			 from Cita as c, Doctor as d, Paciente as p\
  			 where c.fecha=? and d.id = c.doctor and p.id = c.paciente  ORDER BY d.nombre ASC",[params.fecha])
					//and c.tipoCita = ?  , params.tipoCita
		//Se obtienen id´s_id
		def lista = []
		//construcción de lista de mapas
		print params
		print params.tipoCita

		for ( Object[] r in resultados ){
			def map =	[	'fecha': r[0], 
							'doctor': r[1]+" " + r[2]+" "+ r[3], 
							'paciente' : r[4] +" "+ r[5] +" "+ r[6]		
						]
				lista += map
		}
		
		return lista
		
	}
}
