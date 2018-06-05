package doctor

import grails.transaction.Transactional
import grails.converters.*
import org.codehaus.groovy.grails.web.json.*;

@Transactional
class DoctorService {
	def sessionFactory
    def hora=[]
    def minutos=[]
    def HorarioService
    def serviceMethod() {

    }
    def listaTiposCita(){

	    //esto es de Orla//def lista = ["pediatria","otras","odontologia",	"medicina_interna", "ginecologia","consulta_externa", "cirugia"]

        def lista = ['CIRUGIA GENERAL', 'MEDICINA INTERNA', 'PEDIATRIA', 'GINECOLOGIA Y OBSTETRICIA', 'TRAUMATOLOGIA Y ORTOPEDIA','DENTAL', 'PSICOLOGIA','ULTRASONIDOS', 'CONSULTA EXTERNA' ]

        return lista
    }

    def listaTurnos() {
        def turnos = [[value:1, turno:'MATUTINO'], [value:2, turno:'VESPERTINO']]
        return turnos
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
        //print "fechaQuery " + fechaQuery
        def fechaDate = Date.parse("d-M-yyyy", fechaQuery)
        Calendar c = Calendar.getInstance();
        c.setTime(fechaDate);
        int day_of_week = c.get(Calendar.DAY_OF_WEEK) - 1;
        HorarioService.obtenerHorarioJsonDeDoctorDiaSemana( doctorId, day_of_week );
        
        
    }
   
    def getDoctoresWhitTipoCita(tipoCita, turno){

		def query;
		def turnoWhere = ""
		def resultados = [];
		if(turno != null){
			turnoWhere = " and doctor.turno = " + "turno";			
		}
		
		def consulta = 	"select doctor.tipo_cita as tipoCita, doctor.id, " +
			"concat(doctor.nombre, ' ', doctor.apellido_pat, ' ', doctor.apellido_mat) as doctorNombre " +
			"from doctor where doctor.tipo_cita = '" + tipoCita + "'"
			turnoWhere ;
			

			def currentSession = sessionFactory.currentSession
			resultados = currentSession.createSQLQuery(consulta);
		
        def doctores = resultados.list();
		def nombreDoctores = []
        if (doctores.size() != 0){            
			for (int i = 0; i < doctores.size() ; i++){				             
				def doctor = [:];
				doctor['nombre'] = doctores[i][2];
				doctor['id'] = doctores[i][1];
				nombreDoctores[i] = doctor;
            }
        }
        
        return nombreDoctores;
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
        def fechaDate = Date.parse("d-M-yyyy", fechaQuery)
        
		Calendar c = Calendar.getInstance();
        c.setTime(fechaDate);
		
        int day_of_week = c.get(Calendar.DAY_OF_WEEK) - 1;   
        def doctor = Doctor.get(doctorId);
		
        if (doctor != null ){         
            def diasLaborales = doctor?.diasLaborales       
			 
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
            //print matrizHorarios[i][0]            
           // matrizHorarios[i][0]
            if (matrizHorarios[i][0].toString() != "null" )
                dias += diasString[i] 
            else
                dias += "-"
        }
        return dias
    }
    
    
}
