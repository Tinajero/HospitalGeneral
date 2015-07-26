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
        def lista = ['PED pediatria','G.O. ginecologia','Dental','cirugia','maternidad' ]
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
    def jsonHorario(horario){
        return JSON.parse(horario);
    }
    /**
    *   Servicio que regresa el horario de un doctor a parti de su ID
    */
    def getHorarioFromDoctorID( doctorId ) {
        def doctor = Doctor.get( doctorId )
        return  doctor?.horario;
    }

    def getDoctoresWhitTipoCita(tipoCita){
        print "doctorService, getDoctoresWhitTipoCita "
        print tipoCita
        def query = Doctor.where {
            tipoCita == tipoCita
        }
        def doctores = query.list();
        
        
        if (doctores.size() != 0){
            for (int i = 0; i < doctores.size() ; i++){
                doctores[i].nombre = doctores[i].nombre + " " + doctores[i].apellidoPat + " " + doctores[i].apellidoMat
            }
        }
        print doctores
        return doctores;
    }
    def getHoras(){
        intervalosDeTiempo()
        return hora
    }

    def getMinutos(){
        return minutos
    }
}
