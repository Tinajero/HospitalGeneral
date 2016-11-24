package doctor

import grails.transaction.Transactional
import grails.converters.*
import org.codehaus.groovy.grails.web.json.*;

@Transactional
class DoctorService {
    def hora=[]
    def minutos=[]
    def HorarioService
    def serviceMethod() {

    }
    def listaTiposCita(){
        def lista = ['CIRUGIA GENERAL', 'MEDICINA INTERNA', 'PEDIATRIA', 'GINECOLOGIA Y OBSTETRICIA', 'TRAUMATOLOGIA Y ORTOPEDIA','DENTAL', 'PSICOLOGIA','ULTRASONIDOS' ]
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

    /**
    *   Servicio que regresa el horario de un doctor a parti de su ID
    */
    def getHorarioFromDoctorID(Long doctorId,String fechaQuery ) {
        print "fechaQuery " + fechaQuery
        def fechaDate = Date.parse("d-M-yyyy", fechaQuery)
        Calendar c = Calendar.getInstance();
        c.setTime(fechaDate);
        int day_of_week = c.get(Calendar.DAY_OF_WEEK) - 1;
        HorarioService.obtenerHorarioJsonDeDoctorDiaSemana( doctorId, day_of_week );
        
        
    }
   
    def getDoctoresWhitTipoCita(tipoCita){
        print "doctorService, getDoctoresWhitTipoCita " + tipoCita
        print tipoCita
        def query = Doctor.where {
            tipoCita ==~ tipoCita
        }
        def doctores = query.list();
        if (doctores.size() != 0){
            
            print doctores
            for (int i = 0; i < doctores.size() ; i++){                
                doctores[ i ].nombre = doctores[i].nombre + " " + doctores[i].apellidoPat + " " + doctores[i].apellidoMat                
            }
        }
        
        return doctores;
    }
    def getHoras(){
        intervalosDeTiempo()
        return hora
    }

    /**
    *   Apartir de una fecha con el formato d-M-yyyy se fija si ese dia
    * trabaja el Doctor, checando unicamente sus dias laborales que son de los 
    *   dias de la semana. Regresa true si es un dia laboral false de otra forma
    */
    def esDiaLaboral(int doctorId, String fechaQuery){
       // printf "DoctorService  esDiaLaboral " + doctorId + " " + fechaQuery
        def fechaDate = Date.parse("d-M-yyyy", fechaQuery)
        Calendar c = Calendar.getInstance();
        c.setTime(fechaDate);
        int day_of_week = c.get(Calendar.DAY_OF_WEEK) - 1;
       // print "dia de la semana " + day_of_week
        def doctor = Doctor.get(doctorId);
        if (doctor != null ){
           // printf "entro es Dia LAboral y doctor != null"
            def diasLaborales = doctor?.diasLaborales

           // print "diasLaborales " + diasLaborales
            if (diasLaborales.charAt( day_of_week ) != '-')
                return true            
        }
        return false;

    }

    def getDiasLaboralesDoctor(int doctorId) {
        return Doctor.get( doctorId)?.diasLaborales
    }
    def getMinutos(){
        return minutos
    }
    def obtenerDiasLaboralesPorHorario(jsonHorario){  
        def matrizHorarios = JSON.parse(jsonHorario);
        matrizHorarios       
        def diasString=['D','L','M','W','J','V','S']
        def dias = ""
        for (int i = 0; i < matrizHorarios.size(); i++){
            JSONObject.Null.metaClass.asBoolean = {-> false}
            print matrizHorarios[i][0]            
           // matrizHorarios[i][0]
            if (matrizHorarios[i][0].toString() != "null" )
                dias += diasString[i] 
            else
                dias += "-"
        }
        return dias
    }
    
    
}
