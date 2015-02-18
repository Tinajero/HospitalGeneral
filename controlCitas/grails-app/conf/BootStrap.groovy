import controlcitas.*

class BootStrap {
	def springSecurityService
    def init = { servletContext ->
		def adminRole = SecRole.findOrSaveWhere(authority:'ROLE_ADMIN')
		def user = Usuario.findOrSaveWhere(username: 'daniel@gmail.com', password: 'password')
		
		if(!user.authorities.contains(adminRole)){
			SecUserSecRole.create(user,adminRole, true)
		}

    }
    def destroy = {
    }
}
