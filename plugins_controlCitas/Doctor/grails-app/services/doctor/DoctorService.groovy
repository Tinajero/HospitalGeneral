package doctor

import grails.transaction.Transactional

@Transactional
class DoctorService {

    def serviceMethod() {

    }
    def obtenDiasLaborales(params){

    	def arregloDias = [params.Domingo, params.Lunes, params.Martes, \
            params.Miercoles, params.Jueves, params.Viernes,params.Sabado ]
        def diasLaborales = ""
        
         for ( dia in arregloDias){
            if (dia){
                diasLaborales+="1"
            }
            else{
                diasLaborales+="0"
            }
         }

        return diasLaborales
    }
}
