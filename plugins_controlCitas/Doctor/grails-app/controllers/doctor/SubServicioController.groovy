package doctor


import grails.plugin.springsecurity.SpringSecurityService;
import grails.plugin.springsecurity.annotation.Secured
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN'])
class SubServicioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	def SpringSecurityService springSecurityService
	def SubServicioService subServicioService;
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		
		def total = SubServicio.findAllByFechaBajaIsNull().size()
		def subServicioList = SubServicio.findAllByFechaBajaIsNull(params)
		
        respond subServicioList, model:[subServicioCount: total]
    }

    def show(SubServicio subServicio) {
        respond subServicio
    }

    def create() {
        respond new SubServicio(params)
    }

    @Transactional
    def save(SubServicio subServicio) {

        if (subServicio == null) {
            notFound()
            return
        }

        def idUsuarioCreacion = springSecurityService.principal.id
        subServicio.usuarioCreacionId = idUsuarioCreacion
        subServicio.fechaCreacion = new Date();

        subServicio.validate()
        if (subServicio.hasErrors()) {
        	respond subServicio.errors, view:'create'
        		return
        }
		
		subServicio.nombre = subServicio.nombre.toUpperCase()
		subServicio.descripcion = subServicio.descripcion.toUpperCase()

		subServicio.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'subServicio.label', default: 'SubServicio'), subServicio.id])
                redirect subServicio
            }
            '*' { respond subServicio, [status: CREATED] }
        }
    }

    def edit(SubServicio subServicio) {
        respond subServicio
    }

    @Transactional
    def update(SubServicio subServicio) {
        if (subServicio == null) {
            notFound()
            return
        }
		subServicio.nombre = subServicio.nombre.toUpperCase()
		subServicio.descripcion = subServicio.descripcion.toUpperCase()
		def usuarioModificacionId = springSecurityService.principal.id
		subServicio.usuarioModificacionId = usuarioModificacionId
		subServicio.fechaModificacion = new Date();
		
		subServicio.validate()

        if (subServicio.hasErrors()) {
            respond subServicio.errors, view:'edit'
            return
        }

        subServicio.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'SubServicio.label', default: 'SubServicio'), subServicio.id])
                redirect subServicio
            }
            '*'{ respond subServicio, [status: OK] }
        }
    }

    @Transactional
    def delete(SubServicio subServicio) {

        if (subServicio == null) {
            notFound()
            return
        }

        if(subServicioService.can_be_deleted(subServicio)) {
            	def usuarioModificacionId = springSecurityService.principal.id
                subServicio.usuarioBajaId = usuarioModificacionId
                subServicio.fechaBaja = new Date();
			    subServicio.save flush:true
        } else {
            def messageOther = 'El SubServicio tiene citas asignadas, por lo que no es posible eliminarlo'

            request.withFormat {
                form multipartForm {
                    flash.message = message(code: messageOther , args: [message(code: 'SubServicio.label', default: 'SubServicio'), subServicio.id])
                    redirect subServicio
                }
                '*'{ respond subServicio, [status: NOT_FOUND] }
            }
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SubServicio.label', default: 'SubServicio'), subServicio.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'subServicio.label', default: 'SubServicio'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
