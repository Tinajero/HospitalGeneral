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
        def select ="select  c.fecha, d.nombre, d.apellidoPat, d.apellidoMat, p.nombre, p.apellidoPaterno, p.apellidoMaterno, d.tipoCita\
         from Cita as c, Doctor as d, Paciente as p ";

        def where = "where p.id = c.paciente and c.doctor = d.id  and p.nombre like ? and p.apellidoPaterno like ? and p.apellidoMaterno like ? order by c.fecha DESC";
        /*recibe los parametros principales para un nombre y la bandera doctor[true-es doctor, false-es paciente]*/

        resultados = Cita.executeQuery(	select + where , [nombre, a_materno, a_paterno])
        return resultados
    }


    def obtenLista(params){

        def resultados=[]
        def ap_pat = "%"+params.p_ap_pat+"%"
        def ap_mat = "%"+params.p_ap_mat+"%"
        def nombre = "%"+params.p_nombre+"%"
        def lista  = []
        print "obten lista"
        println ap_mat + ap_mat + nombre
        resultados = consultaNombre(nombre, ap_pat, ap_mat)
         if ( resultados.size() < 1 )
         {
            print "Sin resultado"
            return lista
         }
         print "size > 1"
         print resultados

        //Se arma la lista en base a los resultados encontrados
		for ( Object[] r in resultados )
        {
			def map =	[	'fecha': r[0],
							'doctor': r[1]+" " + r[2]+" "+ r[3],
							'paciente' : r[4] +" "+ r[5] +" "+ r[6],
              'tipoCita' : r[7],
						]
				lista += map
                print map
		}
        //Se reenvia la informacion encontrada en forma de lista
        return lista

    }

}