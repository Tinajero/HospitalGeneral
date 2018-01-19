package cita

import grails.transaction.Transactional
import grails.converters.JSON
import java.text.DateFormat
import java.text.SimpleDateFormat
import paciente.Paciente
@Transactional
class CitaService {

	def DoctorService
    def CitaService
    def CalendarioService
    def LastIndiceTempService
    def serviceMethod() {

    }
	
	
     /**
    * Servicio que regresa el horario del doctor dado un dia y un doctor
    * y checa las citas de ese dia para que
    * lo que regrese diga a que horas estan disponibles
    */
    def getHorarioWhitDoctorAndDate( int doctorId, String fechaQuery ){
        //print "CitaService "
        //print "fecha " + fechaQuery + " doctorid " + doctorId
        def doctorIdLong = new Long(doctorId)
        def inicioDia = Date.parse("d-M-yyyy HH:mm:ss", fechaQuery +" 00:00:00")
        def finDia = Date.parse("d-M-yyyy HH:mm:ss", fechaQuery +" 23:59:59")
       	def query = Cita.executeQuery("from Cita cit where cit.fecha >= :startTime and cit.fecha < :endTime and cit.doctor.id = :doctorId and cit.fechaBaja is null", [startTime:inicioDia, endTime:finDia, doctorId:doctorIdLong])
       	return query
    }
    /**
     * Funcion que dada una fecha del tipo dd-MM-yyyy regresa si ese dia este ocupado
     * libre, o ni siquiera trabaja
     * @param el id del doctor
     * @param String la fecha a consultar del tipo dd-MM-yyyy
     * @return 0 si esta libre, 1 si esta ocupado, -1 si no trabaja ese dia
     */
    def isBussyDay(Long doctorId,String date ){
       // print date
        int doctorID = (int) doctorId;
        int resultado = 0
        def esDiaLaboral = DoctorService.esDiaLaboral(doctorID, date)
        boolean f = true;
        if ( esDiaLaboral ) {
            //def horario = DoctorService.getHorarioFromDoctorID(doctorID)
            def horario = DoctorService.getHorarioFromDoctorID(doctorID, date)
            def citas = CitaService.getHorarioWhitDoctorAndDate( doctorID, date )
            def libre = true;
            def i = 0;
            f = true;
            if (horario != null ){
                //def ohorario = JSON.parse(horario)
                for (int j = 0; j < horario.size(); j ++){// checo hora por hora
                    /*def it = ohorario[j]; // se cambia por el cambio de horarios que tuvo
                    def hora = getHoraDeString(it.hora)
                    def minuto = getMinutoDeString(it.hora)
                    */
                    def hora = horario[j][0]
                    def minuto = horario[j][1]
                  //  print hora + " " + minuto + " " + citas
                    if ( isLibre(hora, minuto, citas)  ){// encuentra una hora libre ese dia
                  //      print "si entro"
                        if (f){
                            resultado = 0
                            f = false
                        }
                        break

                    }
                }
                // recorrio todas sus horas y no encontro una libre, entonces ese dia esta ocupado
                if (f){
                    resultado = 1
                    f = false
                }
            }
        }
        // ese dia ni siquiera trabaja
        if (f){
            resultado = -1
            f = false
        }

        resultado
    }

    /**
     * Service que a partir de el ID de un doctor, y la fecha en formato de cadena  dia + "-" + mes + "-" + anio
     * regresa el horario de un Doctor, con las horas ocupadas marcadas en un arreglo, que debe ser convertido a Json
     * como respuesta para el script que lo llama
     * @param doctorID es el ID del doctor
     * @param fecha en formato de cadena  dia - mes- anio ej: 7-5-2015 (7  de mayo de 2015)
     * @return  regresa en caso correcto un Json con los horarios del doctor, en caso de que no trabaje ese dia
     * la leyenda  No atiende citas ese dia, unicamente (los dias que atiende)
     *
     */
   def mostrarHorario(int doctorID, String fecha){

        //print "accedio a mostrarHorario de citaController"
        //print params
        def esDiaLaboral = DoctorService.esDiaLaboral(doctorID, fecha)
        //print "es un dia Laboral? " + esDiaLaboral
        def ret = [];
        if ( esDiaLaboral ) {
            def horario = DoctorService.getHorarioFromDoctorID(doctorID, fecha)
            def citas = CitaService.getHorarioWhitDoctorAndDate( doctorID, fecha )
            def libre = true;
            def i = 0;
            if (horario != null ){
                //def ohorario = JSON.parse(horario)
                //print ohorario
                /*horario.each{
                    //def hora = getHoraDeString(it.hora)
                    //def minuto = getMinutoDeString(it.hora)
                    def hora = it[0]
                    def minuto = it[1]
                    def tipo = it[2]
                    def horaString = sprintf("%02d",hora) +":"+sprintf("%02d",minuto)
                    libre = isLibre(hora, minuto, citas)
                    ret[i++] = [
                        hora: horaString,
                        tipo: tipo,
                        libre:libre
                    ]
                }*/
                //Colocar Si un paciente subsecuente ocupa un lugar de "Primera Vez" y si un paciente de primera vez ocupa un "subsecuente"
                horario.each{
                    def hora = it[0]
                    def minuto = it[1]
                    def tipo = it[2]
                    def horaString = sprintf("%02d",hora) +":"+sprintf("%02d",minuto)
                    libre = isLibre(hora, minuto, citas)
                    def asignadaA = isAsignadaA(doctorID, fecha, horaString)
                    ret[i++] = [
                        hora: horaString,
                        tipo: tipo,
                        libre: libre,
                        asignadaA: asignadaA
                    ]
                }
                //end
            }
            //print ret as JSON
        } else { // no trabaja ese dia
            def dias = DoctorService.getDiasLaboralesDoctor(doctorID)
            def mensajeDias = ""
            for (int i = 0; i < dias.length(); i++){
                if (dias.charAt(i) != '-') {
                    if (mensajeDias.length() != 0)
                        mensajeDias += ", "

                    switch(i){
                        case 0: mensajeDias += "Domingo"; break;
                        case 1: mensajeDias += "Lunes"; break;
                        case 2: mensajeDias += "Martes"; break;
                        case 3: mensajeDias += "Miercoles"; break;
                        case 4: mensajeDias += "Jueves"; break;
                        case 5: mensajeDias += "Viernes"; break;
                        case 6: mensajeDias += "Sabado"; break;
                    }
                }

            }
            ret[0] = [
                hora: "No atiende citas ese dia, unicamente ",
                libre: false
            ]
            ret[1] = [
                hora: mensajeDias,
                libre: false
            ]

        }
       // print horario
       // esto deberia ser mostrado en JSON
        return ret
    }
    /**
     * Funcion utilizada por el service mostrarHorario que checa a partir de la hora y minuto dado
     * checa todas las citas que le dan en citas y ve si esta ocupadas o libres esas horas
     * @param hora, entero de la hora a checar
     * @param minuto, entero del minuto a checar
     * @param citas, son las citas de un solo dia
     * @return true si es Libre esa hora con minuto, false de otro modo
     */
    def isLibre(int hora, int minuto,citas){
        def esta = true;
        Calendar calendar = Calendar.getInstance()
        int hours, minutes
        for(int i = 0; i < citas.size(); i++ ){
            def it = citas[i]
            calendar.setTime( it.fecha );
            hours = calendar.get(Calendar.HOUR_OF_DAY);
            minutes = calendar.get(Calendar.MINUTE);

            if (hora == hours && minutes == minuto){
                esta = false
                break;
            }
        }

        return esta
    }
    /**
     * Funcion que a partir de una cadena del tipo "hh:mm" regresa la hora
     * ej: "07:45" regresa el 7
     * @param cadena del tipo "hh:mm"
     * @return entero de la hora de
     */
    def getHoraDeString(String hora){
        String temp = ""
        int horaEntero = 0;
        for (int i = 0; i < hora.length() && hora.charAt(i) !=':' ; i++){
            temp += hora.charAt(i)
        }
        horaEntero = Integer.parseInt(temp)
        return horaEntero;
    }
    /**
     * Funcion que a partir de una cadena del tipo "hh:mm" regresa la hora
     * ej: "07:45" regresa el 45
     * @param hora, cadena del tipo "hh:mm"
     * @return entero de la hora de la cadena
     */
    def getMinutoDeString(String hora){
        String temp = ""
        int minutoEntero = 0;
        int i;
        for ( i = 0; i < hora.length() && hora.charAt(i) !=':' ; i++);
        i++;
        for  ( ; i < hora.length() && hora.charAt(i) >='0' && hora.charAt(i) <='9' ; i++){
             temp += hora.charAt(i)
        }
        minutoEntero = Integer.parseInt(temp)
        return minutoEntero;
    }
    /**
     * funcion que dada una fecha de inicio, una fecha final, y un doctorId regresa el arreglo
     * con los dias ocupados y libres
     * @param  startTime fecha en String de forma yyyy-MM-dd inicio del intervalo a checar
     * @param  endTime   fecha en String de forma yyyy-MM-dd final del intervalo a checar
     * @param  doctorId  Id del doctor
     * @return              arreglo que contiene un int: ocupado, String: fechaString, date: date
     */
    def getBussyDays(String startTime, String endTime, Long doctorId){
        def ans = [] // arreglo de mapas que regresaremos
        //print "getBussyDays CitaService : "
        def startDate = Date.parse("yyyy-MM-dd HH:mm:ss", startTime + " 00:00:00")
        def endDate = Date.parse("yyyy-MM-dd HH:mm:ss", endTime + " 00:00:00")
        DateFormat outputFormatter = new SimpleDateFormat("dd-MM-yyyy")
        DateFormat formato = new SimpleDateFormat("yyyy-MM-dd")
        def bussy
        String fechaString = "", fechaId = ""
        if  ( startTime != null )
        for (int i = 0; startDate.compareTo(endDate) < 0 ; i++ ){ // mientras tempDate este antes que endDate
            //print startDate
            fechaString = outputFormatter.format(startDate)
            fechaId = formato.format(startDate)
            // chechando si esta ocupado cierto dia fechaString
            bussy = isBussyDay( doctorId, fechaString )
            ans[i] = [  ocupado: bussy,
                        fecha: fechaString,
                        id: fechaId,
                        date: startDate ]
            startDate = startDate + 1

        }
        return ans
    }

    def getCitasWhitPacienteId(Long pacienteId){
        //println pacienteId
        def citas = Cita.executeQuery("from Cita cita where cita.paciente.id = :pacienteId",[pacienteId: pacienteId]);
        return citas
    }

    def generateExpediente(){
        println LastIndiceTempService.getLastIndex();
    }

    //service for autocomplete
	 def getPacientesWithFullExpediente(String expediente){
        println 'getPacientesWithFullExpediente';
        println expediente;
		  def paciente = Paciente.executeQuery("from Paciente paciente where paciente.expediente = :expediente and paciente.fechaBaja is null",[expediente: expediente]);
        return paciente
    }
    def getPacientesWithExpediente(String expediente){
        println 'getPacientesWithExpediente';
        println expediente;
        def criteria = Paciente.createCriteria()
        def results = criteria.listDistinct () {
			like('expediente', expediente+'%')
            and {
               isNull('fechaBaja')				
            }
            maxResults(50)
        }
        return results
    }
    def getPacientesWithNombre(String nombre){
        def criteria = Paciente.createCriteria()
        def results = criteria.listDistinct () {
			like('nombre', nombre+'%')
            and {
               isNull('fechaBaja')				
            }
            maxResults(50)
        }
        return results
    }
    def getPacientesWithApaterno(String apaterno){
        def criteria = Paciente.createCriteria()
        def results = criteria.listDistinct () {
			like('apellidoPaterno', apaterno+'%')
			and {
                isNull('fechaBaja')			
            }
            maxResults(50)
        }
        return results
    }
    def getPacientesWithAmaterno(String amaterno){
        def criteria = Paciente.createCriteria()
        def results = criteria.listDistinct () {
			like('apellidoMaterno', amaterno+'%')
			and {
               isNull('fechaBaja')
            }
            maxResults(50)
        }
        return results
    }
    //service for autocomplete
    //Colocar Si un paciente subsecuente ocupa un lugar de "Primera Vez" y si un paciente de primera vez ocupa un "subsecuente"
    def isAsignadaA(int doctorID, String fecha, String horaString){
        def citas = CitaService.getHorarioWhitDoctorAndDate( doctorID, fecha )
        def asignadaA = ''
        def citaHora = ''
        citas.each{
            citaHora = it.fecha.toString().split(' ')[1].substring(0, 5)
            if( citaHora == horaString ){
                asignadaA = it.asignadaA
            }
        }
        return asignadaA
    }
    //end
}
