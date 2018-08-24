package busquedas

import grails.transaction.Transactional
import cita.Cita
@Transactional
class BusquedasService {

    def serviceMethod()
    {

    }

    def consultaNombre(nombre, a_materno, a_paterno)
    {
        def resultados = []
        /*
        def select ="select  c.fecha, d.nombre, d.apellidoPat, d.apellidoMat, p.nombre, p.apellidoPaterno, p.apellidoMaterno, d.tipoCita, p.id\
         from Cita as c, Doctor as d, Paciente as p ";
        */
        def select = "SELECT apellidoPaterno, apellidoMaterno, nombre, expediente, id, numeroTelefono, poblacion FROM Paciente "
        def where = " WHERE nombre LIKE ? and apellidoPaterno LIKE ? and apellidoMaterno LIKE ? ORDER BY 1 DESC, 2 DESC, 3 DESC";
        /*recibe los parametros principales para un nombre y la bandera doctor[true-es doctor, false-es paciente]*/

        resultados = Cita.executeQuery(	select + where , [nombre, a_materno, a_paterno])
        return resultados
    }
	
	def consultaExpediente(numeroExpediente){
		
		def resultados = [];
		def select = "SELECT apellidoPaterno, apellidoMaterno, nombre, expediente, id, numeroTelefono, poblacion FROM Paciente "
		def where = " WHERE expediente LIKE ? ORDER BY expediente";
		
		resultados = Cita.executeQuery(select + where, [ numeroExpediente ]);
		return resultados;		
	}

    def obtenLista(params){

        def resultados=[]
        def ap_pat = "%"+params.p_ap_pat+"%"
        def ap_mat = "%"+params.p_ap_mat+"%"
        def nombre = "%"+params.p_nombre+"%"
        def lista  = []
		println params
		if(params.expediente.compareTo("") != 0){
			def expediente = "%" + params.expediente + "%";
			 resultados = consultaExpediente(expediente);
		} else {
			resultados = consultaNombre(nombre, ap_pat, ap_mat)
		}
		
        
         if ( resultados.size() < 1 )
         {
            print "Sin resultado"
            return lista
         }

        //Se arma la lista en base a los resultados encontrados
		for ( Object[] r in resultados )
        {
          /*
    			def map =	[	 'fecha': r[0],
    							     'doctor': r[1]+" " + r[2]+" "+ r[3],
    							     'paciente' : r[4] +" "+ r[5] +" "+ r[6],
                       'tipoCita' : r[7],
                       'id': r[8],
    						]
                */
          def map = [
                      'nombre':r[2] ,
                      'ap_mat':r[1] ,
                      'ap_pat':r[0] ,
                      'expediente':r[3] ,
                      'id': r[4],
					  'numeroTelefono': r[5],
					  'poblacion': r[6],
                    ]
				  lista += map
		    }
        //Se reenvia la informacion encontrada en forma de lista
        return lista

    }

}
