package controlcitas

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional


@Transactional(readOnly = true)
@Secured(['ROLE_ADMIN'])
class UsuarioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		
		def query = Usuario.where {
			enabled == true
		}
//        respond Usuario.list(params), model:[usuarioInstanceCount: Usuario.count()]
		respond query.list(params), model:[usuarioInstanceCount: Usuario.count()]
    }

    def show(Usuario usuarioInstance) {
        respond usuarioInstance
    }

	
    def create() {
        respond new Usuario(params)
    }

    @Transactional
    def save(Usuario usuarioInstance) {
		
        if (usuarioInstance == null) {
            notFound()
            return
        }

        if (usuarioInstance.hasErrors() ) {
			
            respond usuarioInstance.errors, view:'create'
            return
        }
		
		if (params.password2 != params.password){
			usuarioInstance.errors.reject('user.password.doesnotmatch ', 'Las contrase&ntilde;as no coinciden')
			respond usuarioInstance.errors, view:'create'
			return
		}
		def userRole = SecRole.findOrSaveWhere(authority:'ROLE_USER')
		
		
        usuarioInstance.save flush:true
		SecUserSecRole.create usuarioInstance, userRole, true
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'usuario.label', default: 'Usuario'), usuarioInstance.username])
                redirect usuarioInstance
            }
            '*' { respond usuarioInstance, [status: CREATED] }
        }
    }

    def edit(Usuario usuarioInstance) {
        respond usuarioInstance
    }

    @Transactional
    def update(Usuario usuarioInstance) {
        if (usuarioInstance == null) {
            notFound()
            return
        }

        if (usuarioInstance.hasErrors()) {
            respond usuarioInstance.errors, view:'edit'
            return
        }
        usuarioInstance.validate()
        usuarioInstance.hasErrors()
        if (params.password2 != params.password){
            usuarioInstance.errors.reject('user.password.doesnotmatch ', 'Las contrase&ntilde;as no coinciden')
            flash.message = "Las contrasenas no coinciden "
            render view: 'edit' , model:[usuarioInstance:usuarioInstance]
            return
        }
        usuarioInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Usuario.label', default: 'Usuario'), usuarioInstance.username])
                redirect usuarioInstance
            }
            '*'{ respond usuarioInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Usuario usuarioInstance) {
        if (usuarioInstance == null) {
            notFound()
            return
        }
		usuarioInstance.enabled = false;
		usuarioInstance.save flush:true
       // usuarioInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Usuario.label', default: 'Usuario'), usuarioInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'usuario.label', default: 'Usuario'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
