package doctor



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN'])
class DiaSinCitaController {

	
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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

    @Transactional
    def save(DiaSinCita diaSinCita) {
        if (diaSinCita == null) {
            notFound()
            return
        }

        if (diaSinCita.hasErrors()) {
            respond diaSinCita.errors, view:'create'
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
