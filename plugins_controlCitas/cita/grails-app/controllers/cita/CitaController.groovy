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
        println params
        println "paciente"
        println cita.paciente.nombre
        cita.paciente.save flush:true
        println cita.paciente
        /*paciente.expediente = params.expediente
        paciente.nombre = params.nombre
        paciente.apellidoPaterno = params.apellidoPaterno
        paciente.apellidoMaterno = params.apellidoMaterno
        paciente.telefono = params.numeroTelefono
        if(paciente.hasErrors())
            println "paciente tiene errores"*/
        if (cita.hasErrors()) {
            respond cita.errors, view:'create'
            return
        }

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
            from:doctores, optionKey:'id', optionValue:'nombre', class:'form-control'
        )
    }
}
