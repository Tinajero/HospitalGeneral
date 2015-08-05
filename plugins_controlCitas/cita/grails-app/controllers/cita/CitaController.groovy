package cita

import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import paciente.Paciente
import doctor.Doctor
@Transactional(readOnly = true)
@Secured(['ROLE_USER'])
class CitaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def DoctorService
    def CitaService
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Cita.list(params), model:[citaCount: Cita.count()]
    }

    def show(Cita cita) {
        respond cita
    }

    def create() {
        respond new Cita(params)
        println Doctor.listUnique()
    }

    @Transactional
    def save(Cita cita) {
        
        if (cita == null) {
            notFound()
            return
        }

        cita.validate()
        if (cita.hasErrors() ) {
            println "tiene errores"
            println cita.errors
            respond cita.errors, view:'create', model:[cita:cita]
            return
        }

        cita.paciente.save flush:true
        cita.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'cita.label', default: 'Cita'), cita.id])
                redirect cita
            }
            '*' { respond cita, [status: CREATED] }
        }


        /*try {
            cita.validate()
            cita.paciente.save flush:true
            cita.save flush:true
        }
        catch(Exception e) {
            print "No se pudo guardar el registro";
        }*/

        /*cita.paciente.save flush:true

        def saveOK = cita.save flush:true

        if(saveOK){
            println "Save OK"
            request.withFormat {
                form multipartForm {
                  flash.message = message(code: 'default.created.message', args: [message(code: 'cita.label', default: 'Cita'), cita.id])
                    redirect cita
                }
                '*' { respond cita, [status: CREATED] }
            }
        }
        else{
            def error = cita.errors.getFieldError('expediente_textField')

            if(error){
                println "error code: $error.code";
                if(error.code == 'unique'){
                    printl "Expediente repetido"
                    render view: 'create', model:[cita:cita]
                }
            }
            else{
                cita.validate()
                if (cita.hasErrors() ) {
                    println "tiene errores"
                    println cita.errors
                    respond cita.errors, view:'create', model:[cita:cita]
                    return
                }
            }
        }*/

        
    }

    def edit(Cita cita) {
        respond cita
    }

    @Transactional
    def update(Cita cita) {
        if (cita == null) {
            notFound()
            return
        }

        if (cita.hasErrors()) {
            respond cita.errors, view:'edit'
            return
        }

        cita.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Cita.label', default: 'Cita'), cita.id])
                redirect cita
            }
            '*'{ respond cita, [status: OK] }
        }
    }

    @Transactional
    def delete(Cita cita) {

        if (cita == null) {
            notFound()
            return
        }

        cita.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Cita.label', default: 'Cita'), cita.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'cita.label', default: 'Cita'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
    /*  
        listener que responde cuando es cambiado el tipo de cita y 
        regresa los Doctores que atienden ese tipo de cita en un g:select
    */
    def tipoCitaCambiada(String tipoCita){
        println "tipoCitaCambiada"
        println tipoCita
        //printn params.  
        /*
        def query = Doctor.where {
            tipoCita == tipoCita
        }
        def doctores = query.list()*/
        def doctores = DoctorService.getDoctoresWhitTipoCita( tipoCita );
        render g.select(id:'cbDoctores', name:'doctor.id',
            from:doctores, optionKey:'id', optionValue:'nombre', class:'form-control' , onClick:'cambioDoctor(this.value);'
        )
    }
    /**
     *
     */
    def mostrarHorario(int doctorID, String fecha){

        print "accedio a mostrarHorario de citaController"
        //print params
        def esDiaLaboral = DoctorService.esDiaLaboral(doctorID, fecha)
        print "es un dia Laboral? " + esDiaLaboral
        def ret = [];
        if ( esDiaLaboral ) {
            def horario = DoctorService.getHorarioFromDoctorID(doctorID)            
            def citas = CitaService.getHorarioWhitDoctorAndDate( doctorID, fecha )                
            def libre = true;
            def i = 0;        
            if (horario != null ){
                def ohorario = JSON.parse(horario)
                print ohorario
                ohorario.each{
                    def hora = getHoraDeString(it.hora)
                    def minuto = getMinutoDeString(it.hora)
                    print hora + " " + minuto
                    libre = isLibre(hora, minuto, citas)
                    ret[i++] = [
                        hora: it.hora,
                        libre:libre
                    ]
                }
            }
            print ret as JSON
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
        render ret as JSON
    }
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
    def getHoraDeString(String hora){
        String temp = ""
        int horaEntero = 0;
        for (int i = 0; i < hora.length() && hora.charAt(i) !=':' ; i++){
            temp += hora.charAt(i)
        }        
        horaEntero = Integer.parseInt(temp)        
        return horaEntero;
    }
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
    def otraFuncion(){
        render "Hola Mundo"
    }
    //Funciones para Autocomplete
    def getAllExpedientes(){
        /*def citas = Cita.list()
        def response = []

        citas.each{
            response << "${it.paciente.expediente}"
        }

        render response as JSON*/
        def citas = Cita.list()

        render citas?.paciente as JSON
        
    }
}
