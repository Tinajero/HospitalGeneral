package doctor

import grails.transaction.Transactional
import grails.converters.*
import org.codehaus.groovy.grails.web.json.*;

@Transactional
class DoctorService {
    def hora=[]
    def minutos=[]
    def serviceMethod() {

    }
    def listaTiposCita(){
        def lista = ['pediatria','ginecologia','ortodoncia','cirugia','maternidad']
        return lista
    }
    def obtenDiasLaborales(params){

    	def arregloDias = [params.Domingo, params.Lunes, params.Martes, \
            params.Miercoles, params.Jueves, params.Viernes,params.Sabado ]
        def diasLaborales = ""
        def diasString=['D','L','M','W','J','V','S']
        def i
            i = 0
        
         for ( dia in arregloDias){
            if (dia){
                diasLaborales+=diasString[i]
            }
            else{
                diasLaborales+="-"
            }
            i++
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
    /**
    *   Funcion que a partir de la cadena de horario en su dato los convertira todos en tiempos
    *   
    */
    def obtenHorario(horario){
        return JSON.parse(horario);
    }
    
    def getHoras(){
        intervalosDeTiempo()
        return hora
    }

    def getMinutos(){
        return minutos
    }
}
