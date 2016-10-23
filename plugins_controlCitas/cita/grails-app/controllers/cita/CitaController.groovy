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
    def CitaService
    def DoctorService
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
        println cita
        if (cita == null) {
            notFound()
            return
        }
        if (cita.paciente.expediente != null) {

            def p = Paciente.findByExpediente(cita.paciente.expediente)
            if(p){
                println "Se encontró el expediente en la BD"
                println "p = " + p.expediente
                cita.paciente = p
                println "cita.paciente : " + cita.paciente
            }
        }

        cita.validate()
        if (cita.hasErrors() ) {
            println "Cita tiene errores"
            println "Errores" + cita.errors + "END Errores"
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
    }

    def edit(Cita cita) {
        println cita
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

    def tipoCitaCambiada(String tipoCita){
        println "tipoCitaCambiada"
        println tipoCita
        //printn params.  
        def query = Doctor.where {
            tipoCita == tipoCita
        }
        def doctores = DoctorService.getDoctoresWhitTipoCita( tipoCita );
        println doctores
        def noSelection = ['':'Seleccione un Medico']
        render g.select(id:'cbDoctores', name:'cita.doctor.id',
            from:doctores, optionKey:'id', optionValue:'nombre', class:'form-control' , onchange:'cambioDoctor(this.value);',
           noSelection:noSelection, required:'true'
        )
    }
    
    def mostrarHorario(int doctorID, String fecha){
        def ret = CitaService.mostrarHorario(doctorID, fecha);
        render ret as JSON
    }    
    def otraFuncion(){
        render "Hola Mundo"
    }
    //Funciones para Autocomplete
    def AutocompletadoEnCitas(){
        /*def citas = Cita.list()
        def response = []

        citas.each{
            response << "${it.paciente.expediente}"
        }

        render response as JSON*/
        def pacientes = Paciente.list()
        
        render pacientes as JSON
    }

    def getBussyDays(String startTime,String endTime, Long doctorId){
        print "getBussyDays citaControler: "
        print startTime
        print endTime
        print doctorId
        def bussyDays = CitaService.getBussyDays(startTime, endTime, doctorId)
        render bussyDays as JSON
    }
}
