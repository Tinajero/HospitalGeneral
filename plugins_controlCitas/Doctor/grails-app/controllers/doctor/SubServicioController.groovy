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
        respond SubServicio.findAllByFechaBajaIsNull(params), model:[subServicioCount: SubServicio.count()]
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
		
		subServicio.nombre = subServicio.nombre.toUpperCase()
		subServicio.descripcion = subServicio.descripcion.toUpperCase()
	
		
		def idUsuarioCreacion = springSecurityService.principal.id
		subServicio.usuarioCreacionId = idUsuarioCreacion
		subServicio.fechaCreacion = new Date();
			
		subServicio.tipoSubServicios = []

		if(params.tipoSubServicio != null){
			params.tipoSubServicio.id.each {
				TipoSubServicio s = TipoSubServicio.get(it);
				subServicio.tipoSubServicios.add(s);
			}
		}
		
		subServicio.validate()
        if (subServicio.hasErrors()) {
            respond subServicio.errors, view:'create'
            return
        }

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
		println "params " + params 
		println "......."
		println subServicio
		def usuarioModificacionId = springSecurityService.principal.id
		subServicio.usuarioModificacionId = usuarioModificacionId
		subServicio.fechaModificacion = new Date();
		
		subServicio.tipoSubServicios = []
		if(params.tipoSubServicio != null){
			params.tipoSubServicio.each { key, value ->
                print "tipoSubServicioID " + value
				TipoSubServicio s = TipoSubServicio.get(value);
				subServicio.tipoSubServicios.add(s);
			}
		}
		
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

        if(subServicioService.can_be_deleted(subServicio) == true) {
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
