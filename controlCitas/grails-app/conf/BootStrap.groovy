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
		
		def testUser = new Usuario(username: 'administrador', password: 'password')
		def testUser2 = new Usuario(username: 'maria', password: 'maria')
		def userUser = new Usuario(username: 'usuario', password: 'notiene')
		testUser.save(flush:true)
		testUser2.save(flush:true)
		userUser.save(flush:true)
		
		SecUserSecRole.create testUser, adminRole, true
		SecUserSecRole.create testUser2, adminRole, true
		SecUserSecRole.create userUser, userRole, true
		/*
		assert Usuario.count() == 3
		assert SecRole.count() == 2
		assert SecUserSecRole.count() == 3*/
    }
    def destroy = {
    }
}
