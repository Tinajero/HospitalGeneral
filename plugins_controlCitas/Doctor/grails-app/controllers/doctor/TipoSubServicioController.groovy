package doctor

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured

@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN'])
class TipoSubServicioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	def SpringSecurityService springSecurityService
    def TipoSubServicioService tipoSubServicioService
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond TipoSubServicio.list(params), model:[tipoSubServicioCount: TipoSubServicio.count()]
    }

    def show(TipoSubServicio tipoSubServicio) {
        respond tipoSubServicio
    }

    def create() {
        respond new TipoSubServicio(params)
    }

    @Transactional
    def save(TipoSubServicio tipoSubServicio) {
					
        if (tipoSubServicio == null) {
            notFound()
            return
        }
		tipoSubServicio.nombre = tipoSubServicio.nombre.toUpperCase()
		tipoSubServicio.descripcion = tipoSubServicio.descripcion.toUpperCase()
		def idUsuarioCreacion = springSecurityService.principal.id
		tipoSubServicio.usuarioCreacionId = idUsuarioCreacion
		tipoSubServicio.fechaCreacion = new Date();
		tipoSubServicio.validate()

        if (tipoSubServicio.hasErrors()) {
            respond tipoSubServicio.errors, view:'create'
            return
        }

        tipoSubServicio.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'tipoSubServicio.label', default: 'TipoSubServicio'), tipoSubServicio.id])
                redirect tipoSubServicio
            }
            '*' { respond tipoSubServicio, [status: CREATED] }
        }
    }

    def edit(TipoSubServicio tipoSubServicio) {
        respond tipoSubServicio
    }

    @Transactional
    def update(TipoSubServicio tipoSubServicio) {
        if (tipoSubServicio == null) {
            notFound()
            return
        }
		
		tipoSubServicio.nombre = tipoSubServicio.nombre.toUpperCase()
		tipoSubServicio.descripcion = tipoSubServicio.descripcion.toUpperCase()
		def idUsuarioModificacion = springSecurityService.principal.id
		tipoSubServicio.usuarioModificacionId = idUsuarioModificacion
		tipoSubServicio.fechaModificacion = new Date();

        if (tipoSubServicio.hasErrors()) {
            respond tipoSubServicio.errors, view:'edit'
            return
        }

        tipoSubServicio.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'TipoSubServicio.label', default: 'TipoSubServicio'), tipoSubServicio.id])
                redirect tipoSubServicio
            }
            '*'{ respond tipoSubServicio, [status: OK] }
        }
    }

    @Transactional
    def delete(TipoSubServicio tipoSubServicio) {

        if (tipoSubServicio == null) {
            notFound()
            return
        }

        if(tipoSubServicioService.can_be_deleted(tipoSubServicio) == true) {
            	def usuarioModificacionId = springSecurityService.principal.id
                tipoSubServicio.usuarioBajaId = usuarioModificacionId
                tipoSubServicio.fechaBaja = new Date();
			    tipoSubServicio.save flush:true
        } else {
            def messageOther = 'El Tipo de Sub Servicio tiene citas asignadas, por lo que no es posible eliminarlo'

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: messageOther , args: [message(code: 'TipoSubServicio.label', default: 'TipoSubServicio'), tipoSubServicio.id])
                    redirect tipoSubServicio
                }
                '*'{ respond tipoSubServicio, [status: NOT_FOUND] }
            }
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'TipoSubServicio.label', default: 'TipoSubServicio'), tipoSubServicio.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoSubServicio.label', default: 'TipoSubServicio'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
