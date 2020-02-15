package doctor



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured
import java.text.SimpleDateFormat;
import java.util.Date;

@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN'])
class DiaSinCitaController {

	
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def SpringSecurityService springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DiaSinCita.list(params), model:[diaSinCitaCount: DiaSinCita.count()]
    }

    def show(DiaSinCita diaSinCita) {
        respond diaSinCita
    }

    def create() {
        respond new DiaSinCita(params)
    }
	
	def transformarAFecha(String fecha){
		String format = "yyyy-MM-dd";
		Date date = new SimpleDateFormat(format).parse(fecha);
		return date;
	}

    @Transactional
    def save(DiaSinCita diaSinCita) {
        if (diaSinCita == null) {
            notFound()
            return
        }
		
		
		diaSinCita.fechaInicio = transformarAFecha(params.fechaInicio);
		diaSinCita.fechaFin = transformarAFecha(params.fechaFin);	
		
					
		
		def idUsuarioCreacion = springSecurityService.principal.id
		diaSinCita.usuarioCreacionId = idUsuarioCreacion
		diaSinCita.fechaCreacion = new Date();
				
	
		diaSinCita.validate()

        if (diaSinCita.hasErrors()) {
			print diaSinCita.errors
            respond diaSinCita.errors, view:'create', model:[diaSinCita:diaSinCita]
            return
        }

        diaSinCita.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'diaSinCita.label', default: 'DiaSinCita'), diaSinCita.id])
                redirect diaSinCita
            }
            '*' { respond diaSinCita, [status: CREATED] }
        }
    }

    def edit(DiaSinCita diaSinCita) {
        respond diaSinCita
    }

    @Transactional
    def update(DiaSinCita diaSinCita) {
		
        if (diaSinCita == null) {
            notFound()
            return
        }

        if (diaSinCita.hasErrors()) {
            respond diaSinCita.errors, view:'edit'
            return
        }

        diaSinCita.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'DiaSinCita.label', default: 'DiaSinCita'), diaSinCita.id])
                redirect diaSinCita
            }
            '*'{ respond diaSinCita, [status: OK] }
        }
    }

    @Transactional
    def delete(DiaSinCita diaSinCita) {

        if (diaSinCita == null) {
            notFound()
            return
        }

        diaSinCita.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DiaSinCita.label', default: 'DiaSinCita'), diaSinCita.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'diaSinCita.label', default: 'DiaSinCita'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
