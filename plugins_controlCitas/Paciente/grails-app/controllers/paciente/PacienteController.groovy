package paciente



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured
@Transactional(readOnly = true)
@Secured(['ROLE_USER'])
class PacienteController {
    def CitaService
	def Cita
	
	def SpringSecurityService springSecurityService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Paciente.list(params), model:[pacienteCount: Paciente.count(), pacienteList :Paciente.list(params)]
    }

    def show(Paciente paciente) {
        def listaCitas = CitaService.getCitasWhitPacienteId(paciente.id)

        respond paciente, model:[historialCitas : listaCitas]
    }

    def create() {
        respond new Paciente(params)
    }

    @Transactional
    def save(Paciente paciente) {
        if (paciente == null) {
            notFound()
            return
        }

        if (paciente.hasErrors()) {
            respond paciente.errors, view:'create'
            return
        }

        paciente.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'paciente.label', default: 'Paciente'), paciente.id])
                redirect paciente
            }
            '*' { respond paciente, [status: CREATED] }
        }
    }

    def edit(Paciente paciente) {
        respond paciente
    }

    @Transactional
    def update(Paciente paciente) {

        //println paciente.nombre
        //println params

        if (paciente == null) {
            notFound()
            return
        }

        if (paciente.hasErrors()) {
            respond paciente.errors, view:'edit'
            return
        }

        paciente.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Paciente.label', default: 'Paciente'), paciente.id])
                redirect paciente
            }
            '*'{ respond paciente, [status: OK] }
        }
    }

    @Transactional
   def delete(Paciente paciente) {

        if (paciente == null) {
            notFound()
            return
        }
		
		def listaCitas = CitaService.getCitasWhitPacienteId(paciente.id)
		def idUsuarioElimina = springSecurityService.principal.id
		def ahora = new Date();
		
		for (int i = 0; i < listaCitas.size(); i++ ){
			def cita = listaCitas[i];
			cita.usuarioBajaId =  idUsuarioElimina
			cita.fechaBaja = ahora
			cita.save flush:true
		}		
		
		paciente.usuarioBajaId = idUsuarioElimina
		paciente.fechaBaja = ahora
		
	 

        paciente.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Paciente.label', default: 'Paciente'), paciente.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'paciente.label', default: 'Paciente'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
