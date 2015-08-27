package cita



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import paciente.Paciente
import doctor.Doctor
@Transactional(readOnly = true)
@Secured(['ROLE_USER'])
class CitaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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
        if (cita.hasErrors()) {
            println "tiene errores"
            println cita.errors
            respond cita.errors, view:'create'
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
        def doctores = query.list()
        println doctores
        render g.select(id:'subCategory', name:'doctor.id',
            from:doctores, optionKey:'id', optionValue:'nombre', class:'form-control' , onClick:'cambioDoctor(this.value)'
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
        //def citas = Cita.list()
        /*def response = []

        citas.each{
            response << "${it.paciente.expediente}"
        }

        render response as JSON*/
        def pacientes = Paciente.list()
        
        render pacientes as JSON
    }
}
