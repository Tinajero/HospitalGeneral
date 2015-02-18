import controlcitas.*

class BootStrap {
	def springSecurityService
    def init = { servletContext ->
//		def adminRole = SecRole.findOrSaveWhere(authority:'ROLE_ADMIN')
//		def user = Usuario.findOrSaveWhere(username: 'daniel@gmail.com', password: 'password')
//		
//		if(!user.authorities.contains(adminRole)){
//			println "creando al Admin"
//			SecUserSecRole.create(user,adminRole, true)
//		} else{
//			println "Ya se creo?"
//			println user
//		}
		def adminRole = new SecRole(authority: 'ROLE_ADMIN').save(flush:true)
		def userRole = new SecRole(authority: 'ROLE_USER').save(flush:true)
		
		def testUser = new Usuario(username: 'daniel@mail.com', password: 'password')
		testUser.save(flush:true)
		
		SecUserSecRole.create testUser, adminRole, true
		
		assert Usuario.count() == 1
		assert SecRole.count() == 2
		assert SecUserSecRole.count() == 1
    }
    def destroy = {
    }
}
