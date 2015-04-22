package doctor

import grails.transaction.Transactional

@Transactional
class DoctorService {
    def hora=[]
    def minutos=[]
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

    def intervalosDeTiempo(){

        if (hora==[])
        for ( int a= 0; a <60;a++){
            if ( a < 24)
                hora.add(sprintf("%02d",a))
            minutos.add(sprintf("%02d",a))

        }

    }
    
    def getHoras(){
        intervalosDeTiempo()
        return hora
    }

    def getMinutos(){
        return minutos
    }
}
