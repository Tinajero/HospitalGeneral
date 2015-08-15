package hojaregistrodiario

import grails.transaction.Transactional
import cita.Cita
import java.util.Date
import java.text.SimpleDateFormat
@Transactional
class HojaRegistroDiarioService {

    def serviceMethod() {

    }

    //La lista se usara para crear el pdf
  def consulta(date1, date2, tipoCita){
    def resultados=[]
    def select ="select  c.fecha, d.nombre, d.apellidoPat, d.apellidoMat, p.nombre, p.apellidoPaterno, p.apellidoMaterno, d.tipoCita\
     from Cita as c, Doctor as d, Paciente as p ";
    def where = "where c.fecha >=? and c.fecha<=? and d.id = c.doctor and p.id = c.paciente";

    if (tipoCita == "")
      resultados = Cita.executeQuery(	select + where + "  ORDER BY d.nombre ASC",[ date1, date2])
    else
      resultados = Cita.executeQuery(	select + where +  " and d.tipoCita = ?  ORDER BY d.nombre ASC",[ date1, date2, tipoCita])
//and d.tipoCita = ?  , params.tipoCita
    return resultados
  }

	def list(params){
    /*SimpleDateFormat permite dar el formato para crear un objeto:Date
      ademas a la fecha obtenida se le agrega la hora para asignar un intervalo
    */
  		def resultados=[]
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
      def date1 = sdf.parse( params.fecha.format("yyyy-MM-dd")+" 00:00:00" )
      def date2 = sdf.parse( params.fecha.format("yyyy-MM-dd")+" 23:59:59" )
      def tipoCita = params.tipoCita;
      def lista = []
      resultados = consulta(date1, date2, tipoCita)
		/*
    construcción de lista de mapas
    El objeto (lista) se rellenara con mapas para almacenar la informacion pertinente a la hora
      un mapa contine fecha, doctor y paciente
  */
		for ( Object[] r in resultados ){
			def map =	[	'fecha': r[0],
							'doctor': r[1]+" " + r[2]+" "+ r[3],
							'paciente' : r[4] +" "+ r[5] +" "+ r[6],
              'tipoCita' : r[7],
						]
				lista += map
        print map
		}

		return lista

	}
}
